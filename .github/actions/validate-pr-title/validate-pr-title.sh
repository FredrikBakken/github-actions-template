#!/bin/bash
set -euo pipefail

fail() {
  echo "::error::$1"
  exit 1
}

# Validate pr-title input
if [[ -z "${PR_TITLE:-}" ]]; then
  fail "Input 'pr-title' is not set."
fi

# Normalize and validate the types input
TYPES_CLEAN=$(printf '%s' "${TYPES:-}" | tr -d '[:space:]')

if [[ -z "$TYPES_CLEAN" ]]; then
  fail "Input 'types' is not set."
fi

if [[ ! "$TYPES_CLEAN" =~ ^[a-zA-Z0-9_-]+(,[a-zA-Z0-9_-]+)*$ ]]; then
  fail "Input 'types' contains invalid characters. Only alphanumeric characters, underscores, hyphens and commas are allowed."
fi

# Validate the max-length input
if [[ ! "${MAX_LENGTH:-}" =~ ^[0-9]+$ ]] || ((MAX_LENGTH < 1)); then
  fail "Input 'max-length' must be a positive integer."
fi

# Build regex like ^(feat|fix|...)(\(scope\))?!?: .{1,72}$
types_pattern=${TYPES_CLEAN//,/|}  # Replace commas with | for regex
regex="^($types_pattern)(\([a-zA-Z0-9_/-]+\))?!?: .{1,${MAX_LENGTH}}$"

# NOTE: $regex must stay unquoted — quoting makes bash match it literally.
if [[ "$PR_TITLE" =~ $regex ]]; then
  echo "Pull request title follows the Conventional Commits standard."
  exit 0
fi

echo "Title should follow the format: type(scope): description (add '!' before ':' for breaking changes)"
echo "Examples: 'feat(ui): add new button' or 'refactor(core)!: change API response format'"
echo "Valid prefixes: $TYPES_CLEAN"
echo "More information: https://www.conventionalcommits.org/en/v1.0.0/"
fail "Pull request title does not follow the Conventional Commits standard: $PR_TITLE"
