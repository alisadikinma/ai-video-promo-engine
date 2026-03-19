---
name: promo-validate
description: >
  Cross-file consistency checker for AI Video Promo Engine references (8 checks).
  Run after editing any reference file, before commits, or after adding new knowledge.
  Triggers on: validate, consistency check, reference check, cek referensi, cek konsistensi.
---

# Validate References

Run 8 automated consistency checks across all operational files. Reports PASS/FAIL per check with exact file:line.

## Scope

**Operational files** (checked):
- `skills/promo-engine/SKILL.md`
- `skills/promo-validate/SKILL.md`
- `skills/promo-add-platform/SKILL.md`
- `agents/promo-engine-agent.md`
- `reference/global-promo-config.md`
- `reference/creator-profile-system.md`
- `reference/script-to-scene-bridge.md`
- `reference/storytelling_script_gen/*.md` (all 12 files)
- `reference/image-video-gen/*.md` (all 7 files)
- `CLAUDE.md`

**Excluded:**
- `docs/plans/*.md`
- `.claude-plugin/*.json`
- Output files

## Checks

### Check 1: VEO Mode Mutual Exclusivity
**Pattern:** Any mention of combining "Ingredients" and "First+Last Frame" in same generation
**Expected:** Always described as mutually exclusive, never combined
**How to verify:** Search all files for "Ingredients" near "First+Last Frame" — must include "mutually exclusive" or "cannot combine" or "pick ONE"

### Check 2: Audio Mandatory Rule
**Pattern:** Any reference to VEO audio being optional
**Expected:** Audio always described as mandatory/required, never optional
**How to verify:** Search for "audio" + "optional" — should only appear in negation ("NOT optional", "NEVER optional")

### Check 3: Dialogue Colon Syntax
**Pattern:** VEO dialogue examples using quotation marks instead of colon syntax
**Expected:** All dialogue examples use `says:` colon syntax, never `says "text"`
**How to verify:** Search for `says "` or `says '` — should return 0 matches (except in "DON'T" examples)

### Check 4: Resolution Extend Rule
**Pattern:** 1080p described as extendable
**Expected:** Only 720p is extendable, 1080p CANNOT extend
**How to verify:** Search for "1080p" + "extend" — must always say "cannot" or "CANNOT"

### Check 5: Reference File Count
**Pattern:** Total reference file count in CLAUDE.md and SKILL.md
**Expected:** 22 reference files (12 storytelling + 7 image-video + 3 global/bridge)
**How to verify:** Count file entries in Reference Files tables in CLAUDE.md, SKILL.md, and agent.md

### Check 6: 7-Beat Arc Completeness
**Pattern:** Beat labels in storytelling references
**Expected:** All 7 beats present: Pattern Interrupt, Hook, Foreshadow, Agitate, Guide+Plan, Peak, CTA, Won Day
**How to verify:** Search `project-instruction.md` and CLAUDE.md for all beat names

### Check 7: Forbidden Words List
**Pattern:** Forbidden words in CLAUDE.md vs project-instruction.md
**Expected:** Same 8 forbidden words in both files
**How to verify:** Extract forbidden words list from both files, compare

### Check 8: Face Minimum Percentage
**Pattern:** Minimum face percentage for lip sync
**Expected:** 30% consistently across all files
**How to verify:** Search for face percentage — should always be "30%" or ">30%"

## Output Format

```
=== Promo Engine Validation Report ===

Check 1: VEO Mode Mutual Exclusivity ......... PASS
Check 2: Audio Mandatory Rule ................ PASS
Check 3: Dialogue Colon Syntax ............... PASS
Check 4: Resolution Extend Rule .............. PASS
Check 5: Reference File Count ................ PASS (22/22)
Check 6: 7-Beat Arc Completeness ............. PASS (8/8 beats)
Check 7: Forbidden Words List ................ PASS (8/8 words)
Check 8: Face Minimum Percentage ............. PASS (30%)

Result: 8/8 checks passed
```

If any check FAILS, show:
```
Check N: {Name} ............................ FAIL
  Found in: {file}:{line}
  Expected: {expected}
  Actual: {actual}
  Fix: {suggested fix}
```
