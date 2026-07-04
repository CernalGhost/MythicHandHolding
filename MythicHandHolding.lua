--=====================================================================
--  MythicHandHolding  v1.1.0-alpha.1
--  Midnight Season 1 M+ dungeons and raid callouts (raids alpha, issue #2).
--  New in 1.0.6: chat hyperlinks for spells and bosses.
--    * SPELL_IDS table: known spell name -> spell ID.
--    * BOSS_IDS table:  known boss name  -> encounter ID.
--    * Linkify() replaces names with WoW chat hyperlinks before send.
--    * Section field `boss = "<name>"` links the boss in the title.
--    * /mhh ej dumps the encounter IDs for the current instance, so
--      new IDs can be copy/pasted into BOSS_IDS.
--=====================================================================

local VERSION  = "1.1.0-alpha.1"

MythicHandHoldingDB = MythicHandHoldingDB or {}

local function EnsureDB()
  MythicHandHoldingDB = MythicHandHoldingDB or {}
  if MythicHandHoldingDB.plainMode == nil then
    MythicHandHoldingDB.plainMode = true
  end
  if MythicHandHoldingDB.contentMode ~= "mplus"
      and MythicHandHoldingDB.contentMode ~= "raid" then
    MythicHandHoldingDB.contentMode = "mplus"
  end
  MythicHandHoldingDB.debug = MythicHandHoldingDB.debug or false
  if type(MythicHandHoldingDB.clickCounts) ~= "table" then
    MythicHandHoldingDB.clickCounts = {}
  end
end

EnsureDB()

--=====================================================================
--  LOOKUP TABLES - add to these to get clickable links in chat.
--  Spell IDs from Wowhead.  Boss IDs from the Encounter Journal
--  (use /mhh ej while in the dungeon to dump them).
--=====================================================================
local SPELL_IDS = {
  -- Generic / shared spells (well-known IDs)
  ["Polymorph"]            = 118,
  ["Pyroblast"]            = 11366,
  ["Frost Nova"]           = 122,
  ["Hex"]                  = 51514,
  ["Chain Lightning"]      = 421,
  ["Arcane Explosion"]     = 1449,
  ["Healing Touch"]        = 396640,  -- AA Ancient Branch (was druid 5185)
  ["Mind Blast"]           = 244750,  -- SotT Viceroy Nezhar (was priest 8092)
  ["Holy Fire"]            = 14914,
  ["Blinding Light"]       = 105421,
  ["Solar Blast"]          = 154396,   -- Skyreach High Sage Viryx (was 156746)

  -- Magisters' Terrace (Midnight S1) - harvested from Wowhead
  ["Ethereal Shackles"]     = 1214038,
  ["Arcane Residue"]        = 1214089,
  ["Refueling Protocol"]    = 474345,
  ["Energy Orb"]            = 474308,
  ["Arcane Empowerment"]    = 474407,
  ["Arcane Expulsion"]      = 1214081,
  ["Unstable Energy"]       = 1243905,
  ["Repulsing Slam"]        = 474496,
  ["Suppression Zone"]      = 1224903,
  ["Feedback"]              = 1225135,
  ["Runic Mark"]            = 1224801,
  ["Null Reaction"]         = 1246446,
  ["Vow of Silence"]        = 1225193,
  ["Hastening Ward"]        = 1248689,
  ["Triplicate"]            = 1223847,
  ["Synaptic Nexus"]        = 1223936,
  ["Astral Grasp"]          = 1224299,
  ["Void Secretions"]       = 1224095,
  ["Cosmic Sting"]          = 1223957,
  ["Cosmic Radiation"]      = 1224401,
  ["Neural Link"]           = 1253707,
  ["Unstable Void Essence"] = 1215087,
  ["Null Bomb"]             = 1215941,
  ["Void Mote"]             = 1214582,
  ["Void Torrent"]          = 1214714,
  ["Void Destruction"]      = 1215161,
  ["Devouring Entropy"]     = 1215897,
  ["Mote Creation"]         = 1215027,
  ["Umbral Eruption"]       = 1215842,
  ["Entropy Blast"]         = 1271066,
  ["Entropy Orb"]           = 1269631,

  -- Maisara Caverns (Midnight S1) - Wowhead
  ["Freezing Trap"]        = 1260731,
  ["Barrage"]              = 1260643,
  ["Fetid Quillstorm"]     = 1243900,
  ["Carrion Swoop"]        = 1249479,
  ["Revive Pet"]           = 1249789,
  ["Bestial Wrath"]        = 1249948,
  ["Infected Pinions"]     = 1246666,
  ["Flanking Spear"]       = 1266480,
  ["Open Wound"]           = 1266488,
  ["Icy Slick"]            = 1243751,
  ["Vilebranch Sting"]     = 1260709,
  ["Coordinated Assault"]  = 1249769,
  ["Wrest Phantoms"]       = 1251204,
  ["Necrotic Convergence"] = 1250708,
  ["Deathshroud"]          = 1251598,
  ["Coalesced Death"]      = 1252611,
  ["Drain Soul"]           = 1251554,
  ["Final Pursuit"]        = 1251775,
  ["Lingering Dread"]      = 1251813,
  ["Soulrot"]              = 1251833,
  ["Haunting Remains"]     = 1266706,
  ["Veiled Presence"]      = 1264974,
  ["Unmake"]               = 1252054,
  ["Withering Miasma"]     = 1264987,
  ["Spiritbreaker"]        = 1251023,
  ["Crush Souls"]          = 1252676,
  ["Soulrending Roar"]     = 1253788,
  ["Restless Masses"]      = 1254441,
  ["Soulbind"]             = 1252777,
  ["Withering Soul"]       = 1253844,
  ["Deathgorged Vessel"]   = 1248863,
  ["Volatile Essence"]     = 1248980,
  ["Chill of Death"]       = 1252816,
  ["Spectral Decay"]       = 1266723,
  ["Shattered Totem"]      = 1259810,
  ["Cries of the Fallen"]  = 1254175,
  ["Eternal Suffering"]    = 1254010,
  ["Spectral Residue"]     = 1255629,
  ["Soul Expulsion"]       = 1253909,

  -- Windrunner Spire (Midnight S1) - Wowhead
  ["Burning Gale"]        = 465904,
  ["Flaming Updraft"]     = 466556,
  ["Flaming Twisters"]    = 469621,
  ["Searing Beak"]        = 466064,
  ["Fire Breath"]         = 1217763,
  ["Gunk Splatter"]       = 472777,
  ["Shadowbolt"]          = 472724,
  ["Heaving Yank"]        = 472795,
  ["Debilitating Shriek"] = 472736,
  ["Curse of Darkness"]   = 474105,
  ["Bone Hack"]           = 472888,
  ["Broken Bond"]         = 1219551,
  ["Splattering Spew"]    = 472745,
  ["Heaving Chop"]        = 474075,
  ["Throw Axe"]           = 1217094,
  ["Intercepting Charge"] = 467815,
  ["Reckless Leap"]       = 472081,
  ["Rampage"]             = 467620,
  ["Rallying Bellow"]     = 468070,
  ["Shield Wall"]         = 1250851,
  ["Bladestorm"]          = 470963,
  ["Intimidating Shout"]  = 1253026,
  ["Flame Nova"]          = 1270620,
  ["Arrow Rain"]          = 472556,
  ["Bolt Gale"]           = 474528,
  ["Billowing Wind"]      = 468442,
  ["Bullseye Windblast"]  = 468429,
  ["Turbulent Arrows"]    = 1253977,
  ["Gust Strike"]         = 472662,
  ["Gust Shot"]           = 1253978,
  ["Squall Leap"]         = 1216042,

  -- Pit of Saron (Midnight S1) - Wowhead
  ["Throw Saronite"]          = 1261299,
  ["Orebreaker"]              = 1261546,
  ["Cryostomp"]               = 1261847,
  ["Radiating Chill"]         = 1261806,
  ["Glacial Overload"]        = 1262029,
  ["Saronite Sludge"]         = 1261799,
  ["Ore Chunks"]              = 1272433,
  ["Cryoshards"]              = 1261921,
  ["Shades of Krick"]         = 1264259,
  ["Shadowbind"]              = 1264186,
  ["Plague Expulsion"]        = 1264336,
  ["Blight Smash"]            = 1264287,
  ["Get 'Em, Ick!"]           = 1264363,
  ["Shade Shift"]             = 1264027,
  ["Blight"]                  = 1264299,
  ["Plague Globs"]            = 1264461,
  ["Shade Bomb"]              = 1271678,
  ["Death Bolt"]              = 1278893,
  ["Shadow Lance"]            = 1279667,
  ["Bone Infusion"]           = 1276648,
  ["Rime Blast"]              = 1262745,
  ["Death's Grasp"]           = 1263756,
  ["Scourgelord's Brand"]     = 1262582,
  ["Army of the Dead"]        = 1263406,
  ["Scourgelord's Reckoning"] = 1263671,
  ["Festering Pulse"]         = 1262997,
  ["Plaguebolt"]              = 1262941,
  ["Rotting Strikes"]         = 1262929,
  ["Frostbite"]               = 1263716,
  ["Ice Barrage"]             = 1276948,
  ["Frost Spit"]              = 1262739,
  ["Bone Piles"]              = 1276357,
  ["Infused Bone Piles"]      = 1276391,

  -- Seat of the Triumvirate (Midnight S1) - Wowhead
  ["Decimate"]                      = 244579,
  ["Coalesced Void"]                = 244602,
  ["Dark Slam"]                     = 1263399,
  ["Dark Expulsion"]                = 244599,
  ["Void Sludge"]                   = 244588,
  ["Void Slash"]                    = 1263440,
  ["Crashing Void"]                 = 1263297,
  ["Oozing Slam"]                   = 1263399,
  ["Umbral Ejection"]               = 244731,
  ["Null Palm"]                     = 1268916,
  ["Void Bomb"]                     = 246026,
  ["Umbral Nova"]                   = 1263508,
  ["Phase Charge"]                  = 1263516,
  ["Overload"]                      = 1263526,
  ["Phase Dash"]                    = 1263518,
  ["Seeping Void"]                  = 1268840,
  ["Rending Void"]                  = 1266449,
  ["Shadow Pounce"]                 = 245742,
  ["Swoop"]                         = 248830,
  ["Dread Screech"]                 = 248831,
  ["Collapsing Void"]               = 1263529,
  ["Void Storm"]                    = 1263532,
  ["Mass Void Infusion"]            = 1263542,
  ["Mind Flay"]                     = 1268733,
  ["Mind Blast"]                    = 244750,
  ["Repulsing Force"]               = 1263533,
  ["Umbral Tentacles"]              = 1263538,
  ["Unstable Entrance"]             = 249082,
  ["Gates of the Abyss"]            = 1277358,
  ["Umbral Waves"]                  = 1264257,
  ["Notes of Despair"]              = 1265419,
  ["Dirge of Despair"]              = 1265421,
  ["Discordant Beam"]               = 1265464,
  ["Shattering Shot"]               = 1266643,
  ["Siphon Void"]                   = 1265999,
  ["Abyssal Lance"]                 = 1267207,
  ["Grim Chorus"]                   = 1265689,
  ["Symphony of the Eternal Night"] = 1266003,
  ["Anguish"]                       = 1265650,
  ["Disintegrate"]                  = 1264196,
  ["Backlash"]                      = 1266001,
  ["Void Barrier"]                  = 1265996,

  -- Nexus-Point Xenas (Midnight S1) - Wowhead
  ["Leyline Arrays"]       = 1251626,
  ["Reflux Charge"]        = 1251767,
  ["Corespark Detonation"] = 1257509,
  ["Leyline Array"]        = 1251579,
  ["Sparkburn"]            = 1276485,
  ["Arcane Spill"]         = 1264042,
  ["Arcane Zap"]           = 1250553,
  ["Lightscar Flare"]      = 1247976,
  ["Eclipsing Step"]       = 1247937,
  ["Void Scar"]            = 1252828,
  ["Lightscarred"]         = 1253965,
  ["Devour the Unworthy"]  = 1252883,
  ["Nullwark Repulsion"]   = 1252646,
  ["Entropic Blast"]       = 1252700,
  ["Flicker"]              = 1255531,
  ["Mirrored Rend"]        = 1266713,
  ["Divine Guile"]         = 1257613,
  ["Searing Rend"]         = 1253950,
  ["Radiant Scars"]        = 1255389,
  ["Core Exposure"]        = 1271511,

  -- Algeth'ar Academy (Midnight S1) - Wowhead
  ["Arcane Orbs"]               = 387691,
  ["Arcane Expulsion"]          = 385958,
  ["Mana Bombs"]                = 386173,
  ["Corrupted Mana"]            = 386201,
  ["Oversurge"]                 = 391977,
  ["Arcane Fissure"]            = 388537,
  ["Barkbreaker"]               = 388544,
  ["Germinate"]                 = 388796,
  ["Burst Forth"]               = 388923,
  ["Healing Touch"]             = 396640,
  ["Lasher Toxin"]              = 389033,
  ["Branch Out"]                = 388623,
  ["Splinterbark"]              = 396716,
  ["Abundance"]                 = 396721,
  ["Savage Peck"]               = 376997,
  ["Play Ball!"]                = 377182,
  ["Firestorm"]                 = 376448,
  ["Gale Force"]                = 376467,
  ["Overpowering Gust"]         = 377034,
  ["Deafening Screech"]         = 377004,
  ["Goal of the Searing Blaze"] = 389481,
  ["Goal of the Rushing Winds"] = 389483,
  ["Roving Cyclone"]            = 393211,
  ["Ruinous Winds"]             = 1276752,
  ["Overwhelming Power"]        = 389011,
  ["Arcane Rifts"]              = 388901,
  ["Unleash Energy"]            = 439488,
  ["Uncontrolled Energy"]       = 388951,
  ["Astral Breath"]             = 374361,
  ["Power Vacuum"]              = 388822,
  ["Arcane Missiles"]           = 373326,
  ["Energy Bomb"]               = 374352,

  -- Skyreach (Midnight S1) - Wowhead
  ["Piercing Rush"]   = 165731,
  ["Fan of Blades"]   = 153757,
  ["Four Winds"]      = 156793,
  ["Spinning Blade"]  = 1252691,
  ["Swirling Gusts"]  = 1258140,
  ["Wind Chakram"]    = 1258152,
  ["Energize"]        = 154149,
  ["Burst"]           = 154135,
  ["Smash"]           = 154132,
  ["Solar Infusion"]  = 1252877,
  ["Solar Flame"]     = 154150,
  ["Blast Wave"]      = 1279002,
  ["Fiery Smash"]     = 154132,
  ["Searing Quills"]  = 159381,
  ["Breaking Dawn"]   = 1253364,
  ["Blazing Glory"]   = 1253416,
  ["Screech"]         = 153898,
  ["Pierce Armor"]    = 153794,
  ["Pierced Armor"]   = 153795,
  ["Sunbreak"]        = 1253510,
  ["Solar Flare"]     = 1253368,
  ["Burning Pursuit"] = 1253511,
  ["Burning Claws"]   = 1253519,
  ["Lens Flare"]      = 154044,
  ["Blazing Ground"]  = 154043,
  ["Solar Burst"]     = 154396,
  ["Cast Down"]       = 153954,
  ["Scorching Ray"]   = 1253543,
  ["Solar Blast"]     = 154396,
  -- Add your own here.  Format:  ["Spell Name"] = <spellID>,
}

local BOSS_IDS = {
  -- Skyreach (Warlords of Draenor)
  ["Ranjit"]                = 803,
  ["Araknath"]              = 786,
  ["Rukhran"]               = 802,
  ["High Sage Viryx"]       = 776,
  -- Pit of Saron (Wrath of the Lich King)
  ["Forgemaster Garfrost"]  = 661,
  ["Ick and Krick"]         = 662,
  ["Scourgelord Tyrannus"]  = 663,
  -- Seat of the Triumvirate (Legion)
  ["Zuraal the Ascended"]   = 1986,
  ["Zuraal Ascended"]       = 1986,
  ["Saprish"]               = 1987,
  ["Viceroy Nezhar"]        = 1988,
  ["L'Ura"]                 = 1985,
  -- Algeth'ar Academy (Dragonflight)
  ["Vexamus"]               = 2553,
  ["Overgrown Ancient"]     = 2554,
  ["Crawth"]                = 2555,
  ["Echo of Doragosa"]      = 2556,
  -- Midnight S1 new content - run /mhh ej in each dungeon to fill
  -- Maisara Caverns:       Muro'jin and Nekraxx, Vordaza, Rak'tul Vessel of Souls
  -- Magisters' Terrace:    Arcanotron Custos, Seranel Sunlash,
  --                        Gemellus, Degentrius
  -- Nexus-Point Xenas:     Chief Kasreth, Corewarden Nysarra, Lothraxion
  -- Windrunner Spire:      Emberdawn, Derelict Duo, Commander Kroluk,
  --                        The Restless Heart
}

-- Raid journal difficulty per boss (dungeons default to 23 in MakeBossLink).
local BOSS_JOURNAL_DIFF = {}

-- Merge optional raid pack (MythicHandHolding_Raids.lua, alpha issue #2).
local RAIDS = {}
if MHH_Raids then
  local rd = MHH_Raids.journalDiff or 14
  for name, id in pairs(MHH_Raids.bossIds or {}) do
    BOSS_IDS[name] = id
    BOSS_JOURNAL_DIFF[name] = rd
  end
  for name, id in pairs(MHH_Raids.spellIds or {}) do
    SPELL_IDS[name] = id
  end
  RAIDS = MHH_Raids.raids or {}
end

--=====================================================================
--  DATA - 7 Midnight Season 1 dungeons.
--  Optional fields per section:
--    icon = "Interface\\Icons\\..."  - custom icon override
--    boss = "Boss Name"              - link the boss in the title
--=====================================================================
local DUNGEONS = {
  --------------------------------------------------------------------
  -- Maisara Caverns (33:00 timer, 3 bosses)
  --------------------------------------------------------------------
  {
    name = "Maisara Caverns",
    tab  = "MC",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== MAISARA CAVERNS - INT/DISP ===",
        lines = {
          "INTERRUPT: Hex (Ritual Hexxer), Hooked Snare (Keen Headhunter), Shadowfrost Blast (Hollow Soulrender), Reanimate (Reanimated Warrior), Spirit Rend (Tormented Shade)",
          "DISPEL: Hex (Hexxer), Ritual Firebrand (Hex Guardian), Infected Pinions (Muro'jin/Nekraxx), Spirit Rend (Reanimated Warrior), Frost Nova (Hollow Soulrender)",
        } },
      { label = "Muro'jin & Nekraxx",
        boss  = "Muro'jin and Nekraxx",
        title = "=== MURO'JIN & NEKRAXX ===",
        lines = {
          "Kill bosses at the SAME TIME - if one dies the other enrages",
          "Carrion Swoop = step ONTO a Freezing Trap (not behind) to break the charge",
          "Barrage targeted = stand still + defensives",
          "Dispel Infected Pinions ASAP - heavy raid damage",
        } },
      { label = "Vordaza",
        boss  = "Vordaza",
        title = "=== VORDAZA ===",
        lines = {
          "Kite Unstable Phantoms INTO each other to detonate",
          "Detonate in SETS OF TWO (prevents Lingering Dread stacks)",
          "Intermission: break the Deathshroud while dodging Coalesced Death orbs",
          "Hard CC the phantoms to line up collisions",
        } },
      { label = "Rak'tul",
        boss  = "Rak'tul, Vessel of Souls",
        title = "=== RAK'TUL ===",
        lines = {
          "Crush Souls = stack near allies, dodge the leaps",
          "Kill the Soulbind Totems before they pull allies in",
          "Intermission: run back to boss, dodge Lost Souls and Malignant Souls",
          "Interrupt Eternal Suffering on Malignant Souls = big damage buff",
        } },
      { label = "Tips",
        title = "=== MAISARA TIPS ===",
        lines = {
          "Go RIGHT at the initial fork - skips Hex Guardians + Hearty Vilebranch Stew buff",
          "Vordaza (B2): hard CC phantoms to line up collisions",
          "Death's Grasp = use root-breakers to escape",
          "Final bridge: hug either side to dodge bouncing balls",
        } },
    },
  },
  {
    name = "Magisters' Terrace",
    tab  = "MgT",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== MAGISTERS' TERRACE - INT/DISP ===",
        lines = {
          "INTERRUPT: Polymorph (Arcane Magister), Pyroblast (Blazing Pyromancer), Terror Wave (Void Terror)",
          "DISPEL: Polymorph (Magister), Ethereal Shackles (Sentry/Custos), Holy Fire (Lightward Healer), Consuming Void (Terror), Hulking Fragment (Degentrius)",
        } },
      { label = "Arcanotron Custos",
        boss  = "Arcanotron Custos",
        title = "=== ARCANOTRON CUSTOS ===",
        lines = {
          "Tank on edge, slowly walk around edge for puddles",
          "Refueling Protocol = bonus damage window, but soak ALL orbs before they reach boss",
        } },
      { label = "Seranel Sunlash",
        boss  = "Seranel Sunlash",
        title = "=== SERANEL SUNLASH ===",
        lines = {
          "Clear Runic Marks ONE AT A TIME by stepping into Suppression Zone",
          "Be INSIDE Suppression Zone when Wave of Silence casts",
          "Use pings to indicate who clears first",
        } },
      { label = "Gemellus",
        boss  = "Gemellus",
        title = "=== GEMELLUS ===",
        lines = {
          "Clear Neutral Link by running to the clone with the RED ARROW + RED LIGHT",
          "DON'T get pulled into clones during Astral Grasp",
        } },
      { label = "Degentrius",
        boss  = "Degentrius",
        title = "=== DEGENTRIUS ===",
        lines = {
          "Split party - players on BOTH sides of cutter beam",
          "Soak the bouncing volleyball when it enters your area, dodge orbs",
          "Hulking Fragment: dispel tank on ALTERNATING sides of their quadrant",
        } },
      { label = "Tips",
        title = "=== MAGISTERS' TIPS ===",
        lines = {
          "Big pull down first hallway with Bloodlust",
          "Click Arcane Tome near library start = 30min Haste buff",
          "Shadowrift Voidcallers' Consuming Shadows can be LoS'd",
        } },
    },
  },
  {
    name = "Nexus-Point Xenas",
    tab  = "NPX",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== NEXUS-POINT XENAS - INT/DISP ===",
        lines = {
          "INTERRUPT: Arcane Explosion (Corewright Arcanist), Nullify (Grand Nullifier)",
          "DISPEL: Transference (Corewright Arcanist), Creeping Void (Cursed Voidcaller), Burning Radiance (Lightwrought)",
        } },
      { label = "Chief Kasreth",
        boss  = "Chief Kasreth",
        title = "=== CHIEF COREWRIGHT KASRETH ===",
        lines = {
          "Reflux Charge = stand on a set of laser beams to clear them",
          "Stand on INTERSECTIONS to clear as many as possible",
          "Don't get knocked into a laser during Corespark Detonation",
        } },
      { label = "Corewarden Nysarra",
        boss  = "Corewarden Nysarra",
        title = "=== COREWARDEN NYSARRA ===",
        lines = {
          "Kill summoned adds, INTERRUPT Nullify",
          "Stand in Lightscared Flame beam = 300% bonus damage to boss",
          "Healers get bonus healing to handle the beam damage",
        } },
      { label = "Lothraxion",
        boss  = "Lothraxion",
        title = "=== LOTHRAXION ===",
        lines = {
          "Avoid Lothraxion clones, dodge their charges",
          "During Divine Guile, INTERRUPT the Image WITHOUT horns",
        } },
      { label = "Tips",
        title = "=== NEXUS-POINT TIPS ===",
        lines = {
          "Tank Circuit Seers AWAY from inactive barrels (don't activate them)",
          "Don't pull too many Shadowguard Defenders (stacking healing absorb)",
          "Right wing: prevent Smudges from reaching inactive adds",
          "You do NOT need to pull the entire last platform to summon Lothraxion",
        } },
    },
  },
  {
    name = "Windrunner Spire",
    tab  = "Spire",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== WINDRUNNER SPIRE - INT/DISP ===",
        lines = {
          "INTERRUPT: Poison Blades (Cutthroat), Chain Lightning (Phantasmal Mystic), Fire Spit (Territorial Dragonhawk)",
          "DISPEL: Soul Torment (Steward), Poison Spray (Spindleweb), Poison Blades (Cutthroat), Curse of Darkness (Derelict Duo), Throw Axe (Axethrower)",
        } },
      { label = "Emberdawn",
        boss  = "Emberdawn",
        title = "=== EMBERDAWN ===",
        lines = {
          "Place Flaming Updrafts on EDGES of the room",
          "Burning Gale: use defensives, dodge tornadoes and frontal cones",
        } },
      { label = "Derelict Duo",
        boss  = "Derelict Duo",
        title = "=== DERELICT DUO ===",
        lines = {
          "Kill bosses at the SAME TIME",
          "Place Splattering Spew near edges, move bosses to open areas",
          "Heaving Yank target: walk BEHIND boss casting Debilitating Shriek to interrupt",
        } },
      { label = "Commander Kroluk",
        boss  = "Commander Kroluk",
        title = "=== COMMANDER KROLUK ===",
        lines = {
          "Intimidating Shout: stack with allies to avoid fear",
          "Focus the adds when summoned - boss takes 99% LESS damage until they die",
          "Reckless Leap targets farthest player - soak first, tank soaks second",
        } },
      { label = "The Restless Heart",
        boss  = "The Restless Heart",
        title = "=== THE RESTLESS HEART ===",
        lines = {
          "Bolt Gale target stands STILL, everyone else moves away",
          "Use Gust Shot to clear large puddles (avoid hitting arrows)",
          "Bullseye Windblast: walk into an arrow to get launched over the ring",
          "Clear Squall Leap stacks by stepping into an arrow",
        } },
      { label = "Tips",
        title = "=== WINDRUNNER TIPS ===",
        lines = {
          "Combine first room with Bloodlust",
          "Territorial Dragonhawk's Fire Spit is high damage - CC to stop it",
        } },
    },
  },
  {
    name = "Algeth'ar Academy",
    tab  = "AA",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== ALGETH'AR ACADEMY - INT/DISP ===",
        lines = {
          "INTERRUPT: Healing Touch (Ancient Branch), Surge (Corrupted Manafiend), Monotonous Lecture (Unruly Textbook)",
          "DISPEL: Vile Bite (Vile Lasher), Lasher Toxin (Hungry Lasher), Monotonous Lecture (Textbook)",
        } },
      { label = "Overgrown Ancient",
        boss  = "Overgrown Ancient",
        title = "=== OVERGROWN ANCIENT ===",
        lines = {
          "STACK with party during Germinate, walk together to clump adds",
          "Stand in the healing circle when Ancient Branch dies (removes bleed)",
        } },
      { label = "Crawth",
        boss  = "Crawth",
        title = "=== CRAWTH ===",
        lines = {
          "SPREAD and STOP CASTING during Deafening Screech",
          "At 75% and 45%: throw all THREE balls into the SAME goal",
          "Throw balls into the WIND goal first, then Fire",
        } },
      { label = "Vexamus",
        boss  = "Vexamus",
        title = "=== VEXAMUS ===",
        lines = {
          "Soak ONE Arcane Orb per wave - make sure debuff fell off",
          "Keep MOVING during Arcane Fissure to avoid swirlies",
        } },
      { label = "Echo of Doragosa",
        boss  = "Echo of Doragosa",
        title = "=== ECHO OF DORAGOSA ===",
        lines = {
          "Tank boss AWAY from Arcane Rifts (easier orb dodging)",
          "Stand near edge at 2 stacks of Overwhelming Power",
          "At 3 stacks you drop another Arcane Rift",
        } },
      { label = "Tips",
        title = "=== ALGETH'AR TIPS ===",
        lines = {
          "Combine all Overgrown Ancient trash into a single Bloodlust pull",
        } },
    },
  },
  {
    name = "Seat of the Triumvirate",
    tab  = "SotT",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== SEAT - INT/DISP ===",
        lines = {
          "INTERRUPT: Summon Voidcaller (Conjurer), Shadowmend (Riftstalker), Dread Screech (Shadewing), Abyssal Enhancement (Voidbender), Mind Blast (Nezhar)",
          "DISPEL: Rift Essence (Rift Warden), Shadow Pounce (Darkfang)",
        } },
      { label = "Zuraal Ascended",
        boss  = "Zuraal the Ascended",
        title = "=== ZURAAL THE ASCENDED ===",
        lines = {
          "Prevent slimes from reaching boss - kill or CC them",
          "Crashing Void INCREASES slime movement speed",
          "Decimate target: place at EDGE away from slimes",
          "CC'd slimes that hit boss do NOT explode",
        } },
      { label = "Saprish",
        boss  = "Saprish",
        title = "=== SAPRISH ===",
        lines = {
          "Stay close to bosses for 3-target cleave + interrupt Dread Screech",
          "Use Overload to destroy as many Void Bombs as possible",
          "Tank runs into any remaining bombs",
        } },
      { label = "Viceroy Nezhar",
        boss  = "Viceroy Nezhar",
        title = "=== VICEROY NEZHAR ===",
        lines = {
          "Cleave down summoned tentacles to lower damage",
          "During Collapsing Void: move to CENTER of arena",
        } },
      { label = "L'Ura",
        boss  = "L'Ura",
        title = "=== L'URA ===",
        lines = {
          "Discordant Beam target: hit an active Note of Despair relic to deactivate it",
          "Rotate in a circle to avoid Disintegrate laser beams",
          "After all relics disabled, boss takes 200% bonus damage for 20s",
        } },
      { label = "Tips",
        title = "=== SEAT TIPS ===",
        lines = {
          "Chains of Subjugation can be removed with root-breakers - big damage reduction",
          "Defeat all 4 Rift Wardens to unlock the second boss",
        } },
    },
  },
  {
    name = "Skyreach",
    tab  = "Sky",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== SKYREACH - INT/DISP ===",
        lines = {
          "INTERRUPT: Repel (Gale-Caller), Blinding Light (Sun Priestess), Solar Blast (High Sage Viryx)",
          "DISPEL: Blade Rush (Adorned Bladetalon)",
        } },
      { label = "Ranjit",
        boss  = "Ranjit",
        title = "=== RANJIT ===",
        lines = {
          "Avoid getting knocked off when dropping Gale Surge near platform edge",
          "Dodge Wind Chakrams (line) and Chakram Vortex (tornadoes)",
        } },
      { label = "Araknath",
        boss  = "Araknath",
        title = "=== ARAKNATH ===",
        lines = {
          "SOAK all 3 Energize beams to prevent boss from healing",
          "Tank aims boss AWAY from beams, then dodges Fiery Smash",
        } },
      { label = "Rukhran",
        boss  = "Rukhran",
        title = "=== RUKHRAN ===",
        lines = {
          "Quickly kill Sunwing adds AWAY from other defeated Sunwings (prevents respawn)",
          "Bait the initial Sunwing into your kill spot, then kill before it moves",
          "Searing Quills: LoS boss behind the CENTER PILLAR",
        } },
      { label = "High Sage Viryx",
        boss  = "High Sage Viryx",
        title = "=== HIGH SAGE VIRYX ===",
        lines = {
          "Lens Flare target: kite the laser beam around the SIDES of the room",
          "Cast Down target: move to ENTRANCE of area, party helps defeat add",
          "Evoker/Warlock can survive being dropped off the ledge",
        } },
      { label = "Tips",
        title = "=== SKYREACH TIPS ===",
        lines = {
          "SOOTHE Raging Squalls to remove Wrathful Wind",
          "End of wind gauntlet: channel into the staff to turn off the wind",
        } },
    },
  },
  {
    name = "Pit of Saron",
    tab  = "PoS",
    sections = {
      { label = "Interrupts/Dispels",
        title = "=== PIT OF SARON - INT/DISP ===",
        lines = {
          "INTERRUPT: Netherburst (Cadaver), Icy Blast (Lich), Plungegrip (Gargoyle), Shadowbind (Shade of Krick), Death Bolt (Krick), Plague Bolt (Plaguespreader)",
          "DISPEL: Curse of Torment (Tormenter), Permeating Cold (Coldwraith), Cryoshards (Garfrost), Shadowbind (Shadow of Krick)",
        } },
      { label = "Forgemaster Garfrost",
        boss  = "Forgemaster Garfrost",
        title = "=== FORGEMASTER GARFROST ===",
        lines = {
          "Tank uses Orebreaker to hit one of the two Ore Chunks",
          "During Glacial Overload: HIDE from the channeled forge using an Ore Chunk",
          "Position boss so players can hit it while hiding from forge",
        } },
      { label = "Ick and Krick",
        boss  = "Ick and Krick",
        title = "=== ICK AND KRICK ===",
        lines = {
          "Bosses SHARE health",
          "Kill the Shades of Krick quickly, INTERRUPT Krick's Death Bolt",
          "When fixated by Ick: DON'T get hit",
        } },
      { label = "Scourgelord Tyrannus",
        boss  = "Scourgelord Tyrannus",
        title = "=== SCOURGELORD TYRANNUS ===",
        lines = {
          "Frost Spit target: hit a bone pile with a GREEN LIGHT over it",
          "Scourgelord's Brand on tank: get knocked back, avoid the resulting circle",
          "After Army of the Dead: interrupt and kill all Scourge Plaguespreaders",
        } },
      { label = "Tips",
        title = "=== PIT OF SARON TIPS ===",
        lines = {
          "Most groups go RIGHT to Forgemaster Garfrost first",
          "Use root-breakers to break Plungegrip (skip breaking the shield)",
          "RESCUE all 6 camps around the pit to unlock the last boss",
        } },
    },
  },
}

--=====================================================================
--  STATE
--=====================================================================
local ui
local pendingTab   = nil
local pendingMode  = nil

--=====================================================================
--  HELPERS
--=====================================================================
local function Print(text)
  print("|cffffcc33[MHH]|r " .. tostring(text))
end

-- Per-section broadcast click totals (persisted in SavedVariables).
local function ClickCountKey(mode, idx, sIdx)
  local prefix = (mode == "raid") and "R" or "M"
  return ("%s%d_S%d"):format(prefix, idx, sIdx)
end

local function ContentList(mode)
  if mode == "raid" then return RAIDS end
  return DUNGEONS
end

local function GetClickCount(key)
  EnsureDB()
  return MythicHandHoldingDB.clickCounts[key] or 0
end

local function IncClickCount(key)
  EnsureDB()
  local n = GetClickCount(key) + 1
  MythicHandHoldingDB.clickCounts[key] = n
  return n
end

local function Norm(s)
  if not s then return "" end
  s = s:lower():gsub("[^%w%s]", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
  return s
end

-- Escape Lua pattern magic chars so a literal name can be used in gsub.
local function PatEsc(s)
  return (s:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1"))
end

--=====================================================================
--  HYPERLINK BUILDERS
--=====================================================================
local function MakeSpellLink(spellID, displayName)
  -- Build a chat-safe spell link.  The server validates these strictly:
  -- an unresolvable spellID will cause the whole message to drop silently,
  -- so fall back to plain text when the client can't resolve the ID.
  if C_Spell and C_Spell.GetSpellLink then
    local link = C_Spell.GetSpellLink(spellID)
    if link and link ~= "" then return link end
  end
  if C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(spellID) then
    return ("|cff71d5ff|Hspell:%d|h[%s]|h|r"):format(spellID, displayName or "spell")
  end
  return displayName or ("spell:" .. tostring(spellID))
end

local function MakeBossLink(encounterID, displayName, difficulty)
  -- Format: journal:1:<encID>:<difficulty>  - 1 = encounter type.
  -- 23 = Mythic 5-man.  If WoW can't resolve the encounter (bad ID),
  -- the chat server rejects the whole message, so fall back to plain
  -- text if the ID isn't recognized.
  local name
  if EJ_GetEncounterInfo then name = EJ_GetEncounterInfo(encounterID) end
  if name then
    return ("|cff66bbff|Hjournal:1:%d:%d|h[%s]|h|r"):format(
      encounterID, difficulty or 23, displayName)
  end
  return displayName  -- plain text, chat-safe
end

-- Pre-sort lookup keys longest-first so "Frost Nova" matches before "Frost".
local _spellNamesByLen, _bossNamesByLen
local function RebuildLookupOrder()
  _spellNamesByLen = {}
  for n in pairs(SPELL_IDS) do _spellNamesByLen[#_spellNamesByLen+1] = n end
  table.sort(_spellNamesByLen, function(a,b) return #a > #b end)
  _bossNamesByLen = {}
  for n in pairs(BOSS_IDS) do _bossNamesByLen[#_bossNamesByLen+1] = n end
  table.sort(_bossNamesByLen, function(a,b) return #a > #b end)
end
RebuildLookupOrder()

-- Replace known spell/boss names with their chat hyperlinks.  Uses
-- word-boundary anchors so "Frost" doesn't eat the start of "Frost Nova".
-- Avoids re-matching inside an already-substituted link by marking each
-- replaced span with a sentinel that won't match any later pattern.
local function Linkify(text)
  if not text or text == "" then return text end
  -- Substitute placeholders so we can do safe sequential gsubs.
  local replacements = {}
  local function stash(s)
    replacements[#replacements+1] = s
    return ("\1MHH" .. #replacements .. "\1")
  end

  for _, name in ipairs(_spellNamesByLen) do
    local id = SPELL_IDS[name]
    if id then
      local pat = "%f[%w]" .. PatEsc(name) .. "%f[%W]"
      text = text:gsub(pat, function()
        return stash(MakeSpellLink(id, name))
      end)
    end
  end
  for _, name in ipairs(_bossNamesByLen) do
    local id = BOSS_IDS[name]
    if id then
      local diff = BOSS_JOURNAL_DIFF[name] or 23
      local pat = "%f[%w]" .. PatEsc(name) .. "%f[%W]"
      text = text:gsub(pat, function()
        return stash(MakeBossLink(id, name, diff))
      end)
    end
  end
  -- Restore placeholders.
  text = text:gsub("\1MHH(%d+)\1", function(i)
    return replacements[tonumber(i)]
  end)
  -- Belt-and-suspenders: strip any leftover control chars that could
  -- ever sneak through; chat server rejects messages containing them.
  text = text:gsub("[\1-\8\11\12\14-\31]", "")
  return text
end

-- If the linkified form would be too long for chat (255 char limit with
-- safety margin), fall back to plain text so the message can be sent at
-- all.  Better one bland line than a silently-rejected one.
local function LinkifySafe(text, plainMode)
  if plainMode then return text end
  local linked = Linkify(text)
  if #linked > 250 then return text end
  return linked
end

--=====================================================================
--  UI - compact buttons with icons
--=====================================================================
local function PickIcon(section)
  if section.icon then return section.icon end
  local lbl = (section.label or ""):lower()
  if lbl:find("interrupt") or lbl:find("dispel") then
    return "Interface\\Icons\\ability_kick"
  end
  if lbl == "tips" or lbl:find("tip") then
    return "Interface\\Icons\\inv_misc_book_11"
  end
  return "Interface\\Icons\\achievement_boss_lichking"
end

-- Pick the slash prefix used by the macro WoW runs on secure-button
-- click.  In any party (with or without an instance group) /p is the
-- safest universal channel; /i is wanted in LFD random groups where
-- you don't have a home party.
local function CurrentChatSlash()
  if MythicHandHoldingDB.testMode then return nil end
  local inInst, instType = IsInInstance()
  if inInst and (instType == "party" or instType == "raid") then
    if IsInGroup(2) and not IsInGroup(1) then return "/i" end
  end
  if IsInGroup() then return "/p" end
  return nil
end

-- WoW 11.0+ blocks macro chaining: a secure button cannot :Click() another
-- button that runs macrotext.  One user click = one macro = one /p line.
-- Multi-line sections cycle: each click sends the next line; after the last
-- line the button wraps back to line 1.  Macrotext is capped at 255 chars.
local MACRO_BUDGET = 255
local _liveSectionButtons = {}

local function MacroSafeLine(line)
  return (line:gsub("%%", "%%%%"):gsub("\n", " "):gsub("\r", ""))
end

-- Trim INT/DISP callouts for the 255-char macro budget.  Mob names in
-- parentheses stay in the tooltip; broadcast uses spell names only.
local function CompactCalloutLine(line)
  if not line or line == "" then return line end
  local compact = line
  compact = compact:gsub("^INTERRUPT:", "INT:")
  compact = compact:gsub("^DISPEL:", "DISP:")
  compact = compact:gsub("%s*%([^)]*%)", "")
  compact = compact:gsub("%s+", " "):match("^%s*(.-)%s*$") or compact
  return compact
end

local function GetBroadcastLines(section)
  -- Broadcast tips/callouts only.  The button label + tooltip title give
  -- context; skipping === headers saves a click per section under 11.0 rules.
  local plain = MythicHandHoldingDB.plainMode and true or false
  local out = {}
  if section.lines then
    for _, line in ipairs(section.lines) do
      if line and line ~= "" then
        out[#out + 1] = LinkifySafe(CompactCalloutLine(line), plain)
      end
    end
  end
  return out
end

local function FitMacroLine(slash, line)
  line = MacroSafeLine(line)
  local msg = slash .. " " .. line
  if #msg <= MACRO_BUDGET then return msg end
  local maxLine = MACRO_BUDGET - #slash - 5
  if maxLine < 1 then maxLine = 1 end
  line = line:sub(1, maxLine) .. "..."
  return slash .. " " .. line
end

local function BuildSectionMacro(visibleButton, section, lineIdx)
  if InCombatLockdown() then return end
  local slash = CurrentChatSlash()
  local lines = GetBroadcastLines(section)
  visibleButton._broadcastLines = lines

  lineIdx = lineIdx or visibleButton._lineIdx or 1
  if #lines > 0 then
    if lineIdx < 1 or lineIdx > #lines then lineIdx = 1 end
    visibleButton._lineIdx = lineIdx
  end

  if not slash or #lines == 0 or MythicHandHoldingDB.testMode then
    visibleButton:SetAttribute("type", "macro")
    visibleButton:SetAttribute("macrotext", "")
    return
  end

  visibleButton:SetAttribute("type", "macro")
  visibleButton:SetAttribute("macrotext", FitMacroLine(slash, lines[lineIdx]))
end

local function AdvanceSectionMacro(visibleButton)
  if InCombatLockdown() then return end
  local lines = visibleButton._broadcastLines
  if not lines or #lines <= 1 then return end
  local nextIdx = (visibleButton._lineIdx or 1) + 1
  if nextIdx > #lines then nextIdx = 1 end
  BuildSectionMacro(visibleButton, visibleButton._section, nextIdx)
end

local UpdateLineBadge

local function RefreshAllMacros()
  if InCombatLockdown() then return end
  for _, b in ipairs(_liveSectionButtons) do
    if b._section then
      b._lineIdx = 1
      b._cycleSent = 0
      BuildSectionMacro(b, b._section, 1)
      UpdateLineBadge(b)
    end
  end
end

local FRAME_W       = 224
local FRAME_PAD     = 8
local SECTION_W     = FRAME_W - FRAME_PAD * 2
local DROPDOWN_W    = SECTION_W - 36   -- UIDropDownMenuTemplate arrow chrome
local SECTION_H    = 22
local SECTION_STEP = 24
local HEADER_H     = 72   -- title + mode row + dropdown
local FOOTER_H     = 46   -- checkboxes

function UpdateLineBadge(b)
  if not b or not b.lineBadge then return end
  local lines = b._broadcastLines
  if not lines and b._section then
    lines = GetBroadcastLines(b._section)
    b._broadcastLines = lines
  end
  local total = lines and #lines or 0
  if total <= 0 then
    b.lineBadge:SetText("")
  else
    b.lineBadge:SetText(("%d/%d"):format(b._cycleSent or 0, total))
  end
end

local function MakeSectionButton(parent, section, w, btnName, clickKey)
  local name = btnName or ("MHHSection" .. tostring(math.random(1, 99999999)))
  local b = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
  b:SetSize(w or SECTION_W, SECTION_H)
  b:RegisterForClicks("AnyUp")
  b._section = section
  b._lineIdx = 1
  b._cycleSent = 0
  b._clickKey = clickKey

  BuildSectionMacro(b, section, 1)

  local bg = b:CreateTexture(nil, "BACKGROUND")
  bg:SetAllPoints()
  bg:SetColorTexture(0.13, 0.13, 0.17, 0.85)
  local hl = b:CreateTexture(nil, "HIGHLIGHT")
  hl:SetAllPoints()
  hl:SetColorTexture(1, 0.82, 0, 0.18)
  local icon = b:CreateTexture(nil, "ARTWORK")
  icon:SetSize(16, 16)
  icon:SetPoint("LEFT", b, "LEFT", 3, 0)
  icon:SetTexture(PickIcon(section))
  icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  local lineBadge = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  lineBadge:SetPoint("RIGHT", b, "RIGHT", -4, 0)
  lineBadge:SetTextColor(1, 0.82, 0.4)
  b.lineBadge = lineBadge
  local text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  text:SetPoint("LEFT", b, "LEFT", 22, 0)
  text:SetPoint("RIGHT", lineBadge, "LEFT", -4, 0)
  text:SetJustifyH("LEFT")
  text:SetWordWrap(false)
  text:SetText(section.label)
  UpdateLineBadge(b)
  return b
end

local function BuildUI()
  EnsureDB()
  local f = CreateFrame("Frame", "MythicHandHoldingFrame", UIParent, "BackdropTemplate")
  f:SetSize(FRAME_W, 300)
  f:SetPoint(MythicHandHoldingDB.point or "CENTER", UIParent,
             MythicHandHoldingDB.point or "CENTER",
             MythicHandHoldingDB.x or 0, MythicHandHoldingDB.y or 0)
  if f.SetBackdrop then
    f:SetBackdrop({
      bgFile   = "Interface\\Buttons\\WHITE8x8",
      edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
      tile = false, edgeSize = 12,
      insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    f:SetBackdropColor(0.05, 0.05, 0.08, 0.96)
    f:SetBackdropBorderColor(0.5, 0.5, 0.6, 1)
  end
  f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
  if f.SetClipsChildren then f:SetClipsChildren(true) end
  f:RegisterForDrag("LeftButton")
  f:SetScript("OnDragStart", f.StartMoving)
  f:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local p, _, _, x, y = self:GetPoint()
    MythicHandHoldingDB.point = p; MythicHandHoldingDB.x = x; MythicHandHoldingDB.y = y
  end)

  local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOPLEFT", FRAME_PAD, -6); title:SetText("Mythic Hand Holding")
  local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", -2, -2); close:SetSize(24, 24)

  local currentMode = MythicHandHoldingDB.contentMode or "mplus"
  local currentTab = 1
  local contentDropdown = CreateFrame("Frame", "MythicHandHoldingContentDropDown", f, "UIDropDownMenuTemplate")
  contentDropdown:SetPoint("TOPLEFT", f, "TOPLEFT", FRAME_PAD, -44)
  UIDropDownMenu_SetWidth(contentDropdown, DROPDOWN_W)

  local modeMplus = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
  modeMplus:SetSize(48, 18)
  modeMplus:SetPoint("TOPLEFT", f, "TOPLEFT", FRAME_PAD, -22)
  modeMplus:SetText("M+")
  local modeRaid = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
  modeRaid:SetSize(48, 18)
  modeRaid:SetPoint("LEFT", modeMplus, "RIGHT", 4, 0)
  modeRaid:SetText("Raid")

  local contentContainers = { mplus = {}, raid = {} }
  local sectionTopY = -(HEADER_H + 4)
  local ShowTab
  local ShowMode

  local function ActiveList()
    return ContentList(currentMode)
  end

  local function FrameHeightForTab(idx)
    local list = ActiveList()
    local n = #(list[idx] and list[idx].sections or {})
    return HEADER_H + 4 + n * SECTION_STEP + FOOTER_H + 4
  end

  local function UpdateModeButtons()
    local raidOn = (currentMode == "raid")
    modeMplus:SetEnabled(raidOn)
    modeRaid:SetEnabled(not raidOn)
  end

  local function RefreshDropdown()
    local list = ActiveList()
    UIDropDownMenu_Initialize(contentDropdown, function()
      for i, entry in ipairs(list) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = entry.name
        info.arg1 = i
        info.func = function(_, arg1)
          if ShowTab then ShowTab(arg1) end
        end
        info.checked = (i == currentTab)
        UIDropDownMenu_AddButton(info)
      end
    end)
    if list[currentTab] then
      UIDropDownMenu_SetSelectedValue(contentDropdown, currentTab)
      UIDropDownMenu_SetText(contentDropdown, list[currentTab].name)
    end
  end

  local function AttachSectionHooks(b, section)
    b:HookScript("OnClick", function()
      if b._clickKey then
        IncClickCount(b._clickKey)
      end
      if MythicHandHoldingDB.testMode then
        local lines = b._broadcastLines or GetBroadcastLines(section)
        local idx = b._lineIdx or 1
        if DEFAULT_CHAT_FRAME and lines[idx] then
          DEFAULT_CHAT_FRAME:AddMessage("|cff66ff66[MHH-Test]|r " .. lines[idx])
        end
      elseif MythicHandHoldingDB.debug then
        local slash = CurrentChatSlash() or "(no-group)"
        local lines = b._broadcastLines or GetBroadcastLines(section)
        local idx = b._lineIdx or 1
        local mt = b:GetAttribute("macrotext") or ""
        if DEFAULT_CHAT_FRAME then
          DEFAULT_CHAT_FRAME:AddMessage(
            ("|cffaaaaaa>> line %d/%d [%s len=%d]|r %s"):format(
              idx, #lines, slash, #mt, mt))
        end
      end
      local lines = b._broadcastLines or GetBroadcastLines(section)
      local total = lines and #lines or 0
      if total > 0 then
        b._cycleSent = (b._cycleSent or 0) + 1
      end
      AdvanceSectionMacro(b)
      if total > 0 and (b._lineIdx or 1) == 1 and (b._cycleSent or 0) >= total then
        b._cycleSent = 0
      end
      UpdateLineBadge(b)
    end)
    b:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(section.label, 1, 0.82, 0)
      if section.title then
        GameTooltip:AddLine(section.title, 0.85, 0.85, 0.85, true)
      end
      GameTooltip:AddLine(" ")
      for _, line in ipairs(section.lines) do
        GameTooltip:AddLine(line, 0.9, 0.9, 0.9, true)
      end
      GameTooltip:AddLine(" ")
      local lineCount = #(self._broadcastLines or GetBroadcastLines(section))
      if self._clickKey and GetClickCount(self._clickKey) > 0 then
        GameTooltip:AddLine(
          ("Times clicked: %d"):format(GetClickCount(self._clickKey)),
          0.55, 0.55, 0.6)
      end
      if lineCount > 1 then
        GameTooltip:AddLine(
          ("Next click sends line %d of %d"):format(self._lineIdx or 1, lineCount),
          1, 0.82, 0.4, true)
        GameTooltip:AddLine(" ")
      end
      if MythicHandHoldingDB.testMode then
        GameTooltip:AddLine("Click to echo locally (Test Mode).", 1, 0.5, 0.5)
      elseif lineCount > 1 then
        GameTooltip:AddLine(
          ("Click to broadcast 1 line (%d clicks for full section)."):format(lineCount),
          0.6, 0.8, 0.6, true)
        GameTooltip:AddLine("Next click sends the next line.", 0.5, 0.7, 0.5)
      else
        GameTooltip:AddLine("Click to broadcast to your group.", 0.6, 0.8, 0.6)
      end
      GameTooltip:Show()
    end)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
  end

  local function PreBuildContent(mode, idx, entry, topY)
    local c = CreateFrame("Frame", ("MHHContent_%s_%d"):format(mode, idx), f)
    c:Hide()
    c:SetPoint("TOPLEFT", f, "TOPLEFT", FRAME_PAD, topY)
    c:SetSize(SECTION_W, #entry.sections * SECTION_STEP)
    local y = 0
    for sIdx, section in ipairs(entry.sections) do
      local btnName = ("MHHSection_%s_%d_S%d"):format(mode, idx, sIdx)
      local clickKey = ClickCountKey(mode, idx, sIdx)
      local b = MakeSectionButton(c, section, SECTION_W, btnName, clickKey)
      b:SetPoint("TOPLEFT", c, "TOPLEFT", 0, y)
      AttachSectionHooks(b, section)
      _liveSectionButtons[#_liveSectionButtons + 1] = b
      y = y - SECTION_STEP
    end
    return c
  end

  ShowTab = function(idx)
    local list = ActiveList()
    if idx < 1 or idx > #list then return end
    currentTab = idx
    for mode, containers in pairs(contentContainers) do
      for i, c in ipairs(containers) do
        if mode == currentMode and i == idx then c:Show() else c:Hide() end
      end
    end
    f:SetHeight(FrameHeightForTab(idx))
    RefreshDropdown()
  end

  ShowMode = function(mode, idx)
    if mode ~= "mplus" and mode ~= "raid" then return end
    if #ContentList(mode) == 0 then return end
    currentMode = mode
    MythicHandHoldingDB.contentMode = mode
    UpdateModeButtons()
    ShowTab(idx or 1)
  end

  modeMplus:SetScript("OnClick", function() ShowMode("mplus", 1) end)
  modeRaid:SetScript("OnClick", function() ShowMode("raid", 1) end)
  UpdateModeButtons()

  wipe(_liveSectionButtons)
  for i, dungeon in ipairs(DUNGEONS) do
    contentContainers.mplus[i] = PreBuildContent("mplus", i, dungeon, sectionTopY)
  end
  for i, raid in ipairs(RAIDS) do
    contentContainers.raid[i] = PreBuildContent("raid", i, raid, sectionTopY)
  end

  local testCheck = CreateFrame("CheckButton", "MythicHandHoldingTestCheck",
                                f, "UICheckButtonTemplate")
  testCheck:SetSize(20, 20)
  testCheck:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 10, 8)
  testCheck:SetChecked(MythicHandHoldingDB.testMode and true or false)
  local testLabel = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  testLabel:SetPoint("LEFT", testCheck, "RIGHT", 2, 1)
  testLabel:SetText("Test mode (local)")
  testCheck:SetScript("OnClick", function(self)
    if InCombatLockdown() then
      -- Secure macrotext can't be updated mid-combat; if we let the
      -- flag flip, the existing chain (still pointing at /p) would
      -- broadcast on the next click while the local-echo path also
      -- fires.  Revert the checkbox visually and tell the user.
      self:SetChecked(MythicHandHoldingDB.testMode)
      Print("|cffff5555can't toggle Test Mode in combat|r - leave combat first.")
      return
    end
    MythicHandHoldingDB.testMode = self:GetChecked() and true or false
    Print(MythicHandHoldingDB.testMode and "Test Mode ON - local chat only, no broadcast"
                                       or "Test Mode OFF - broadcasting to party/instance")
    RefreshAllMacros()
  end)

  local plainCheck = CreateFrame("CheckButton", "MythicHandHoldingPlainCheck",
                                 f, "UICheckButtonTemplate")
  plainCheck:SetSize(20, 20)
  plainCheck:SetPoint("BOTTOMLEFT", testCheck, "TOPLEFT", 0, 2)
  plainCheck:SetChecked(MythicHandHoldingDB.plainMode and true or false)
  local plainLabel = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  plainLabel:SetPoint("LEFT", plainCheck, "RIGHT", 2, 1)
  plainLabel:SetText("Plain text")
  plainCheck:SetScript("OnClick", function(self)
    MythicHandHoldingDB.plainMode = self:GetChecked() and true or false
    Print(MythicHandHoldingDB.plainMode and "Plain Text ON - hyperlinks disabled"
                                        or "Plain Text OFF - hyperlinks enabled")
  end)
  plainCheck:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText("Plain Text Mode", 1, 1, 1)
    GameTooltip:AddLine("Sends raw text without spell/boss hyperlinks.", 0.8, 0.8, 0.8, true)
    GameTooltip:AddLine("Keep ON until all spell IDs are verified.", 0.8, 0.6, 0.6, true)
    GameTooltip:Show()
  end)
  plainCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)

  if #DUNGEONS > 0 or #RAIDS > 0 then
    local startMode = pendingMode or MythicHandHoldingDB.contentMode or "mplus"
    if #ContentList(startMode) == 0 then
      startMode = (#DUNGEONS > 0) and "mplus" or "raid"
    end
    ShowMode(startMode, pendingTab or 1)
  end
  -- Default-hidden: open via minimap, /mhh, or instance auto-open.
  f:Hide()
  return { frame = f, ShowTab = ShowTab, ShowMode = ShowMode }
end

local function EnsureUI()
  if ui then return ui end
  local ok, res = pcall(BuildUI)
  if ok and res then ui = res
  else Print("UI build failed: " .. tostring(res)) end
  return ui
end

local function ToggleWindow()
  local w = EnsureUI(); if not w then return end
  if w.frame:IsShown() then
    w.frame:Hide()
  else
    C_Timer.After(0, function()
      if w and w.frame then w.frame:Show() end
    end)
  end
end

--=====================================================================
--  MINIMAP BUTTON
--=====================================================================
local minimapBtn

local function MinimapRadius()
  local w = (Minimap and Minimap:GetWidth()) or 140
  return (w / 2) + 5
end

local function UpdateMinimapPos()
  if not minimapBtn then return end
  local angle = math.rad(MythicHandHoldingDB.minimapAngle or 198)
  local r = MinimapRadius()
  minimapBtn:ClearAllPoints()
  minimapBtn:SetPoint("CENTER", Minimap, "CENTER",
    math.cos(angle) * r, math.sin(angle) * r)
end

local function UpdateMinimapShown()
  if not minimapBtn then return end
  if MythicHandHoldingDB.minimapHide then
    minimapBtn:Hide()
  else
    minimapBtn:Show()
  end
end

local function BuildMinimapButton()
  if minimapBtn or not Minimap then return end
  local atan2 = math.atan2 or math.atan

  local b = CreateFrame("Button", "MythicHandHoldingMinimapButton", Minimap)
  b:SetFrameStrata("MEDIUM")
  b:SetFrameLevel(8)
  b:SetSize(31, 31)
  b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  b:RegisterForDrag("LeftButton")

  local icon = b:CreateTexture(nil, "BACKGROUND")
  icon:SetSize(20, 20)
  icon:SetTexture(254882)  -- generic key icon
  icon:SetPoint("CENTER", 0, 1)

  local border = b:CreateTexture(nil, "OVERLAY")
  border:SetSize(53, 53)
  border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
  border:SetPoint("TOPLEFT")

  b:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

  local function dragUpdate()
    local mx, my = Minimap:GetCenter()
    if not mx then return end
    local scale  = Minimap:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    cx, cy = cx / scale, cy / scale
    MythicHandHoldingDB.minimapAngle = math.deg(atan2(cy - my, cx - mx))
    UpdateMinimapPos()
  end
  b:SetScript("OnDragStart", function(self) self:SetScript("OnUpdate", dragUpdate) end)
  b:SetScript("OnDragStop",  function(self) self:SetScript("OnUpdate", nil) end)

  b:SetScript("OnClick", function(_, button)
    if button == "RightButton" then
      MythicHandHoldingDB.minimapHide = true
      UpdateMinimapShown()
      Print("minimap button hidden. /mhh minimap to show it again.")
    else
      ToggleWindow()
    end
  end)

  b:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("Mythic Hand Holding", 1, 1, 1)
    GameTooltip:AddLine("Left-click: toggle window.", 0.8, 0.8, 0.8)
    GameTooltip:AddLine("Right-click: hide this button.", 0.8, 0.8, 0.8)
    GameTooltip:Show()
  end)
  b:SetScript("OnLeave", function() GameTooltip:Hide() end)

  minimapBtn = b
  UpdateMinimapPos()
  UpdateMinimapShown()
end

--=====================================================================
--  AUTO-TAB ON ZONE-IN
--=====================================================================
local function FindContentForCurrentInstance()
  if not IsInInstance() then return nil end
  local name, instType = GetInstanceInfo()
  if not name or name == "" then return nil end
  local n = Norm(name)
  local mode = (instType == "raid") and "raid" or "mplus"
  local list = ContentList(mode)
  for i, entry in ipairs(list) do
    local dn = Norm(entry.name)
    if n == dn or n:find(dn, 1, true) or dn:find(n, 1, true) then
      return mode, i, entry
    end
  end
  return nil
end

local function MaybeAutoSwitchTab()
  local mode, idx, entry = FindContentForCurrentInstance()
  if not idx then return end
  pendingMode = mode
  pendingTab = idx
  if ui and ui.ShowMode then
    ui.ShowMode(mode, idx)
    C_Timer.After(0, function()
      if ui and ui.frame then ui.frame:Show() end
    end)
    Print("auto-switched to " .. entry.name .. " (" .. mode .. ", window opened)")
  end
end

--=====================================================================
--  /mhh ej - dump encounter IDs for the current instance
--=====================================================================
local function DumpEncounterJournal()
  if not IsInInstance() then
    Print("not in an instance - run /mhh ej while in the dungeon.")
    return
  end
  local instName = GetInstanceInfo()
  -- Load the EJ UI module so EJ_* APIs return live data.
  if not EncounterJournal and EncounterJournal_LoadUI then
    pcall(EncounterJournal_LoadUI)
  end
  if not EJ_GetEncounterInfoByIndex then
    Print("EJ API not available.")
    return
  end
  -- EJ_GetCurrentInstance returns the EJ instance ID for the current
  -- zone (NOT the same as GetInstanceInfo's map ID).  This is the ID
  -- EJ_SelectInstance actually wants.
  local ejInstID
  if EJ_GetCurrentInstance then
    ejInstID = EJ_GetCurrentInstance()
  end
  if not ejInstID or ejInstID == 0 then
    Print(("=== %s ==="):format(instName or "?"))
    Print("|cffff5555EJ_GetCurrentInstance returned 0|r - this dungeon may not be in the Encounter Journal yet.")
    return
  end
  pcall(EJ_SelectInstance, ejInstID)
  Print(("=== %s (EJ instanceID %d) ==="):format(instName or "?", ejInstID))
  local i = 1
  local listed = 0
  while true do
    local name, _, encID = EJ_GetEncounterInfoByIndex(i)
    if not name then break end
    Print(("  [\"%s\"] = %s,"):format(name, tostring(encID)))
    listed = listed + 1
    i = i + 1
    if i > 30 then break end
  end
  if listed == 0 then
    Print("no encounters returned.")
  else
    Print(("paste %d line(s) above into BOSS_IDS in the .lua file."):format(listed))
  end
end

--=====================================================================
--  INIT
--=====================================================================
local initialized = false
local function Initialize()
  EnsureDB()
  if initialized then return end
  initialized = true
  EnsureUI()
  BuildMinimapButton()
  MaybeAutoSwitchTab()
end

--=====================================================================
--  SLASH COMMANDS
--=====================================================================
SLASH_MYTHICHANDHOLDING1 = "/mhh"
SLASH_MYTHICHANDHOLDING2 = "/mythichandholding"
SlashCmdList["MYTHICHANDHOLDING"] = function(arg)
  arg = (arg or ""):lower():gsub("%s+", "")
  if arg == "ping" then
    Print("alive, v" .. VERSION ..
          (MythicHandHoldingDB.testMode and " (Test Mode - local chat only)" or ""))
  elseif arg == "test" then
    if InCombatLockdown() then
      Print("|cffff5555can't toggle Test Mode in combat|r - leave combat first.")
    else
      MythicHandHoldingDB.testMode = not MythicHandHoldingDB.testMode
      if _G["MythicHandHoldingTestCheck"] then
        _G["MythicHandHoldingTestCheck"]:SetChecked(MythicHandHoldingDB.testMode)
      end
      RefreshAllMacros()
      Print(MythicHandHoldingDB.testMode and "Test Mode ON - local chat only, no broadcast"
                                         or "Test Mode OFF - broadcasting to party/instance")
    end
  elseif arg == "reset" then
    MythicHandHoldingDB.point = "CENTER"
    MythicHandHoldingDB.x = 0; MythicHandHoldingDB.y = 0
    Print("position reset")
  elseif arg == "auto" then
    MaybeAutoSwitchTab()
  elseif arg == "ej" then
    DumpEncounterJournal()
  elseif arg == "minimap" then
    MythicHandHoldingDB.minimapHide = not MythicHandHoldingDB.minimapHide
    UpdateMinimapShown()
    Print(MythicHandHoldingDB.minimapHide and "minimap button hidden" or "minimap button shown")
  elseif arg == "debug" then
    MythicHandHoldingDB.debug = not MythicHandHoldingDB.debug
    Print(MythicHandHoldingDB.debug
      and "debug ON - >> [chan] and << echo lines will appear locally"
      or  "debug OFF")
  elseif arg == "plain" then
    MythicHandHoldingDB.plainMode = not MythicHandHoldingDB.plainMode
    if _G["MythicHandHoldingPlainCheck"] then
      _G["MythicHandHoldingPlainCheck"]:SetChecked(MythicHandHoldingDB.plainMode)
    end
    Print("Plain Text " .. (MythicHandHoldingDB.plainMode and "ON" or "OFF"))
  elseif arg == "modemplus" or arg == "mplus" then
    if ui and ui.ShowMode then ui.ShowMode("mplus", 1) end
    Print("content mode: Mythic+ dungeons")
  elseif arg == "moderaid" or arg == "raid" then
    if ui and ui.ShowMode then ui.ShowMode("raid", 1) end
    Print("content mode: raids")
  elseif arg == "" then
    ToggleWindow()
  else
    Print("unknown /mhh command: " .. arg)
  end
end

--=====================================================================
--  EVENTS
--=====================================================================
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("PLAYER_REGEN_ENABLED")
ev:RegisterEvent("GROUP_ROSTER_UPDATE")
ev:SetScript("OnEvent", function(_, event)
  if event == "PLAYER_LOGIN" then
    Initialize()
  elseif event == "PLAYER_ENTERING_WORLD" then
    C_Timer.After(0.5, MaybeAutoSwitchTab)
    C_Timer.After(0.6, RefreshAllMacros)
  elseif event == "PLAYER_REGEN_ENABLED" then
    -- Combat ended: catch up on any macrotext updates deferred by lock.
    RefreshAllMacros()
  elseif event == "GROUP_ROSTER_UPDATE" then
    -- Group composition or channel context changed.
    RefreshAllMacros()
  end
end)

if IsLoggedIn() then Initialize() end

Print("v" .. VERSION .. " loaded. Type /mhh")
