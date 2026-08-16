# reusable-ci-lints

Generated from [`.github/workflows/reusable-ci-lints.yml`](../../.github/workflows/reusable-ci-lints.yml).

## Usage

<!-- usage start -->

```yaml
jobs:
  reusable-ci-lints:
    uses: FredrikBakken/github-actions-template/.github/workflows/reusable-ci-lints.yml@<sha>  # <version>
    permissions:
      contents: read
    with:
      # Optional, shown with their defaults
      actions-ref: ""
      actions-repository: ""
      all-files: true
      fetch-depth: 0
      hooks: ""
      install-tools: true
      pr-title: ""
      pr-title-max-length: 72
      pr-title-types: "feat,fix,docs,style,refactor,test,chore"
      ref: ""
      runs-on: "ubuntu-latest"
      skip: ""
      validate-pr-title: true
      working-directory: "."
```

<!-- usage end -->

<!-- actdocs start -->

## Inputs

| Name | Description | Type | Default | Required |
| :--- | :---------- | :--- | :------ | :------: |
| actions-ref | Ref of actions-repository to check out. Empty resolves to the commit of this workflow file, keeping the actions in lockstep with it. | `string` | `` | no |
| actions-repository | Repository holding the composite actions. Empty resolves to the repository this workflow lives in. | `string` | `` | no |
| all-files | Run against every file in the repo. Defaults to true because a CI checkout has nothing staged to run against. | `boolean` | `true` | no |
| fetch-depth | Number of commits to fetch. 0 fetches the full history, which hooks that diff against a base branch need. | `number` | `0` | no |
| hooks | Optional whitespace-separated list of hook ids to run. Leave empty to run every configured hook — preferred, because an explicit list silently drifts as the config changes. To exclude a few hooks, use `skip` instead. | `string` | `` | no |
| install-tools | Install the tools pinned in the caller's mise.toml or .tool-versions. Disable when prek or pre-commit reaches PATH some other way. | `boolean` | `true` | no |
| pr-title | Title to validate. Empty uses the title of the pull request that triggered the calling workflow. | `string` | `` | no |
| pr-title-max-length | Maximum length of the pull-request title. | `number` | `72` | no |
| pr-title-types | Comma-separated list of allowed Conventional Commit types. | `string` | `feat,fix,docs,style,refactor,test,chore` | no |
| ref | Ref to check out. Empty checks out the ref that triggered the calling workflow. | `string` | `` | no |
| runs-on | Runner label the job executes on. | `string` | `ubuntu-latest` | no |
| skip | Comma-separated hook ids to skip. Use this for hooks whose tooling this job does not install. | `string` | `` | no |
| validate-pr-title | Check the pull-request title against the Conventional Commits standard. Ignored on events other than pull_request. | `boolean` | `true` | no |
| working-directory | Directory containing the hook config (prek.toml or .pre-commit-config.yaml), relative to the workspace. | `string` | `.` | no |

## Permissions

| Scope | Access |
| :--- | :---- |
| contents | read |

<!-- actdocs end -->
