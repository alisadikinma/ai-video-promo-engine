---
name: promo-validate
description: >
  Cross-file consistency checker for AI Video Promo Engine references (13 checks).
  Run after editing any reference file, before commits, or after adding new knowledge.
  Triggers on: validate, consistency check, reference check, cek referensi, cek konsistensi.
---

# Validate References

Run 13 automated consistency checks across all operational files. Reports PASS/FAIL per check with exact file:line.

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
- `reference/image-video-gen/*.md` (all 8 files)
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
**Expected:** 23 reference files (12 storytelling + 8 image-video + 3 global/bridge)
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

### Check 9: Cast System Consistency
**Pattern:** References to old single-creator model in operational files
**Expected:** All operational files use cast system terminology (cast-profile, cast-c{N}, Pemeran Utama/Pendamping). No references to `creator-profile.md` (as a generated output), `creator-face.png`, or `creator-brand.png` remain.
**How to verify:** Search all operational files for `creator-face.png`, `creator-brand.png`, `alisadikinface.png` — should return 0 matches. Note: `creator-profile-system.md` as a reference filename is OK (it's the source doc name), but references to generating/saving `creator-profile.md` as output should now be `cast-profile.md`.

### Check 10: Phase 3.5 Hard Block Enforcement
**Pattern:** Pipeline allowing Phase 4 without Phase 3.5 validation
**Expected:** SKILL.md and agent.md both describe Phase 3.5 as mandatory before Phase 4, using "HARD BLOCK" or "cannot proceed" language. No skip/override option exists.
**How to verify:**
1. Search SKILL.md for "Phase 3.5" — must exist with "HARD BLOCK" nearby
2. Search agent.md for "Phase 3.5" — must exist with "HARD BLOCK" nearby
3. Search SKILL.md Phase 3.5 section for "skip" — should return 0 matches
4. Verify Phase 4 Step 4.1 does NOT have optional ref check with skip option

### Check 11: Reference Naming Convention Consistency
**Pattern:** Reference image filenames across all operational files
**Expected:** All reference image filenames follow the naming conventions from `global-promo-config.md` Section 11:
- Cast: `ref/cast-c{N}-face.png`, `ref/cast-c{N}-body.png`, `ref/cast-c{N}-costume.png`
- Product: `ref/product-{name}.png`
- Environment: `ref/env-{location}.png`
- Brand: `ref/brand-{asset}.png`
- Costume: `ref/costume-{institution}.png`
**How to verify:** Search all operational files for `ref/` image references — all must match one of the 7 naming patterns above. No `ref/creator-*` or `ref/ref-*` patterns should remain.

### Check 12: Language Selection Consistency
**Pattern:** Language handling across pipeline files
**Expected:** SKILL.md has Step 1.0 Language Selection with 3 options. global-promo-config.md Section 1 has Language Options table with Bahasa Indonesia/English/Bilingual. agent.md mentions language capability. Strategic brief template in SKILL.md has `Language:` field. Phase 2 in SKILL.md references narration_language.
**How to verify:**
1. Search SKILL.md for "Step 1.0" and "Language Selection" — must exist
2. Search global-promo-config.md for "Language Options" — must have 3-row table
3. Search agent.md for "language" in capabilities — must exist
4. Search SKILL.md Step 1.8 for "Language:" — must be in strategic brief template
5. Search SKILL.md Phase 2 for "narration_language" — must reference it

### Check 13: Tone System Consistency
**Pattern:** Tone handling across pipeline files
**Expected:** SKILL.md has Step 1.7b Tone Selection with 6 options (humorous, serious, professional, inspirational, casual, edgy). global-promo-config.md Section 13 has Tone Impact Matrix with same 6 tones. script-to-scene-bridge.md has tone-to-cinematography mapping (Section 10) with same 6 tones. agent.md mentions tone capability.
**How to verify:**
1. Search SKILL.md for "Step 1.7b" and "Tone" — must exist with 6 options
2. Search global-promo-config.md for "Tone Impact Matrix" — must have 6 tone columns
3. Search script-to-scene-bridge.md for "Tone-to-Cinematography" — must have Section 10 with 6 tones
4. Verify same 6 tone keywords appear in all 3 files (humorous, serious, professional, inspirational, casual, edgy)

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
Check 9: Cast System Consistency ............. PASS (0 legacy refs)
Check 10: Phase 3.5 Hard Block ............... PASS
Check 11: Ref Naming Convention .............. PASS (7/7 patterns)
Check 12: Language Selection Consistency .... PASS
Check 13: Tone System Consistency ........... PASS

Result: 13/13 checks passed
```

If any check FAILS, show:
```
Check N: {Name} ............................ FAIL
  Found in: {file}:{line}
  Expected: {expected}
  Actual: {actual}
  Fix: {suggested fix}
```
