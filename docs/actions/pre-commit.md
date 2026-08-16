# pre-commit

Generated from [`.github/actions/pre-commit/action.yml`](../../.github/actions/pre-commit/action.yml).

## Usage

<!-- usage start -->

```yaml
- name: "pre-commit"
  uses: FredrikBakken/github-actions-template/.github/actions/pre-commit@<sha>  # <version>
  with:
    # Optional, shown with their defaults
    all-files: "false"
    hooks: ""
    skip: ""
    working-directory: "."
```

<!-- usage end -->

<!-- actdocs start -->

## Description

Run pre-commit hooks, preferring prek over pre-commit when both are available.

## Inputs

| Name | Description | Default | Required |
| :--- | :---------- | :------ | :------: |
| all-files | Run against every file in the repo rather than only staged files. | `false` | no |
| hooks | Optional whitespace-separated list of hook ids to run. Leave empty to run every configured hook — preferred, because an explicit list silently drifts as the config changes. To exclude a few hooks, use `skip` instead. | `` | no |
| skip | Comma-separated hook ids to skip, passed to the runner as the SKIP environment variable. Use this for hooks whose tooling this job does not install. | `` | no |
| working-directory | Directory containing the hook config (prek.toml or .pre-commit-config.yaml), relative to the workspace. | `.` | no |

<!-- actdocs end -->
