#!/bin/bash
set -euo pipefail

# prek is a drop-in, much faster replacement for pre-commit, so prefer it and
# fall back to pre-commit only when prek is not on PATH.
if command -v prek >/dev/null 2>&1; then
  runner=prek
elif command -v pre-commit >/dev/null 2>&1; then
  runner=pre-commit
else
  echo "::error::Neither prek nor pre-commit was found on PATH. Install one before this step (e.g. jdx/mise-action, with prek pinned in mise.toml)."
  exit 1
fi

echo "Using $runner"
"$runner" --version

# prek reads prek.toml *or* .pre-commit-config.yaml; pre-commit only understands
# the YAML form. Fail with a useful message instead of pre-commit's opaque one.
if [ "$runner" = "pre-commit" ] && [ ! -f .pre-commit-config.yaml ] && [ ! -f .pre-commit-config.yml ]; then
  echo "::error::pre-commit needs a .pre-commit-config.yaml in $(pwd); only prek can read prek.toml. Install prek, or add a .pre-commit-config.yaml."
  exit 1
fi

# Both runners read the hook ids to skip from $SKIP, so it needs no translation.
if [ -n "$SKIP" ]; then
  echo "::notice::Skipping hooks: $SKIP"
fi

run_args=()
if [ "$ALL_FILES" = "true" ]; then
  run_args+=(--all-files)
fi

# Deliberately unquoted: word-splits on spaces *and* newlines, so both
# `hooks: >-` and `hooks: |` work. The previous `read -ra <<< "$HOOKS"`
# stopped at the first newline and would silently run only one hook.
# shellcheck disable=SC2206
hook_ids=($HOOKS)

# `${a[@]+"${a[@]}"}` rather than plain `"${a[@]}"`: under `set -u`,
# bash 3.2 (still what macOS runners ship) treats an empty array as an
# unbound variable.
if [ "$runner" = "prek" ]; then
  prek run ${run_args[@]+"${run_args[@]}"} ${hook_ids[@]+"${hook_ids[@]}"}
  exit 0
fi

if [ "${#hook_ids[@]}" -eq 0 ]; then
  pre-commit run ${run_args[@]+"${run_args[@]}"}
  exit 0
fi

# Unlike prek, `pre-commit run` accepts at most one hook id, so invoke it once
# per hook and report every failure rather than stopping at the first one.
status=0
for hook_id in "${hook_ids[@]}"; do
  echo "::group::pre-commit run $hook_id"
  pre-commit run ${run_args[@]+"${run_args[@]}"} "$hook_id" || status=1
  echo "::endgroup::"
done
exit "$status"
