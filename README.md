# Mythic Hand Holding

A World of Warcraft **retail** addon for **Midnight Season 1** Mythic+ and raids. One compact window, one click per party/raid chat callout — interrupts, boss mechanics, and tips.

**Author:** CernalGhost  
**Version:** 1.1.0-alpha.2  
**Slash command:** `/mhh` or `/mythichandholding`  
**Download:** [CurseForge](https://www.curseforge.com/wow/addons/mythic-hand-holding/preview) · [GitHub](https://github.com/CernalGhost/MythicHandHolding)

---

## What it does

- Movable panel (~224px wide) with **M+ / Raid** mode toggle and content dropdown.
- **Mythic+:** eight Season 1 dungeons (Interrupts/Dispels, bosses, tips).
- **Raids (alpha):** Midnight S1 — The Voidspire (6), The Dreamrift (1), March on Quel'Danas (2), Sporefall / Rotmire (12.0.7).
- **Raid difficulty:** LFR / Normal / Heroic / Mythic buttons; auto-detects in-raid; difficulty-only tips via `extraByDiff`.
- Each click sends **one line** to party or instance/raid chat (secure macro — one line per click).
- Multi-line sections **cycle** on repeated clicks; badge shows `0/N` … `N/N`.
- **Auto-selects** dungeon or raid when you zone into a tracked instance.
- **Minimap button** (default hidden until you use `/mhh` or zone in); draggable around the rim.
## Install

1. Copy the `MythicHandHolding` folder to  
   `World of Warcraft\_retail_\Interface\AddOns\MythicHandHolding\`
2. `/reload`
3. `/mhh ping` — should print version

Enable **Load out of date AddOns** if the Interface number lags a patch.

## Usage

| Command | Action |
|---------|--------|
| `/mhh` | Toggle window |
| `/mhh ping` | Version / alive check |
| `/mhh test` | Local echo only (no party chat) |
| `/mhh plain` | Toggle spell/boss hyperlinks in chat |
| `/mhh say` | Toggle Say Mode (broadcast to `/s` instead of party/instance) |
| `/mhh debug` | Verbose macro dump on click |
| `/mhh auto` | Re-detect instance and switch content |
| `/mhh mplus` | Switch to Mythic+ dungeon list |
| `/mhh raid` | Switch to raid list |
| `/mhh diff n\|h\|m\|lfr` | Set raid difficulty (journal links + tips) |
| `/mhh ej help` | Adventure Guide ID dumps (works outside raids) |
| `/mhh minimap` | Show/hide minimap button |
| `/mhh reset` | Recenter window |

**Multi-line sections:** click until the badge completes a full cycle (tooltip lists lines).

## Options (in-window)

- **Test Mode** — echo locally, no broadcast
- **Plain Text** — no spell/journal links (default on; safest for live)
- **Debug** — diagnostic messages in chat

## Requirements

- Retail WoW (The War Within / Midnight). Not for Classic flavors.
- Designed for **Mythic+ and raid** party/instance chat. Uses secure action buttons; do not replace with `SendChatMessage` from addon code.

## Raids alpha (issue #2)

Raid data lives in `MythicHandHolding_Raids.lua`. Fill IDs from the **Adventure Guide** without entering the raid:

```
/mhh ej list                 -- raid instance list + EJ IDs
/mhh ej sporefall            -- boss encounter IDs for Sporefall
/mhh ej spells Rotmire       -- ability spell IDs (uses active difficulty)
/mhh ej diff mythic          -- dump Mythic journal sections
```

Paste encounter lines into `MHH_Raids.bossIds` and spell lines into `spellIds` or `spellIdsByDiff[16]`. Plain Text defaults ON until IDs are verified.

## Development

AI/developer notes for this addon live in the parent workspace:  
`docs-for-ai-agents/README_for_AI_AGENTS.md` (chat architecture is fragile — read before editing).

## Contributing

Bug reports, feature ideas, and pull requests are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
