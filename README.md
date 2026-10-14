# Mythic Hand Holding

A World of Warcraft addon for **Midnight Season 2 Mythic+** and **Midnight raids** on retail, plus **raid tips for every Classic client** (Classic Era, TBC Anniversary, MoP Classic). One compact window, one click per party/raid chat callout — interrupts, boss mechanics, and tips.

**Author:** CernalGhost  
**Version:** 1.6.0  
**Slash command:** `/mhh` or `/mythichandholding`  
**Download:** [CurseForge](https://www.curseforge.com/wow/addons/mythic-hand-holding/preview) · [GitHub](https://github.com/CernalGhost/MythicHandHolding)

---

## What it does

- Movable panel (~224px wide) with **M+ / Raid** mode toggle and content dropdown.
- **Mythic+:** eight Season 2 dungeons (Altar of Fangs, Murder Row, Den of Nalorakk, The Blinding Vale, Voidscar Arena, King's Rest, Temple of Sethraliss, Ruby Life Pools).
- **Raids (alpha):** Midnight expansion — The Voidspire (6), The Dreamrift (1), March on Quel'Danas (2), Sporefall / Rotmire (12.0.7).
- **Raid difficulty (retail):** LFR / Normal / Heroic / Mythic buttons; auto-detects in-raid; difficulty-only tips via `extraByDiff`.
- **Classic raids:** the addon picks the pack for the client it runs on:
  - **Classic Era / Hardcore:** Molten Core, Onyxia's Lair, Blackwing Lair, Zul'Gurub, Ruins of Ahn'Qiraj, Temple of Ahn'Qiraj, Naxxramas.
  - **TBC Anniversary:** Karazhan, Gruul's Lair, Magtheridon's Lair, Serpentshrine Cavern, Tempest Keep, Hyjal Summit, Black Temple, Zul'Aman, Sunwell Plateau.
  - **MoP Classic:** Mogu'shan Vaults, Heart of Fear, Terrace of Endless Spring, Throne of Thunder, Siege of Orgrimmar.
  - **WoW Forever:** uses the Classic Era pack until its own raids are known.
- Each click sends **one line** to group chat (secure macro — one line per click): `/i` in instance groups, `/ra` in raids, `/p` in parties.
- Multi-line sections **cycle** on repeated clicks; badge shows `0/N` … `N/N`.
- **Auto-selects** dungeon or raid when you zone into a tracked instance.
- **Minimap button** (default hidden until you use `/mhh` or zone in); draggable around the rim.
## Install

1. Copy the `MythicHandHolding` folder into the `Interface\AddOns\` folder of your client:

   | Client | Folder |
   |---|---|
   | Retail | `World of Warcraft\_retail_\` |
   | MoP Classic | `World of Warcraft\_classic_\` |
   | TBC Anniversary | `World of Warcraft\_anniversary_\` |
   | Classic Era / Hardcore / SoD | `World of Warcraft\_classic_era_\` |
   | WoW Forever | not final yet (beta uses `_classic_beta_`) |

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

## Requirements and client limits

One `.toc` loads on every client (`## Interface: 120105, …, 50504, 20506, 16001, 11509`).

| Client | Content | Links | Chat limits |
|---|---|---|---|
| Retail (Midnight) | M+ dungeons + Midnight raids | Spell + Adventure Guide links (Plain Text off) | Addon Lua chat is blocked in instances. Click-to-send macros still work, but WoW throttles them during encounters and Mythic+ — send key tips before the timer starts. |
| MoP Classic | MoP raids | Plain text (Dungeon Journal IDs not filled yet) | No Midnight-style lockdown found. |
| TBC Anniversary | TBC raids (Zul'Aman unlocks 2026-10-22, Sunwell later) | Plain text (no Encounter Journal) | Party/raid chat unrestricted. |
| Classic Era / Hardcore | Vanilla raids | Plain text (no Encounter Journal) | Party/raid chat unrestricted. Season of Discovery raids aren't covered yet. |
| WoW Forever (launches 2026-11-04) | Classic Era pack for now | Plain text | Runs on the retail engine, so Midnight addon restrictions apply. |

- No Mythic+ tab or LFR/N/H/M buttons on Classic clients.
- Uses secure action buttons for chat; do not replace with `SendChatMessage` from addon code.

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

Classic raid packs: `MythicHandHolding_Vanilla.lua`, `MythicHandHolding_TBC.lua`, `MythicHandHolding_Mists.lua` (same shape as `MHH_Raids.raids`, plus `mapId` for auto-open). Run `python check_raids.py` after editing.

Helpful tooling for WoW API questions across clients:
- [Nighthawk42/wow_api_mcp](https://github.com/Nighthawk42/wow_api_mcp): an MCP server covering every client's API docs and FrameXML, with flavor diffs. It's new, so pin the version: `claude mcp add wow-api -- npx -y @nighthawk42/wow-api-mcp@0.2.0`
- [Ketho's vscode-wow-api](https://github.com/Ketho/vscode-wow-api): LuaLS annotations for editor autocomplete.

AI/developer notes for this addon live in the parent workspace:  
`docs-for-ai-agents/README_for_AI_AGENTS.md` (chat architecture is fragile — read before editing).

## Contributing

Bug reports, feature ideas, and pull requests are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
