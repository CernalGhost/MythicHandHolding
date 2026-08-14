# Semver and releases — AI agent instructions

Read this before bumping versions or opening PRs for **MythicHandHolding** (same rules apply to SquirrelLove and AHSniper).

---

## Source of truth

| What | Where |
|------|--------|
| Release version | `## Version:` in `MythicHandHolding.toc` |
| In-game `/mhh ping` version | `local VERSION` in `MythicHandHolding.lua` (must match `.toc`) |
| User-facing notes | `CHANGELOG.md` top section for that version |
| Git tag | `vX.Y.Z` (leading `v`, must match `.toc`) |

**Always bump all three** (`.toc`, `.lua` `VERSION`, `CHANGELOG.md`) in the same PR when the change is releasable.

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

### Tie to GitHub issues/PRs

| PR type | Typical bump |
|---------|----------------|
| `fix:` / bug report | PATCH |
| `feat:` / feature request / new dungeon | MINOR |
| Interface-only TOC for new WoW patch | PATCH |
| Breaking refactor | MAJOR |

Add `CHANGELOG.md` under the **new** version heading in the same PR. Do not leave changes under `Unreleased` once version is bumped.

---

## Release automation

After merge to `main`:

1. **Auto-tag** — `.github/workflows/tag-from-toc.yml` runs on **every** push to `main`. Reads `## Version:` from `MythicHandHolding.toc`. If `vX.Y.Z` already exists, CI auto-bumps **PATCH** on a release-only commit and pushes the **tag** (not `main` — branch protection safe).
2. **Package** — `.github/workflows/release.yml` runs on tag push; BigWigs packager builds zip, creates GitHub Release, uploads to CurseForge when `CF_API_KEY` is set.

**Maintainers:** bump `.toc` + `.lua` in the PR when you want a specific MINOR/MAJOR. Every merge to `main` releases — if you forget to bump, CI bumps PATCH so CurseForge still updates.

**Do not** push tags from PR branches; only `main` should produce release tags.

---

## Agent checklist (every releasable PR)

```
[ ] ## Version: bumped in MythicHandHolding.toc
[ ] local VERSION matches .toc in MythicHandHolding.lua
[ ] CHANGELOG.md has section for that version
[ ] Semver choice matches change size (PATCH/MINOR/MAJOR)
[ ] deploy-wow-addons.ps1 run for local test (/reload)
[ ] PR description states the new version and bump rationale
```

---

## Examples

| Change | Bump |
|--------|------|
| Fix typo in Murder Row boss tip | `1.3.0` → `1.3.1` |
| Add Altar of Fangs spell IDs only | `1.3.1` → `1.3.2` |
| Season 3 dungeon pool swap | `1.3.x` → `1.4.0` |
| Say Mode feature | `1.1.x` → `1.2.0` (minor) |
| Split raids into separate addon | `1.x` → `2.0.0` |
