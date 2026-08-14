# Semver and releases — AI agent instructions

Read this before bumping versions or opening PRs for **MythicHandHolding** (same rules apply to SquirrelLove and AHSniper).

---

## Source of truth

| What | Where |
|------|--------|
| Release version | `## Version:` in `MythicHandHolding.toc` |
| In-game `/mhh ping` version | `local VERSION` in `MythicHandHolding.lua` (must match `.toc`) |
| File header banner | `--  MythicHandHolding  vX.Y.Z` in `MythicHandHolding.lua` (must match `.toc`) |
| User-facing notes | `CHANGELOG.md` section for that version |
| Git tag | `vX.Y.Z` (leading `v`, created by CI from the `.toc`) |

**The `.toc` version is bumped in the PR, never by CI.** That is what keeps `main` equal to
what is published on CurseForge. Do not hand-edit the four places above — run the script.

---

## How to bump

From the workspace root (`Z:\SourceCode\Projects\WowAddons`):

```powershell
.\bump-version.ps1 -Addon MythicHandHolding -Part patch -Note "Fix Murder Row boss tip typo."
```

`-Part` is `patch`, `minor`, or `major`. Use `-Version 1.4.0` to set an exact version,
`-DryRun` to preview, and `-Note` more than once for multiple changelog bullets.

The script updates the `.toc`, both version strings in the `.lua`, and inserts a
`CHANGELOG.md` section. Running it with the current version (`-Version <current>`) re-syncs
the copies without cutting a new release, which repairs drift.

---

## Semver rules (MAJOR.MINOR.PATCH)

We use [Semantic Versioning](https://semver.org/) adapted for WoW addons.

### PATCH (+0.0.1) — default for most PRs

Use when behavior is backward-compatible and scope is small:

- Bug fixes (wrong tip text, broken macro, UI glitch)
- Spell/boss ID corrections
- Interface (`## Interface:`) bump only for a new WoW patch
- Doc/README fixes shipped with a rebuild

**Example:** `1.3.0` → `1.3.1`

### MINOR (+0.1.0) — new content or features

Use when adding capability users will notice:

- New dungeon tab(s) or raid boss sections
- New slash commands, settings, or content modes
- Seasonal M+ pool swap only (S1 → S2 dungeons); raids are expansion-scoped, not seasonal

Reset patch to `0` on minor bump.

**Example:** `1.3.1` → `1.4.0`

### MAJOR (+1.0.0) — breaking or structural

Use rarely:

- SavedVariables schema change that resets or migrates user data
- Removed dungeons/features users rely on
- Chat architecture change that invalidates old docs/workflows
- Addon rename or split

**Example:** `1.4.0` → `2.0.0`

---

## Pre-release labels (feature branches only)

On long-lived branches (`alpha/*`, `feature/*`) before merge to `main`:

| Label | When |
|-------|------|
| `X.Y.Z-alpha.N` | Early/experimental (raid alpha, untested IDs) |
| `X.Y.Z-beta.N` | Feature-complete on branch, pre-merge soak |

**On merge to `main`:** drop the suffix and use the next **stable** semver (usually MINOR if the branch added features, PATCH if it only fixed bugs).

**Example:** `1.2.0-alpha.1` on branch → merge as **`1.3.0`** when shipping S2 M+ pool plus expansion raid content together.

Do **not** tag `-alpha` or `-beta` versions for CurseForge/GitHub release; tags are stable only.

---

## Decision flow (pick one per PR)

```
Is the change user-visible on main after merge?
├─ No  → do not bump version (docs-only internal, CI-only)
└─ Yes → will users need a new zip / CurseForge build?
         ├─ No  → optional PATCH note in CHANGELOG only
         └─ Yes → bump PATCH / MINOR / MAJOR (see above)
```

### PR titles are Conventional Commits

PRs are squash-merged, so **the PR title becomes the commit message on `main`** and is what
the changelog is written from. CI rejects a title that does not match:

```
<type>[(scope)][!]: <description>
```

Allowed types: `feat` `fix` `perf` `refactor` `revert` `docs` `style` `test` `build` `ci` `chore`

| PR title | Bump | Version required? |
|----------|------|-------------------|
| `fix: correct Murder Row tip` | PATCH | yes |
| `feat: add Season 3 dungeon pool` | MINOR | yes |
| `feat!: split raids into own addon` | MAJOR | yes |
| `perf:` / `refactor:` / `revert:` | usually PATCH | yes |
| `docs:` `ci:` `chore:` `test:` `style:` `build:` | none | no |

Types that never reach a player's client do not need a version bump. For an exception on a
shipping type, add the **`no-release`** label to the PR.

---

## Release automation

Two workflows, plus the packager:

| Workflow | Trigger | Does |
|----------|---------|------|
| `pr-checks.yml` | PR opened/edited/pushed | Lints the PR title; verifies the version was bumped, that `.toc`/`.lua`/`CHANGELOG.md` agree, and that the version is not already released |
| `release-on-main.yml` | push to `main` | Reads `## Version:` from the `.toc`. If `vX.Y.Z` is untagged, tags it and dispatches the packager. If it is already tagged, does nothing |
| `release.yml` | tag push or dispatch | BigWigs packager builds the zip, creates the GitHub Release, uploads to CurseForge when `CF_API_KEY` is set |

So a merge either releases exactly the version `main` declares, or releases nothing. There is
no CI-side version bumping, which is what previously let `main` drift behind the published
version.

Two GitHub Actions quirks are why the packager is dispatched instead of run inline:

- A tag pushed with `GITHUB_TOKEN` does not trigger `release.yml`.
- The BigWigs packager refuses to build on a branch push, logging `Found future tag ... not packaging`.

**Do not** push tags by hand, and do not tag from a PR branch. Only `main` produces tags.
Pre-release versions (anything with a `-alpha`/`-beta` suffix) are skipped by
`release-on-main.yml`, so they never reach CurseForge.

---

## Agent checklist (every releasable PR)

```
[ ] bump-version.ps1 run (bumps .toc, .lua VERSION, .lua header, CHANGELOG.md)
[ ] Semver choice matches change size (PATCH/MINOR/MAJOR)
[ ] CHANGELOG.md section describes the change in user-facing terms
[ ] PR title is a Conventional Commit and matches the bump size
[ ] deploy-wow-addons.ps1 -WowRoot 'E:\World of Warcraft\_retail_' run for local test (/reload)
[ ] PR description states the new version and bump rationale
```

If `pr-checks.yml` fails, the error message names the fix — usually just re-running
`bump-version.ps1`.

---

## Examples

| Change | PR title | Bump |
|--------|----------|------|
| Fix typo in Murder Row boss tip | `fix: correct Murder Row boss tip` | `1.3.5` → `1.3.6` |
| Add Altar of Fangs spell IDs only | `fix(dungeons): add Altar of Fangs spell IDs` | `1.3.6` → `1.3.7` |
| `## Interface:` bump for a WoW patch | `fix: bump Interface for 12.2` | PATCH |
| Season 3 dungeon pool swap | `feat: Season 3 M+ dungeon pool` | `1.3.x` → `1.4.0` |
| New slash command or settings panel | `feat: add /mhh say mode` | MINOR |
| Split raids into separate addon | `feat!: split raids into own addon` | `1.x` → `2.0.0` |
| Update this document | `docs: clarify bump rules` | none |
| Change a workflow | `ci: dispatch packager at tag` | none |
