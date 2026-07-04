# Mythic Hand Holding - Changelog

## 1.1.0-alpha.2 (issue #2 — raids alpha)

- **Sporefall** (patch 12.0.7): Rotmire single-boss raid with Normal/Heroic/Mythic tip variants.
- **Raid difficulty UI:** LFR / N / H / M buttons; auto-detects when you zone into a raid.
- **Difficulty-specific tips:** `extraByDiff` lines append for the active difficulty; journal links use it too.
- **Adventure Guide dumps (no need to be inside the raid):**
  - `/mhh ej list` — list raid instances
  - `/mhh ej <name|id>` — boss encounter IDs
  - `/mhh ej spells <boss|id>` — ability spell IDs
  - `/mhh ej diff` / `/mhh diff` — set journal difficulty for dumps and callouts

## 1.1.0-alpha.1 (issue #2 — raids alpha)

- **Raid mode (alpha):** M+ / Raid toggle in the window; auto-selects raids on zone-in.
- **Midnight S1 raids:** The Voidspire (6 bosses), The Dreamrift (Chimaerus), March on Quel'Danas (Belo'ren, Midnight Falls).
- **Data split:** `MythicHandHolding_Raids.lua` holds raid tips, boss encounter IDs, and future tier packs.
- **New commands:** `/mhh mplus`, `/mhh raid` switch content mode.
- Encounter/spell IDs are placeholders until verified with `/mhh ej`.

## 1.0.36

- Set `X-Curse-Project-ID` so GitHub Actions can upload releases to CurseForge.

## 1.0.35

- Renamed display title to **Mythic Hand Holding** (addon list, window, minimap
  tooltip). Folder and slash commands unchanged (`MythicHandHolding`, `/mhh`).

## 1.0.34

- Bumped `## Interface:` for retail 12.0.7 (`120007`) and PTR 12.1.0
  (`120100`).

## 1.0.33

- Fix multi-line section cycling in Test Mode (line index was not advancing).

## 1.0.32

- Line badges show lines sent (`0/N` until clicked) instead of next line index.

## 1.0.31

- Line badge shows `current/total` on multi-line sections; dropdown width fix.

## 1.0.30

- `EnsureDB()` before UI build; layout fixes for empty panel / nil clickCounts.

## 1.0.29

- Compact ~224px UI, dungeon dropdown, click counters in tooltips.

## 1.0.27

- WoW 11.0+ macro-chaining ban: one `/p` per click; cycle multi-line sections on repeat clicks.

## 1.0.22

- Party chat via `SecureActionButtonTemplate` macrotext (SendChatMessage blocked in keys).

## 1.0.11

- Minimap button, default-hidden window, auto-open on zone-in to tracked dungeons.

## 1.0.1

- Initial release: eight Midnight Season 1 M+ dungeons, interrupt/dispel and boss callouts.
