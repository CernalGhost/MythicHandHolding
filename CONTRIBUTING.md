# Contributing to Mythic Hand Holding

Thanks for helping improve Mythic Hand Holding. This project is open to bug reports, feature ideas, and pull requests.

## Before you start

- Search [existing issues](https://github.com/CernalGhost/MythicHandHolding/issues) to avoid duplicates.
- For gameplay questions, use [Discussions](https://github.com/CernalGhost/MythicHandHolding/discussions) or open an issue with the **question** label.
- Mythic Hand Holding is a **retail** addon for Mythic+ party/instance chat callouts.

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

The version is bumped **in the PR**, so `main` always matches what is on CurseForge.

1. Bump the version from the workspace root:

   ```powershell
   .\bump-version.ps1 -Addon MythicHandHolding -Part patch -Note "What changed, in user terms."
   ```

   `-Part` is `patch`, `minor`, or `major`. This updates `MythicHandHolding.toc`,
   both version strings in `MythicHandHolding.lua`, and `CHANGELOG.md` together.
2. Give the PR a [Conventional Commit](https://www.conventionalcommits.org/) title
   (`fix: …`, `feat: …`, `feat!: …`) — PRs are squash-merged, so the title lands on `main`.
   CI rejects titles that do not match.
3. Merge to `main`. `release-on-main.yml` tags the version from the `.toc` and dispatches the
   packager, which creates the GitHub Release and uploads to CurseForge.

`docs:`, `ci:`, `chore:`, `test:`, `style:` and `build:` PRs do not need a version bump. For an
exception on any other type, add the `no-release` label.

If the version on `main` is already tagged, the merge releases nothing — that is the intended
"no release" path, not a failure.

Semver rules and the AI agent checklist: `docs/SEMVER_AND_RELEASES_for_AI_AGENTS.md`.

## License

By contributing, you agree that your contributions are licensed under the same [MIT License](LICENSE) as the project.
