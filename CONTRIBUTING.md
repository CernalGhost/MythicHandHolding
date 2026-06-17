# Contributing to Mythic HandHolding

Thanks for helping improve Mythic HandHolding. This project is open to bug reports, feature ideas, and pull requests.

## Before you start

- Search [existing issues](https://github.com/CernalGhost/MythicHandHolding/issues) to avoid duplicates.
- For gameplay questions, use [Discussions](https://github.com/CernalGhost/MythicHandHolding/discussions) or open an issue with the **question** label.
- Mythic HandHolding is a **retail** addon for Mythic+ party/instance chat callouts.

## Reporting bugs

Use the [bug report template](https://github.com/CernalGhost/MythicHandHolding/issues/new?template=bug_report.yml) and include:

- WoW client version and addon version (`/mhh ping`)
- Dungeon and section where the problem occurs
- Steps to reproduce
- Lua errors if any (`/console scriptErrors 1`, then `/reload`)

## Suggesting features

Use the [feature request template](https://github.com/CernalGhost/MythicHandHolding/issues/new?template=feature_request.yml). New dungeon lines and boss callouts are welcome; include the exact text you want sent to party chat.

## Pull requests

1. Fork the repo and create a branch from `main`.
2. Make focused changes. Match the existing Lua style in `MythicHandHolding.lua`.
3. Test in-game: `/reload`, zone into a tracked dungeon, click sections, verify chat output.
4. Update `CHANGELOG.md` under an `## Unreleased` section (or the next version if you are bumping the `.toc`).
5. Open a PR against `main` and fill out the pull request template.

### WoW addon constraints

- Party/instance chat must stay on **secure action buttons** (user-initiated clicks). Do not replace with `SendChatMessage` from addon code in Mythic+.
- Read `docs-for-ai-agents/README_for_AI_AGENTS.md` in the parent workspace before editing chat/macro architecture (fragile area).

## Development setup

```text
World of Warcraft\_retail_\Interface\AddOns\MythicHandHolding\
  MythicHandHolding.toc
  MythicHandHolding.lua
```

Clone or symlink the repo folder there, `/reload`, and use `/mhh ping` / `/mhh debug`.

## Releases

Maintainers tag versions matching `## Version:` in `MythicHandHolding.toc` (e.g. `v1.0.32`). Pushing a tag runs the GitHub Actions packager and creates a release zip.

## License

By contributing, you agree that your contributions are licensed under the same [MIT License](LICENSE) as the project.
