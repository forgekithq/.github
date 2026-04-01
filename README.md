# .github

Community health files and organization profile for [Forgekit](https://forgekithq.dev).

This repository contains:

- **Reusable Workflows** (`.github/workflows/`) — shared CI/CD pipelines
- **Workflow Templates** (`workflow-templates/`) — starters for new repos
- **Organization profile** (`profile/README.md`) — displayed on [github.com/forgekithq](https://github.com/forgekithq)
- **Issue templates** — standardized bug reports and feature requests
- **PR template** — consistent pull request format
- **Community health files** — contributing guide, code of conduct, security policy

These files are inherited by all repositories in the `forgekithq` organization that don't define their own.

---

## Reusable Workflows

Shared CI/CD pipelines that any repo in the org can call.

### `ci.yml` — Lint, Typecheck, Test, Build

```yaml
# .github/workflows/ci.yml in your repo
name: CI
on:
  push:
    branches: [main]
  pull_request:

jobs:
  ci:
    uses: forgekithq/.github/.github/workflows/ci.yml@main
    with:
      node-version: 22       # default: 22
      # package-manager: npm  # npm | pnpm (default: npm)
      # lint-command: 'npx biome check .'  # empty = skip
      # astro-check: true     # use astro check instead of tsc
      # typecheck-command: 'npx tsc --noEmit'  # ignored if astro-check
      # test-command: 'npm test'  # empty = skip
      # build-command: 'npm run build'
```

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `node-version` | number | `22` | Node.js version |
| `package-manager` | string | `npm` | `npm` or `pnpm` |
| `lint-command` | string | `''` | Lint command (empty = skip) |
| `typecheck-command` | string | `npx tsc --noEmit` | Typecheck (ignored if `astro-check`) |
| `astro-check` | boolean | `false` | Use `astro check` for typecheck |
| `test-command` | string | `npm test` | Test command (empty = skip) |
| `build-command` | string | `npm run build` | Build command |

### `deploy-cf-pages.yml` — Cloudflare Pages Deploy

```yaml
# .github/workflows/deploy.yml in your repo
name: Deploy
on:
  push:
    branches: [main]

jobs:
  ci:
    uses: forgekithq/.github/.github/workflows/ci.yml@main
    with:
      astro-check: true  # adjust per project

  deploy:
    needs: ci
    uses: forgekithq/.github/.github/workflows/deploy-cf-pages.yml@main
    with:
      project-name: brand-site  # required
    secrets: inherit
```

> **Note**: Use `secrets: inherit` instead of explicit secrets. The reusable workflow
> must NOT declare a `permissions` block (it causes `startup_failure`).

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `project-name` | string | **required** | Cloudflare Pages project name |
| `node-version` | number | `22` | Node.js version |
| `build-command` | string | `npm run build` | Build command |
| `output-directory` | string | `dist/` | Build output directory |

### `deploy-cf-workers.yml` — Cloudflare Workers Deploy

```yaml
jobs:
  deploy:
    uses: forgekithq/.github/.github/workflows/deploy-cf-workers.yml@main
    with:
      wrangler-command: deploy  # default
    secrets: inherit
```

### `release-npm.yml` — npm Publish + GitHub Release

```yaml
# Triggered on tag push (e.g., v1.0.0)
jobs:
  release:
    uses: forgekithq/.github/.github/workflows/release-npm.yml@main
    with:
      build-command: npm run build
    secrets: inherit
```
