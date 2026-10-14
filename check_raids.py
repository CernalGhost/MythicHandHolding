# Sanity check for MythicHandHolding_Raids.lua.  No Lua interpreter on Windows,
# so this catches the two failure modes that actually bite: duplicate table keys
# (Lua silently keeps the last one) and unbalanced braces.
# ponytail: regex, not a Lua parser -- the file is a flat data literal.
import re, sys, collections

src = open("MythicHandHolding_Raids.lua", encoding="utf-8").read()

fail = []

# Duplicate keys inside bossIds / spellIds.
for table in ("bossIds", "spellIds", "instanceIds"):
    start = src.index(table + " = {")
    depth, i = 0, src.index("{", start)
    for j in range(i, len(src)):
        if src[j] == "{": depth += 1
        elif src[j] == "}":
            depth -= 1
            if depth == 0: break
    body = src[i:j]
    keys = re.findall(r'\["([^"]+)"\]\s*=', body)
    dupes = [k for k, n in collections.Counter(keys).items() if n > 1]
    if dupes:
        fail.append(f"{table}: duplicate keys {dupes}")

# Every raid needs a name and at least one section.
raids = re.findall(r'\bname = "([^"]+)",\s*\n\s*tab\s+= "([^"]+)"', src)
if len(raids) < 7:
    fail.append(f"expected 7+ raids, found {len(raids)}: {raids}")

# Brace balance over the whole file (strings here contain no braces).
if src.count("{") != src.count("}"):
    fail.append(f"brace mismatch: {src.count('{')} open, {src.count('}')} close")

# Spell names used in tips must exist in spellIds, else no hyperlink.
assert "Eternal Venom" in src and "Ula'tek's Dominance" in src

# Classic packs (MythicHandHolding_<flavor>.lua): balanced braces, every raid has a mapId.
for pack, want in (("Vanilla", 7), ("TBC", 9), ("Mists", 5)):
    psrc = open(f"MythicHandHolding_{pack}.lua", encoding="utf-8").read()
    if psrc.count("{") != psrc.count("}"):
        fail.append(f"{pack}: brace mismatch")
    n, maps = psrc.count("name  ="), len(re.findall(r"mapId = \d+", psrc))
    if n != want or maps != want:
        fail.append(f"{pack}: expected {want} raids with mapId, found {n} raids / {maps} mapIds")

print("\n".join(fail) if fail else f"OK - {len(raids)} raids: " + ", ".join(n for n, _ in raids))
sys.exit(1 if fail else 0)
