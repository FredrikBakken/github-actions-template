# github-actions-template

Composite GitHub Actions and reusable workflows, published from a template
repository you can fork and make your own.

[![CI](https://github.com/FredrikBakken/github-actions-template/actions/workflows/self-ci.yml/badge.svg)](https://github.com/FredrikBakken/github-actions-template/actions/workflows/self-ci.yml)
[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)

Each action keeps its logic in a shell script beside a thin `action.yml`, so
there is no Node.js build step, no bundled `dist/` to review, and the behaviour
can be read top to bottom. Every input table in the documentation is generated
from the source it describes, so the two cannot drift apart.

<!-- index start -->

## Available actions

| Action | Description |
| :--- | :--- |
| [`pre-commit`](.github/actions/pre-commit/README.md) | Run pre-commit hooks, preferring prek over pre-commit when both are available. |
| [`validate-pr-title`](.github/actions/validate-pr-title/README.md) | Validates that a pull-request title follows the Conventional Commits standard. |

## Reusable workflows

| Workflow | Description |
| :--- | :--- |
| [`reusable-ci-lints`](docs/workflows/reusable-ci-lints.md) | Reusable CI Lints |

<!-- index end -->

## Quick start

Replace `<version>` with a released tag, and `<sha>` with the commit that tag
points to. Both are shown on every generated documentation page.

Run the whole lint gate — pull-request title check and hooks — as one job:

```yaml
name: "CI"

on:
  pull_request:
    types: [opened, reopened, synchronize, edited]

permissions:
  contents: read

jobs:
  lints:
    uses: FredrikBakken/github-actions-template/.github/workflows/reusable-ci-lints.yml@<sha>  # <version>
```

Or reach for a single action when you need to place it among your own steps:

```yaml
- name: "Run pre-commit hooks"
  uses: FredrikBakken/github-actions-template/.github/actions/pre-commit@<sha>  # <version>
  with:
    all-files: "true"
```

The `pre-commit` action expects `prek` or `pre-commit` to already be on `PATH`.
The reusable workflow arranges that for you by running `mise`, so pin `prek` in
your own `mise.toml`.

## Use this repository as a template

Click **Use this template** on GitHub, then work through the checklist:

1. Set `repo-slug` in `.actdocs.toml` to your `owner/repo`. Every generated
   usage snippet is built from it.
2. Set `site_url`, `site_name`, `repo_url` and `copyright` in `zensical.toml`.
3. Rewrite this README's title and opening paragraphs. Leave the region between
   the `index` markers alone — it is regenerated.
4. Review `LICENSE`, and add your own copyright if you are not keeping
   Apache-2.0.
5. In repository settings, enable **GitHub Pages** from the `gh-pages` branch.
   The release workflow deploys the documentation there with `mike`, and the
   first deploy creates that branch.
6. In repository settings, enable **release immutability**. The release
   workflow assumes tags are never moved or reused.
7. Protect `main`. The `no-commit-to-branch` hook already refuses local commits
   to it, and the release workflow triggers on pushes to it.

## Repository layout

```text
.github/
  actions/
    pre-commit/            composite action and its shell script
    validate-pr-title/     composite action and its shell script
  workflows/
    reusable-ci-lints.yml  published, called by other repositories
    self-ci.yml            this repository's own pull-request checks
    self-release.yml       versioning, releases and documentation deploys
docs/                      documentation site sources
  actions/                 generated from each action.yml
  workflows/               generated from each workflow_call interface
.actdocs.toml              documentation generation settings
mise.toml                  pinned tool versions
prek.toml                  hook definitions
zensical.toml              documentation site settings
```

## Conventions

- **Every third-party action is pinned to a commit SHA**, with the human
  readable version in a trailing comment.
- **Commits and pull-request titles follow Conventional Commits.** The release
  workflow derives the next version from them, so the prefix decides whether a
  release happens and how the number changes.
- **Releases are immutable.** A published tag is locked to its commit and its
  name can never be reused, which makes pinning to a tag as strong a guarantee
  as pinning to a SHA.
- **Generated regions are never hand-edited.** Anything between `actdocs`,
  `usage` or `index` markers is rewritten by the hook.

## Local development

Tools are pinned in `mise.toml` and hooks in `prek.toml`.

```sh
mise install          # actionlint, prek and uv at their pinned versions
prek install          # run the hooks on every commit
prek run --all-files  # run them across the repository now
```

`prek` is a faster drop-in replacement for `pre-commit` and reads the same hook
definitions. Either works; the actions and the tooling here prefer `prek`.

## Documentation

The site is built with [Zensical](https://zensical.org) from `docs/`, and
published per version with [mike](https://github.com/jimporter/mike) on every
release.

Reference pages are generated by
[actdocs-rs](https://github.com/FredrikBakken/actdocs-rs) from `action.yml`
files and `workflow_call` interfaces. To add an action or workflow, write the
source and let the hook produce its page — then add the page to `nav` in
`zensical.toml`.

```sh
prek run --all-files actdocs  # regenerate documentation
```

## Releases

Pushes to `main` run `self-release.yml`, which computes the next semantic
version from the commit history, creates the tag and release when there is
something to release, and publishes the documentation for that version.

## License

Apache-2.0. See [`LICENSE`](LICENSE).
