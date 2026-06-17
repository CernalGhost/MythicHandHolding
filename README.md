# Mythic HandHolding

A World of Warcraft **retail** addon for **Midnight Season 1 Mythic+**. One compact window, one click per party-chat callout — interrupts, boss mechanics, and dungeon tips.

**Author:** CernalGhost  
**Version:** 1.0.32  
**Slash command:** `/mhh` or `/mythichandholding`

---

## What it does

- Movable panel (~224px wide) with a **dungeon dropdown** (eight tracked instances).
- Section buttons for **Interrupts/Dispels**, each **boss**, and **Tips**.
- Each click sends **one line** to party or instance chat (user-initiated secure macro — required in M+).
- Multi-line sections **cycle** on repeated clicks; badge shows `0/N` … `N/N`.
- **Auto-selects** the dungeon when you zone into a tracked instance and can pop the window open.
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
| `/mhh debug` | Verbose macro dump on click |
| `/mhh auto` | Re-detect instance and switch dungeon |
| `/mhh minimap` | Show/hide minimap button |
| `/mhh reset` | Recenter window |

**Multi-line sections:** click until the badge completes a full cycle (tooltip lists lines).

## Options (in-window)

- **Test Mode** — echo locally, no broadcast
- **Plain Text** — no spell/journal links (default on; safest for live)
- **Debug** — diagnostic messages in chat

## Requirements

- Retail WoW (The War Within / Midnight). Not for Classic flavors.
- Designed for **Mythic+ party/instance chat**. Uses secure action buttons; do not replace with `SendChatMessage` from addon code.

## Development

AI/developer notes for this addon live in the parent workspace:  
`docs-for-ai-agents/README_for_AI_AGENTS.md` (chat architecture is fragile — read before editing).

## License

MIT — see [LICENSE](LICENSE).
