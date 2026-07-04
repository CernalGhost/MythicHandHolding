--=====================================================================
--  MythicHandHolding — Raid content (alpha, issue #2)
--  Midnight Season 1: The Voidspire, The Dreamrift, March on Quel'Danas.
--  Verify encounter IDs in-game with /mhh ej while inside each raid.
--  Sources: Wowhead encounter journals, Icy Veins, Method guides.
--=====================================================================

MHH_Raids = {
  journalDiff = 14,  -- Normal raid journal links (dungeons use 23)

  -- Encounter IDs — confirm with /mhh ej; wrong IDs fall back to plain text.
  bossIds = {
    ["Imperator Averzian"]       = 3120,
    ["Vorasius"]                  = 3121,
    ["Fallen-King Salhadaar"]     = 3122,
    ["Vaelgor & Ezzorak"]        = 3123,
    ["Vaelgor"]                   = 3123,
    ["Ezzorak"]                   = 3123,
    ["Lightblinded Vanguard"]    = 3124,
    ["Crown of the Cosmos"]      = 3125,
    ["Alleria Windrunner"]       = 3125,
    ["Chimaerus"]                 = 3126,
    ["Chimaerus, the Undreamt God"] = 3126,
    ["Belo'ren, Child of Al'ar"]  = 3127,
    ["Belo'ren"]                  = 3127,
    ["Midnight Falls"]            = 3128,
    ["L'ura"]                     = 3128,
  },

  spellIds = {
    -- Shared spells already in MythicHandHolding.lua link automatically.
    -- Add verified raid-specific spell IDs here after /mhh ej in each raid.
  },

  raids = {
    ------------------------------------------------------------------
    -- The Voidspire (6 bosses) — tier tokens on bosses 2–5
    ------------------------------------------------------------------
    {
      name = "The Voidspire",
      tab  = "VS",
      tier = "Midnight S1",
      sections = {
        { label = "Interrupts/Dispels",
          title = "=== VOIDSPIRE - INT/DISP ===",
          lines = {
            "INTERRUPT: Pitch Bulwark (Shadowguard Stalwart/Annihilator), Voidbolt (Voidorbs)",
            "DISPEL: Void Marked on Averzian adds (Mythic Cosmic Shell stacks)",
          } },
        { label = "Imperator Averzian",
          boss  = "Imperator Averzian",
          title = "=== IMPERATOR AVERZIAN ===",
          lines = {
            "Tic-tac-toe grid — never let Averzian claim 3 adjacent tiles (March of the Endless = wipe)",
            "Soak Umbral Collapse on Voidshapers — 2 soaks per wave kill 2 adds; 1 tile still claims",
            "Kill Abyssal Voidshaper before 100 energy or it becomes Obsidian Endwalker",
            "Keep boss 10y from claimed tiles (Imperator's Glory = 99% DR) and away from adds on Heroic+",
            "Tank swap Blackening Wounds around 8 stacks",
          } },
        { label = "Vorasius",
          boss  = "Vorasius",
          title = "=== VORASIUS ===",
          lines = {
            "Shadowclaw Slam spawns Void Crystals — walls block the room",
            "Kill Blistercreeps away from other dead creeps; death Blisterburst breaks crystal walls",
            "Break walls BEFORE Void Breath sweeps the room or melee stack for Primordial Roar",
            "Stay in melee range to avoid Primordial Roar raid-wide punishment",
          } },
        { label = "Fallen-King Salhadaar",
          boss  = "Fallen-King Salhadaar",
          title = "=== FALLEN-KING SALHADAAR ===",
          lines = {
            "Boss passively gains energy — at 100% he casts Entropic Unraveling (burn window)",
            "Concentrated Void orbs drift to boss — soak/kill before Void Infusion buffs him",
            "Stagger orb kills; interrupt and CC adds during unraveling",
            "Push damage during Entropic Unraveling while managing orb paths",
          } },
        { label = "Vaelgor & Ezzorak",
          boss  = "Vaelgor & Ezzorak",
          title = "=== VAELGOR & EZZORAK ===",
          lines = {
            "Tank dragons 15y apart; swap when Vaelwing/Rakfang stacks hurt (2–3 stacks)",
            "Void Howl: stack tight so Voidorbs spawn grouped — grip/stun and interrupt Voidbolt",
            "Nullbeam spawns Nullzone — raid snaps tethers immediately; tank snaps LAST (raid DoT)",
            "Alternate Gloom orb soakers on Heroic; never back-to-back same player",
            "100 energy: stack in Radiant Barrier, kill Manifestation of Midnight, spread Shadowmark rings",
          } },
        { label = "Lightblinded Vanguard",
          boss  = "Lightblinded Vanguard",
          title = "=== LIGHTBLINDED VANGUARD ===",
          lines = {
            "Council: Bellamy (Prot), Venel (Ret), Senn (Holy) — shared energy, rotating auras",
            "Focus Venel on pull (Avenging Wrath = takes extra damage); spread Avenger's Shield",
            "Mass Dispel Divine Shield after Bloodlust — bosses counter lust with Divine Shield",
            "Drag boss to room edge before 100 energy; break Senn Sacred Shield + interrupt Blinding Light",
            "Tank swap after Judgment — follow-up can kill off-tank",
          } },
        { label = "Crown of the Cosmos",
          boss  = "Crown of the Cosmos",
          title = "=== CROWN OF THE COSMOS ===",
          lines = {
            "P1: kill Undying Sentinels; aim Silverstrike Arrow to cleanse Void effects",
            "P2: grip adds into Silverstrike Ricochet path; swap Alleria and Rift Simulacrum at end",
            "P3: stack on Alleria; Aspect of the End tethers — break Ranged, then Melee, then Tank",
            "Gravity Collapse on tether break = 300% phys taken 12s — tanks swap around tank break",
            "Devouring Cosmos covers platform — use Dark Rush feathers to next slice; lust in P3",
          } },
        { label = "Tips",
          title = "=== VOIDSPIRE TIPS ===",
          lines = {
            "Tier tokens: Vorasius hands, Salhadaar shoulders, Vaelgor legs, Vanguard helm",
            "Wings unlock staggered — confirm your group's LFR wing before raid night",
          } },
      },
    },

    ------------------------------------------------------------------
    -- The Dreamrift (1 boss)
    ------------------------------------------------------------------
    {
      name = "The Dreamrift",
      tab  = "DR",
      tier = "Midnight S1",
      sections = {
        { label = "Chimaerus",
          boss  = "Chimaerus, the Undreamt God",
          title = "=== CHIMAERUS ===",
          lines = {
            "Alndust Upheaval soak grants Alnsight — only way to see/damage Rift Manifestations",
            "Rotate soak roster — without Alnsight you cannot kill adds; stacks hurt repeat soakers",
            "Kill Manifestations before they reach boss (Cannibalized Essence = +50% boss damage, stacks)",
            "100 energy: boss flies — dodge Corrupted Devastation breath, kill adds before Ravenous Dive",
            "Mythic: Dissonance splits realms (stay in assigned group); Rift Madness needs upstairs rescue",
          } },
        { label = "Tips",
          title = "=== DREAMRIFT TIPS ===",
          lines = {
            "Single-boss raid — no tier tokens; good early-season gear/checkpoint",
            "Roots/slows help control Manifestation movement toward the boss",
          } },
      },
    },

    ------------------------------------------------------------------
    -- March on Quel'Danas (2 bosses)
    ------------------------------------------------------------------
    {
      name = "March on Quel'Danas",
      tab  = "MQD",
      tier = "Midnight S1",
      sections = {
        { label = "Interrupts/Dispels",
          title = "=== QUEL'DANAS - INT/DISP ===",
          lines = {
            "INTERRUPT: Light Blast / Void Blast (Ember adds — matching feather only)",
            "INTERRUPT: Safeguard Matrix channels on L'ura (33% DR each active matrix)",
            "CC matrices with stuns/displacement when interrupts are on cooldown",
          } },
        { label = "Belo'ren",
          boss  = "Belo'ren, Child of Al'ar",
          title = "=== BELO'REN ===",
          lines = {
            "Voidlight Convergence assigns Light Feather or Void Feather — soak YOUR color only",
            "Light Dive / Void Dive: matching players soak; leaves pools + spawns Ember add",
            "Interrupt matching Eruption on Embers; kill egg within 15s or add Rebirths (likely wipe)",
            "Guardian's Edict: matching-color tank soaks frontal or boss gains 30% damage 30s",
            "Egg phase at 0% — real HP bar; Ashen Benediction -10% healing forever each cycle",
          } },
        { label = "Midnight Falls",
          boss  = "Midnight Falls",
          title = "=== MIDNIGHT FALLS (L'URA) ===",
          lines = {
            "P1: Death's Dirge memory game — learn rune order; heal Dusk Crystals into Dawn Crystals",
            "Interrupt/CC Safeguard Matrices; kill crystal spawn adds before cast finishes",
            "Intermission: Galvanize beams to markers hit Void Cores — 4 cores cancel Cosmic Fission pull",
            "P3: Dawn Crystal carriers create safe zones vs Dark Archangel — stack in blue ring",
            "Tank swap Heaven's Lance; avoid Cosmic damage while holding crystals (spawns soak pools)",
          } },
        { label = "Tips",
          title = "=== QUEL'DANAS TIPS ===",
          lines = {
            "Belo'ren teaches Light/Void polarity before the L'ura finale",
            "Hero on pull — Midnight Falls is on a fixed timer; push damage in P1",
          } },
      },
    },
  },
}
