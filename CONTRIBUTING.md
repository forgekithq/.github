# Contributing to Forgekit

Thanks for your interest in contributing. Here's how to get started.

## Workflow

1. **Fork** the repository
2. **Create a branch** from `main` (`git checkout -b feat/my-feature`)
3. **Write tests first**, then implement
4. **Run checks** before committing:
   ```bash
   npm test
   npm run typecheck
   npm run lint
   ```
5. **Open a PR** using the provided template

## Guidelines

- Keep PRs focused — one feature or fix per PR
- Write tests for new functionality (target 80%+ coverage)
- Follow existing code style (Biome handles formatting)
- Use [conventional commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, etc.

## Questions?

Open an issue or email [forgekithq@proton.me](mailto:forgekithq@proton.me).
