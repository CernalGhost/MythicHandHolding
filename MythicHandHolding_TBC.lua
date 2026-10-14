--=====================================================================
--  MythicHandHolding — Burning Crusade Classic (Anniversary) raid pack.
--  Used when the TOC version is 2xxxx.  Same shape as MHH_Raids.raids;
--  mapId = GetInstanceInfo() instanceID for auto-open.  No Encounter
--  Journal on this client: tips go out as plain text.
--=====================================================================

MHH_Classic = MHH_Classic or {}

MHH_Classic.tbc = {
  raids = {
    ------------------------------------------------------------------
    {
      name  = "Karazhan",
      tab   = "Kara",
      tier  = "TBC T4",
      mapId = 532,
      sections = {
        { label = "Attumen", boss = "Attumen the Huntsman",
          title = "=== ATTUMEN THE HUNTSMAN ===",
          lines = {
            "Tank Midnight first; Attumen mounts up at 25%",
            "Nobody in front — Shadow Cleave",
            "Decurse Intangible Presence",
          } },
        { label = "Moroes", boss = "Moroes",
          title = "=== MOROES ===",
          lines = {
            "CC the guests (shackle, sheep, trap) and kill them in the called order",
            "Garrote bleed: Ice Block/Divine Shield/Cloak of Shadows clears it",
            "Gouge stuns the tank — second tank stays next on threat",
          } },
        { label = "Maiden", boss = "Maiden of Virtue",
          title = "=== MAIDEN OF VIRTUE ===",
          lines = {
            "Casters and healers spread around the room, outside Holy Ground",
            "Repentance stuns everyone — HoT the tank beforehand",
            "Dispel Holy Fire",
          } },
        { label = "Opera", boss = "Opera Event",
          title = "=== OPERA EVENT ===",
          lines = {
            "Big Bad Wolf: Little Red Riding Hood runs the edge of the stage — don't get in the way",
            "Romulo & Julianne: in the last phase both must die within 10s",
            "Wizard of Oz: kill Dorothee first, burn the Strawman with fire; the Crone comes last",
          } },
        { label = "Curator", boss = "The Curator",
          title = "=== THE CURATOR ===",
          lines = {
            "Kill each Astral Flare fast",
            "Evocation: he takes 200% damage — all cooldowns",
            "Hateful Bolt hits the 2nd-highest threat — keep the off-tank topped",
          } },
        { label = "Shade of Aran", boss = "Shade of Aran",
          title = "=== SHADE OF ARAN ===",
          lines = {
            "Flame Wreath: DO NOT MOVE",
            "Arcane Explosion: run out of melee range",
            "Interrupt his casts; at 40% he summons Water Elementals",
          } },
        { label = "Illhoof", boss = "Terestian Illhoof",
          title = "=== TERESTIAN ILLHOOF ===",
          lines = {
            "Sacrifice: kill the Demon Chains to free the player",
            "AoE the imps; kill Kil'rek for the damage-taken debuff on the boss",
          } },
        { label = "Netherspite", boss = "Netherspite",
          title = "=== NETHERSPITE ===",
          lines = {
            "Block beams: red = tank, green = healer, blue = DPS",
            "Rotate soakers before Nether Exhaustion stacks",
            "Banish phase: spread and stay out of Netherbreath",
          } },
        { label = "Prince", boss = "Prince Malchezaar",
          title = "=== PRINCE MALCHEZAAR ===",
          lines = {
            "Enfeeble (1 HP): get away from him before Shadow Nova",
            "Avoid the falling Infernals and their fire",
            "P3: axes fly at random players — heal through, Amplify Damage on tank",
          } },
        { label = "Nightbane", boss = "Nightbane",
          title = "=== NIGHTBANE ===",
          lines = {
            "Nobody in front (breath) or behind (tail)",
            "Air phase: AoE the skeletons, move out of Charred Earth",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Gruul's Lair",
      tab   = "Gruul",
      tier  = "TBC T4",
      mapId = 565,
      sections = {
        { label = "Maulgar", boss = "High King Maulgar",
          title = "=== HIGH KING MAULGAR ===",
          lines = {
            "Kill order: Blindeye, Olm, Kiggler, Krosh, Maulgar",
            "Interrupt Blindeye's Prayer of Healing",
            "Mage tanks Krosh (Spellsteal his Spell Shield); warlock handles Olm's felhunters",
          } },
        { label = "Gruul", boss = "Gruul the Dragonkiller",
          title = "=== GRUUL THE DRAGONKILLER ===",
          lines = {
            "After Ground Slam: SPREAD before Shatter",
            "Move out of Cave In",
            "Hurtful Strike hits the 2nd-highest threat in melee — off-tank there",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Magtheridon's Lair",
      tab   = "Mag",
      tier  = "TBC T4",
      mapId = 544,
      sections = {
        { label = "Magtheridon", boss = "Magtheridon",
          title = "=== MAGTHERIDON ===",
          lines = {
            "P1: kill the 5 Hellfire Channelers; interrupt Dark Mending",
            "5 players click the Manticron Cubes together on every Blast Nova",
            "30%: the ceiling collapses — move out of falling debris",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Serpentshrine Cavern",
      tab   = "SSC",
      tier  = "TBC T5",
      mapId = 548,
      sections = {
        { label = "Hydross", boss = "Hydross the Unstable",
          title = "=== HYDROSS THE UNSTABLE ===",
          lines = {
            "Frost-resist and nature-resist tanks swap when he crosses the line",
            "Kill the adds that spawn on each switch",
          } },
        { label = "Lurker", boss = "The Lurker Below",
          title = "=== THE LURKER BELOW ===",
          lines = {
            "Spout: jump in the water",
            "Whirl: melee back off",
            "Submerge: kill the adds on the platforms",
          } },
        { label = "Leotheras", boss = "Leotheras the Blind",
          title = "=== LEOTHERAS THE BLIND ===",
          lines = {
            "Inner Demon: kill YOUR demon fast",
            "Whirlwind: everyone away from him",
            "Demon form: warlock tank",
          } },
        { label = "Karathress", boss = "Fathom-Lord Karathress",
          title = "=== FATHOM-LORD KARATHRESS ===",
          lines = {
            "Kill the advisors first; interrupt Caribdis's heals",
            "Kill Tidalvess's totems on sight",
          } },
        { label = "Morogrim", boss = "Morogrim Tidewalker",
          title = "=== MOROGRIM TIDEWALKER ===",
          lines = {
            "Earthquake brings murlocs — AoE them",
            "Dodge the Water Globules; heal Watery Grave targets",
          } },
        { label = "Vashj", boss = "Lady Vashj",
          title = "=== LADY VASHJ ===",
          lines = {
            "P1: Static Charge on you — move away from others",
            "P2: kill the Tainted Elemental, pass the Tainted Core to the shield generator",
            "P2: kite the Striders, slow-kill Enchanted Elementals before they reach her",
            "P3: dodge the Toxic Sporebat clouds",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Tempest Keep",
      tab   = "TK",
      tier  = "TBC T5",
      mapId = 550,
      sections = {
        { label = "Al'ar", boss = "Al'ar",
          title = "=== AL'AR ===",
          lines = {
            "P1: Flame Quills — get off the platform",
            "Embers explode when killed",
            "P2: dodge Dive Bomb and Flame Patches",
          } },
        { label = "Void Reaver", boss = "Void Reaver",
          title = "=== VOID REAVER ===",
          lines = {
            "Ranged spread and move from Arcane Orbs",
            "Knock Away drops threat — off-tank next",
          } },
        { label = "Solarian", boss = "High Astromancer Solarian",
          title = "=== HIGH ASTROMANCER SOLARIAN ===",
          lines = {
            "Wrath of the Astromancer: run out of the raid",
            "Kill the agents and priestesses when she vanishes",
            "P3 (20%): voidwalker form — burn",
          } },
        { label = "Kael'thas", boss = "Kael'thas Sunstrider",
          title = "=== KAEL'THAS SUNSTRIDER ===",
          lines = {
            "Advisors: Thaladred gaze — run; Capernian — spread; Telonicus — bombs",
            "Weapons phase: loot and use the legendary weapons",
            "Interrupt Pyroblast once the shield is broken",
            "Gravity Lapse: swim away from others",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Hyjal Summit",
      tab   = "Hyjal",
      tier  = "TBC T6",
      mapId = 534,
      sections = {
        { label = "Winterchill", boss = "Rage Winterchill",
          title = "=== RAGE WINTERCHILL ===",
          lines = {
            "Move out of Death and Decay",
            "Spread for Icebolt",
          } },
        { label = "Anetheron", boss = "Anetheron",
          title = "=== ANETHERON ===",
          lines = {
            "Nobody in front — Carrion Swarm",
            "Off-tank the Infernal",
          } },
        { label = "Kaz'rogal", boss = "Kaz'rogal",
          title = "=== KAZ'ROGAL ===",
          lines = {
            "Mark of Kaz'rogal drains mana — at low mana, run out before you explode",
          } },
        { label = "Azgalor", boss = "Azgalor",
          title = "=== AZGALOR ===",
          lines = {
            "Doom: run out — a Doomguard spawns when you die",
            "Move out of Rain of Fire",
          } },
        { label = "Archimonde", boss = "Archimonde",
          title = "=== ARCHIMONDE ===",
          lines = {
            "Use Tears of the Goddess after Air Burst to slow fall",
            "Kite Doomfire away from the raid",
            "Decurse Grip of the Legion; Tremor Totem/Fear Ward for fear",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Black Temple",
      tab   = "BT",
      tier  = "TBC T6",
      mapId = 564,
      sections = {
        { label = "Naj'entus", boss = "High Warlord Naj'entus",
          title = "=== HIGH WARLORD NAJ'ENTUS ===",
          lines = {
            "Impaling Spine: loot the spine and throw it at him to break Tidal Shield",
            "Spread for Needle Spine",
          } },
        { label = "Supremus", boss = "Supremus",
          title = "=== SUPREMUS ===",
          lines = {
            "P1: tanks soak Hurtful Strike",
            "P2: he chases a player — kite; avoid Volcanic Geysers and Molten Flame",
          } },
        { label = "Akama", boss = "Shade of Akama",
          title = "=== SHADE OF AKAMA ===",
          lines = {
            "Kill the channelers and adds; protect Akama",
          } },
        { label = "Teron", boss = "Teron Gorefiend",
          title = "=== TERON GOREFIEND ===",
          lines = {
            "Shadow of Death: the ghost player kills Shadowy Constructs with spirit abilities",
          } },
        { label = "Bloodboil", boss = "Gurtogg Bloodboil",
          title = "=== GURTOGG BLOODBOIL ===",
          lines = {
            "Rotate groups to share Bloodboil stacks",
            "Fel Rage: the target tanks him — heal them up",
          } },
        { label = "Reliquary", boss = "Reliquary of Souls",
          title = "=== RELIQUARY OF SOULS ===",
          lines = {
            "Essence of Suffering: no healing on the tank — burn",
            "Essence of Desire: interrupt/reflect Rune Shield",
            "Essence of Anger: stay above it on threat, heal through Soul Scream",
          } },
        { label = "Shahraz", boss = "Mother Shahraz",
          title = "=== MOTHER SHAHRAZ ===",
          lines = {
            "Fatal Attraction: teleported players run apart",
            "Saber Lash is shared — tanks stack",
          } },
        { label = "Council", boss = "The Illidari Council",
          title = "=== THE ILLIDARI COUNCIL ===",
          lines = {
            "Interrupt Malande's heals",
            "Spread for Zerevor's Flamestrike",
            "Veras vanishes — heal Envenom targets",
          } },
        { label = "Illidan", boss = "Illidan Stormrage",
          title = "=== ILLIDAN STORMRAGE ===",
          lines = {
            "Shear: tank uses a cooldown — it halves max health",
            "Kill Parasitic Shadowfiends before they reach others",
            "P2: tank the Flames of Azzinoth apart; dodge Eye Blast",
            "Demon form: kill the Shadow Demons",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Zul'Aman",
      tab   = "ZA",
      tier  = "TBC 10-man",
      mapId = 568,
      sections = {
        { label = "Akil'zon", boss = "Akil'zon",
          title = "=== AKIL'ZON ===",
          lines = {
            "Electrical Storm: stack under the lifted player",
            "Spread for Static Disruption",
          } },
        { label = "Nalorakk", boss = "Nalorakk",
          title = "=== NALORAKK ===",
          lines = {
            "Tank swap on bear/troll form changes",
          } },
        { label = "Jan'alai", boss = "Jan'alai",
          title = "=== JAN'ALAI ===",
          lines = {
            "Move out of Fire Bombs",
            "Control the hatchers — don't let all eggs hatch at once",
          } },
        { label = "Halazzi", boss = "Halazzi",
          title = "=== HALAZZI ===",
          lines = {
            "Splits into troll and lynx at 75/50/25%",
            "Kill the Corrupted Lightning Totem on sight",
          } },
        { label = "Hex Lord", boss = "Hex Lord Malacrass",
          title = "=== HEX LORD MALACRASS ===",
          lines = {
            "Siphon Soul gives him a player's class abilities — adapt",
            "Spread for Spirit Bolts",
          } },
        { label = "Zul'jin", boss = "Zul'jin",
          title = "=== ZUL'JIN ===",
          lines = {
            "Troll: heal Grievous Throw bleeds to full",
            "Eagle: don't cast while Energy Storm is up",
            "Dragonhawk: avoid Flame Column and Flame Breath",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Sunwell Plateau",
      tab   = "SWP",
      tier  = "TBC T6.5",
      mapId = 580,
      sections = {
        { label = "Kalecgos", boss = "Kalecgos",
          title = "=== KALECGOS ===",
          lines = {
            "Teams rotate into the Spectral Realm to fight Sathrovarr",
            "Kalecgos and Sathrovarr must reach 1% together",
          } },
        { label = "Brutallus", boss = "Brutallus",
          title = "=== BRUTALLUS ===",
          lines = {
            "Groups rotate to split Meteor Slash",
            "Burn spreads — keep apart",
            "Stomp: tank swap",
          } },
        { label = "Felmyst", boss = "Felmyst",
          title = "=== FELMYST ===",
          lines = {
            "Air phase: run from Demonic Vapor trails",
            "Fog of Corruption mind-controls — avoid the fog",
          } },
        { label = "Eredar Twins", boss = "Eredar Twins",
          title = "=== EREDAR TWINS ===",
          lines = {
            "Flame Touched and Dark Touched debuffs — tank swap",
            "Move out of Conflagration and Shadow Nova",
          } },
        { label = "M'uru", boss = "M'uru",
          title = "=== M'URU ===",
          lines = {
            "Kill Void Sentinels and humanoid adds fast",
            "P2 Entropius: dodge the Darkness",
          } },
        { label = "Kil'jaeden", boss = "Kil'jaeden",
          title = "=== KIL'JAEDEN ===",
          lines = {
            "Kill Sinister Reflections",
            "Use the dragon orb shield for Darkness of a Thousand Souls",
            "Avoid Fire Bloom",
          } },
      },
    },
  },
}
