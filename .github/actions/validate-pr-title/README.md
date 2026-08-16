# validate-pr-title

## Usage

<!-- usage start -->

```yaml
- name: "validate-pr-title"
  uses: FredrikBakken/github-actions-template/.github/actions/validate-pr-title@<sha>  # <version>
  with:
    # Required
    pr-title: ""
    # Optional, shown with their defaults
    max-length: "72"
    types: "feat,fix,docs,style,refactor,test,chore"
```

<!-- usage end -->

<!-- actdocs start -->

## Description

Validates that a pull-request title follows the Conventional Commits standard.

## Inputs

| Name | Description | Default | Required |
| :--- | :---------- | :------ | :------: |
| pr-title | The pull-request title to validate. | n/a | yes |
| max-length | The maximum length of the title. | `72` | no |
| types | A comma-separated list of allowed types. | `feat,fix,docs,style,refactor,test,chore` | no |

<!-- actdocs end -->
