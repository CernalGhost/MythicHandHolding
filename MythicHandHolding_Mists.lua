--=====================================================================
--  MythicHandHolding — Mists of Pandaria Classic raid pack.
--  Used when the TOC version is 5xxxx.  Same shape as MHH_Raids.raids;
--  mapId = GetInstanceInfo() instanceID for auto-open.  No boss/spell
--  IDs yet (retail Encounter Journal IDs don't apply): plain text.
--=====================================================================

MHH_Classic = MHH_Classic or {}

MHH_Classic.mists = {
  raids = {
    ------------------------------------------------------------------
    {
      name  = "Mogu'shan Vaults",
      tab   = "MSV",
      tier  = "MoP T14",
      mapId = 1008,
      sections = {
        { label = "Stone Guard", boss = "The Stone Guard",
          title = "=== THE STONE GUARD ===",
          lines = {
            "Tanks swap dogs before Overload — keep them apart when energy is high",
            "Jasper Chains: chained pairs stay close",
            "Stand on the right-colored tiles; move out of Cobalt Mines",
          } },
        { label = "Feng", boss = "Feng the Accursed",
          title = "=== FENG THE ACCURSED ===",
          lines = {
            "Tank swap on each phase's stacking debuff",
            "Lightning Fists / Epicenter: get away from him",
            "Wildfire Spark: drop it away from the raid; Arcane Resonance: spread",
          } },
        { label = "Gara'jal", boss = "Gara'jal the Spiritbinder",
          title = "=== GARA'JAL THE SPIRITBINDER ===",
          lines = {
            "Voodoo Dolls share damage — tanks swap when the doll moves",
            "Spirit World groups kill Spirit Totems and click out when called",
            "20%: everyone in the real world, burn",
          } },
        { label = "Spirit Kings", boss = "The Spirit Kings",
          title = "=== THE SPIRIT KINGS ===",
          lines = {
            "Qiang: dodge Flanking Orders and Annihilate",
            "Subetai: run from Volley, free Pinned Down players",
            "Zian: interrupt Charged Shadowbolts; Meng: stop DPS on Maddening Shout",
          } },
        { label = "Elegon", boss = "Elegon",
          title = "=== ELEGON ===",
          lines = {
            "Kill Celestial Protectors on the platform edge; manage Overcharged stacks",
            "Floor phase: kill Energy Charges before they reach him",
            "Don't fall when the floor vanishes",
          } },
        { label = "Will of the Emperor", boss = "Will of the Emperor",
          title = "=== WILL OF THE EMPEROR ===",
          lines = {
            "Kill Rages and Sparks as they spawn",
            "Courage: a tank fixates it; Titan Spark: run away",
            "Energizing Smash: tanks call it",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Heart of Fear",
      tab   = "HoF",
      tier  = "MoP T14",
      mapId = 1009,
      sections = {
        { label = "Zor'lok", boss = "Imperial Vizier Zor'lok",
          title = "=== IMPERIAL VIZIER ZOR'LOK ===",
          lines = {
            "Move to the platform he flies to",
            "Force and Verve: stand in the safe circles",
            "Convert mind-controls — CC/kill the target fast",
          } },
        { label = "Ta'yak", boss = "Blade Lord Ta'yak",
          title = "=== BLADE LORD TA'YAK ===",
          lines = {
            "Unseen Strike: everyone stacks on the marked player to split damage",
            "Overwhelming Assault: tank swap",
            "Storm Unleashed: move to the end of the room",
          } },
        { label = "Garalon", boss = "Garalon",
          title = "=== GARALON ===",
          lines = {
            "Never step under him",
            "Pheromones target kites — pass it before stacks get high",
            "Kill his legs for the damage buff",
          } },
        { label = "Mel'jarak", boss = "Wind Lord Mel'jarak",
          title = "=== WIND LORD MEL'JARAK ===",
          lines = {
            "CC the adds per group; kill one group at a time",
            "Wind Bomb: move away; Corrosive Resin: drop pools at the edge",
          } },
        { label = "Un'sok", boss = "Amber-Shaper Un'sok",
          title = "=== AMBER-SHAPER UN'SOK ===",
          lines = {
            "Reshaped into a construct: interrupt the Amber Monstrosity, eat Amber Globules",
            "Burst out before Willpower runs out",
            "Interrupt Destabilize; kill the Monstrosity",
          } },
        { label = "Shek'zeer", boss = "Grand Empress Shek'zeer",
          title = "=== GRAND EMPRESS SHEK'ZEER ===",
          lines = {
            "Dissonance Fields: break Cry of Terror by stepping in",
            "P2: kill Kor'thik Reavers and Set'thik Windblades",
            "P3: avoid Visions of Demise, spread for Consuming Terror",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Terrace of Endless Spring",
      tab   = "ToES",
      tier  = "MoP T14",
      mapId = 996,
      sections = {
        { label = "Protectors", boss = "Protectors of the Endless",
          title = "=== PROTECTORS OF THE ENDLESS ===",
          lines = {
            "Kill order matters — the last two alive empower",
            "Interrupt Kaolan's casts; dispel Lightning Prison",
            "Move out of Defiled Ground; Corrupted Essence: kill the minions",
          } },
        { label = "Tsulong", boss = "Tsulong",
          title = "=== TSULONG ===",
          lines = {
            "Night: tank swap, break Nightmares",
            "Day: heal Tsulong, kill Embodied Terrors, eat Sunbeam for Dread Shadows",
          } },
        { label = "Lei Shi", boss = "Lei Shi",
          title = "=== LEI SHI ===",
          lines = {
            "Get Away: everyone runs to the walls",
            "Hide: find her before she reappears; kill Animated Protectors",
          } },
        { label = "Sha of Fear", boss = "Sha of Fear",
          title = "=== SHA OF FEAR ===",
          lines = {
            "Stand in the Wall of Light to avoid Breath of Fear",
            "Ominous Cackle sends players to the outer platforms — kill the Dread Spawns",
            "Thrash: tanks call it",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Throne of Thunder",
      tab   = "ToT",
      tier  = "MoP T15",
      mapId = 1098,
      sections = {
        { label = "Jin'rokh", boss = "Jin'rokh the Breaker",
          title = "=== JIN'ROKH THE BREAKER ===",
          lines = {
            "Focused Lightning: lead it into a conductive pool",
            "Ionization: dispel and spread",
            "Lightning Storm: everyone stands in a pool",
          } },
        { label = "Horridon", boss = "Horridon",
          title = "=== HORRIDON ===",
          lines = {
            "Kill tribe adds as each gate opens; destroy the Dinomancer's orb and stun Horridon",
            "Interrupt the shamans and witch doctors",
            "Move out of Dino Pools / Sand Traps",
          } },
        { label = "Council of Elders", boss = "Council of Elders",
          title = "=== COUNCIL OF ELDERS ===",
          lines = {
            "Kill the possessed elder; interrupt Malakk's heals",
            "Frostbite needs players around; Twisted Fate: bring the two together",
            "Biting Cold: dispel",
          } },
        { label = "Tortos", boss = "Tortos",
          title = "=== TORTOS ===",
          lines = {
            "Kick turtles at the bats and the boss",
            "Quake Stomp: raid cooldowns; spread for Rockfall; kill Vampiric Cave Bats",
          } },
        { label = "Megaera", boss = "Megaera",
          title = "=== MEGAERA ===",
          lines = {
            "Kill heads by damage order; tanks swap heads",
            "Avoid Cinders, Torrent of Ice and Nether Tear",
          } },
        { label = "Ji-Kun", boss = "Ji-Kun",
          title = "=== JI-KUN ===",
          lines = {
            "Groups fly to the nests and kill hatchlings",
            "Feed Pool: the target sends it away from the raid",
            "Quills: everyone uses a defensive",
          } },
        { label = "Durumu", boss = "Durumu the Forgotten",
          title = "=== DURUMU THE FORGOTTEN ===",
          lines = {
            "Light spectrum: three players walk their colored beam onto the fogs",
            "Disintegration Beam: run around the room with the maze",
          } },
        { label = "Primordius", boss = "Primordius",
          title = "=== PRIMORDIUS ===",
          lines = {
            "Collect beneficial mutations from Living Fluid, avoid harmful ones",
            "Kill Viscous Horrors",
          } },
        { label = "Dark Animus", boss = "Dark Animus",
          title = "=== DARK ANIMUS ===",
          lines = {
            "Activate golems in order",
            "Interrupt Anima Font; spread for Anima Ring",
          } },
        { label = "Iron Qon", boss = "Iron Qon",
          title = "=== IRON QON ===",
          lines = {
            "Kill the quilen in order",
            "Avoid Impale and Lightning Storm",
          } },
        { label = "Twin Consorts", boss = "Twin Consorts",
          title = "=== TWIN CONSORTS ===",
          lines = {
            "Lu'lin night phase: move out of Tidal Force",
            "Suen day phase: kill Lurker in the Night adds",
          } },
        { label = "Lei Shen", boss = "Lei Shen",
          title = "=== LEI SHEN ===",
          lines = {
            "Activate conduits as called",
            "Static Shock: stack to share",
            "Avoid Thunderstruck and Ball Lightning",
          } },
        { label = "Ra-den", boss = "Ra-den",
          title = "=== RA-DEN (HEROIC) ===",
          lines = {
            "Balance Vita and Anima orbs",
            "Burn before the soft enrage",
          } },
      },
    },
    ------------------------------------------------------------------
    {
      name  = "Siege of Orgrimmar",
      tab   = "SoO",
      tier  = "MoP T16",
      mapId = 1136,
      sections = {
        { label = "Immerseus", boss = "Immerseus",
          title = "=== IMMERSEUS ===",
          lines = {
            "Corrosive Blast: tank swap",
            "Split: kill the Contaminated Puddles, heal the Purified Residues",
          } },
        { label = "Fallen Protectors", boss = "The Fallen Protectors",
          title = "=== THE FALLEN PROTECTORS ===",
          lines = {
            "Bring all three down together",
            "Desperate Measures: kill the adds",
            "Interrupt Sun's casts",
          } },
        { label = "Norushen", boss = "Norushen",
          title = "=== NORUSHEN ===",
          lines = {
            "Corruption trial: complete your role's test",
            "Kill Manifestations of Corruption",
          } },
        { label = "Sha of Pride", boss = "Sha of Pride",
          title = "=== SHA OF PRIDE ===",
          lines = {
            "Keep Pride low; avoid Corrupted Prison and Banishment",
            "Kill Manifestations of Pride",
          } },
        { label = "Galakras", boss = "Galakras",
          title = "=== GALAKRAS ===",
          lines = {
            "Kill the add waves; clear the towers",
            "Dodge Flames of Galakrond",
          } },
        { label = "Iron Juggernaut", boss = "Iron Juggernaut",
          title = "=== IRON JUGGERNAUT ===",
          lines = {
            "Assault mode: tank swap; Siege mode: dodge Crawler Mines",
            "Cutter Laser: kite away from others",
          } },
        { label = "Dark Shaman", boss = "Kor'kron Dark Shaman",
          title = "=== KOR'KRON DARK SHAMAN ===",
          lines = {
            "Avoid Toxic Storm and Foul Geysers",
            "Ashen Wall: spread out",
          } },
        { label = "Nazgrim", boss = "General Nazgrim",
          title = "=== GENERAL NAZGRIM ===",
          lines = {
            "Defensive Stance: stop attacking",
            "Kill the adds; interrupt Kor'kron Arcweavers",
          } },
        { label = "Malkorok", boss = "Malkorok",
          title = "=== MALKOROK ===",
          lines = {
            "Arcing Smash: avoid; Breath of Y'Shaarj: stand behind",
            "Blood Rage: tank swap",
          } },
        { label = "Spoils", boss = "Spoils of Pandaria",
          title = "=== SPOILS OF PANDARIA ===",
          lines = {
            "Open boxes in the room; kill adds",
            "Keep your side's timer up",
          } },
        { label = "Thok", boss = "Thok the Bloodthirsty",
          title = "=== THOK THE BLOODTHIRSTY ===",
          lines = {
            "Fixate: kite him",
            "Acid Breath and Freezing Breath: tank swap",
          } },
        { label = "Blackfuse", boss = "Siegecrafter Blackfuse",
          title = "=== SIEGECRAFTER BLACKFUSE ===",
          lines = {
            "Assembly line team: deactivate weapons",
            "Avoid Overcharged Superheat; kite mines",
          } },
        { label = "Klaxxi", boss = "Paragons of the Klaxxi",
          title = "=== PARAGONS OF THE KLAXXI ===",
          lines = {
            "Kill paragons in order; loot their powers",
            "Avoid Fiery Edge and Toxic Injection",
          } },
        { label = "Garrosh", boss = "Garrosh Hellscream",
          title = "=== GARROSH HELLSCREAM ===",
          lines = {
            "P1: kill Siege Engineers and Warbringers",
            "Whirling Corruption: move out, kill the Minions of Y'Shaarj",
            "P2: Realm of Y'Shaarj — kill adds, interrupt Embodied Despair",
          } },
      },
    },
  },
}
