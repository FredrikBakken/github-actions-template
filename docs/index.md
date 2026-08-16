# Introduction

Composite GitHub Actions and reusable workflows, published from a template
repository you can fork and make your own.

Each action keeps its logic in a shell script beside a thin `action.yml`. There
is no Node.js build step and no bundled `dist/` to review, so the behaviour can
be read top to bottom in the repository that runs it.
