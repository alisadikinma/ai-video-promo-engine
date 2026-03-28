---
name: promo-validate
description: >
  Cross-file consistency checker for AI Video Promo Engine references (24 checks).
  Run after editing any reference file, before commits, or after adding new knowledge.
  Triggers on: validate, consistency check, reference check, cek referensi, cek konsistensi.
---

# Validate References

Run 24 automated consistency checks across all operational files. Reports PASS/FAIL per check with exact file:line.

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

### Check 14: VEO No Real Person Names in `says:`
**Pattern:** Real person names used in VEO `says:` syntax across operational files
**Expected:** All VEO dialogue examples and templates use generic roles (`Host says:`, `Presenter says:`, `Speaker says:`), never real person names. NB2 prompts may still use real names.
**How to verify:**
1. Search VEO prompt templates in `script-to-scene-bridge.md` Section 4 for `says:` — should only have generic roles
2. Search `02-veo-production-guide.md` for `says:` examples — should use generic roles
3. Search all operational files for `alisadikin` or `Ali says:` — should return 0 matches
4. Verify `global-promo-config.md` Section 5 `dialogue_syntax` uses `Host says:` not `[Character] says:`

### Check 15: VEO No Em Dash in Audio Text
**Pattern:** Em dash `—` in VEO dialogue/voiceover text across templates
**Expected:** All VEO prompt templates specify "NO em dash" rule. global-promo-config.md has `em_dash_forbidden: true`.
**How to verify:**
1. Search `global-promo-config.md` for `em_dash_forbidden` — should exist and be `true`
2. Search `script-to-scene-bridge.md` VEO templates for "NO em dash" — should appear in every template
3. Search `02-veo-production-guide.md` for em dash rule — should exist in Audio section

### Check 16: VEO B-Roll Has Voice-over Narrator
**Pattern:** B-Roll VEO templates missing voiceover narration
**Expected:** All B-Roll VEO templates use `Voice-over narrator, [tone]: text` syntax (NOT bare `Voiceover:`). Every B-Roll has `POST-PROD VO:` backup. No silent B-Roll.
**How to verify:**
1. Search `script-to-scene-bridge.md` B-Roll template for `Voice-over narrator` — should exist
2. Search `script-to-scene-bridge.md` for bare `Voiceover:` in templates — should return 0 matches (except in "DON'T" examples)
3. Search `script-to-scene-bridge.md` for `POST-PROD VO` — should appear after every B-Roll template
4. Search `global-promo-config.md` for `voiceover_syntax` — should be `Voice-over narrator, [tone]: text`

### Check 17: VEO Face-Dominant Scenes Use Single I2V
**Pattern:** VEO mode selection allowing First+Last Frame for face-dominant scenes
**Expected:** Decision tree in `03-workflow-pipeline.md` and mode selection in `script-to-scene-bridge.md` route face >30% scenes to single I2V, NOT First+Last Frame. Presenter template specifies Single I2V mode.
**How to verify:**
1. Search `03-workflow-pipeline.md` decision tree for "face" or "single I2V" — should describe safety filter rule
2. Search `script-to-scene-bridge.md` Step 3 for face-dominant routing — should exist
3. Search `script-to-scene-bridge.md` Presenter template for "Single I2V" — should exist
4. Search `02-veo-production-guide.md` for face-dominant safety rule — should exist

### Check 18: VEO No Face Ref Filenames
**Pattern:** Face reference filenames (`ref/cast-c{N}-face.png`) appearing in VEO prompt templates
**Expected:** VEO templates use generic continuity language (`Maintain visual continuity with reference frame character appearance`), NOT explicit filenames. Face ref filenames belong ONLY in NB2 templates.
**How to verify:**
1. Search `script-to-scene-bridge.md` Section 4 VEO templates for `ref/cast-c` — should return 0 matches in VEO templates (OK in NB2 Section 3 templates)
2. Search `02-veo-production-guide.md` I2V template for `ref/cast-c` — should return 0 matches
3. Search `global-promo-config.md` Section 16 for NB2 vs VEO distinction — should exist

### Check 19: Scene Logic Realism Checklist
**Pattern:** Scene Logic Realism 7-point checklist in prompt quality gates
**Expected:** `script-to-scene-bridge.md` has Section 7B with 7-point realism checklist. SKILL.md and agent.md reference it in hard rules. Quality gate includes scene realism check.
**How to verify:**
1. Search `script-to-scene-bridge.md` for "Scene Logic Realism" — must exist in Section 7B
2. Search `script-to-scene-bridge.md` Section 7B for all 7 check names: environment accuracy, human behavior realism, data consistency, uniform ranks, explicit negatives, reference photos, timeline/shift
3. Search SKILL.md for "Scene Logic Realism" — must exist in hard rules
4. Search agent.md for "Scene Logic Realism" or "7-point" — must exist in hard rules

### Check 20: Character Portrait-First Rule
**Pattern:** Character portrait-first enforcement across files
**Expected:** `global-promo-config.md` Section 18 has "Character Portrait-First Rule" as HARD BLOCK. SKILL.md and agent.md reference it in hard rules. Phase 4A quality gate checks for it.
**How to verify:**
1. Search `global-promo-config.md` for "Character Portrait-First" — must exist in Section 18
2. Search `global-promo-config.md` for "2+ scenes" near "standalone portrait" — must exist
3. Search SKILL.md for "portrait-first" — must exist in hard rules
4. Search agent.md for "portrait-first" — must exist in hard rules

### Check 21: Narrative Arc Consistency
**Pattern:** Narrative arc consistency rules in prompt templates
**Expected:** `script-to-scene-bridge.md` has Section 7C with narrative arc rules. NB2/VEO templates include `NARRATIVE CONTEXT:` block. SKILL.md and agent.md reference it.
**How to verify:**
1. Search `script-to-scene-bridge.md` for "Narrative Arc Consistency" — must exist in Section 7C
2. Search `script-to-scene-bridge.md` for "NARRATIVE CONTEXT:" — must appear in NB2 start frame template AND VEO templates
3. Search `script-to-scene-bridge.md` for "visual breadcrumb" — must exist in Section 7C
4. Search SKILL.md for "Narrative arc consistency" — must exist in hard rules
5. Search agent.md for "Narrative arc" — must exist in hard rules

### Check 22: Location-Aware Domain Deep Research
**Pattern:** Location context + domain research steps in pipeline before scripting
**Expected:** SKILL.md has Step 1.2c "Location & Setting Context" and Step 1.2d "Domain Deep Research" with location-aware WebSearch protocol (6 queries). `global-promo-config.md` has Section 24 with location-specific research config including "Local Differentiators" table. Agent.md references location-aware domain research. NB2/VEO templates include `DOMAIN CONTEXT:` line.
**How to verify:**
1. Search SKILL.md for "Step 1.2c" and "Location" — must exist
2. Search SKILL.md for "Step 1.2d" and "Domain Deep Research" — must exist
3. Search `global-promo-config.md` for "Section 24" and "Location" — must exist with location-specific queries
4. Search `global-promo-config.md` for "Local Differentiators" — must exist in Section 24
5. Search agent.md for "location-aware" or "domain research" — must exist in capabilities and hard rules
6. Search `script-to-scene-bridge.md` for "DOMAIN CONTEXT:" — must appear in NB2/VEO templates
7. Search SKILL.md strategic brief template for "Domain Knowledge" — must exist

### Check 23: NB2 Identity Lock Filename-Only Syntax
**Pattern:** NB2 identity lock lines or reference image mentions in prompt body templates using `ref/` folder prefix
**Expected:** All NB2 prompt body text (identity lock syntax, reference image injection lines, prompt templates/examples) uses bare filenames only — NO `ref/` or `keyframes/` folder prefix. The `ref/` prefix is valid ONLY in: `**Output →** ref/` lines (filesystem paths), upload table paths, directory structure docs, and ref naming convention docs. Inside NB2 prompt body text, `ref/filename.png` fails because NB2 matches by uploaded filename, not path.
**How to verify:**
1. Search `script-to-scene-bridge.md` Section 3 NB2 templates for `Maintain exact facial identity from reference image: ref/` — should return 0 matches (must use bare filename)
2. Search `script-to-scene-bridge.md` Section 3 NB2 templates for `Using reference image ref/` — should return 0 matches
3. Search SKILL.md Phase 4B prompt instructions for `inject \`ref/` — should return 0 matches (continuity injection must use bare filename in prompt body)
4. Search agent.md hard rules for `Maintain exact facial identity from reference image: ref/` — should return 0 matches
5. Verify SKILL.md has hard rule 45 stating "NB2 identity lock: filename only (NO folder prefix like ref/ or keyframes/)"
6. Verify SKILL.md Scene Keyframe Quality Gate has check for filename-only identity lock

### Check 24: Inline-Only Reference Pattern
**Pattern:** NB2 prompt templates or examples using header block pattern for reference images instead of inline-only pattern
**Expected:** All NB2 prompt templates and examples use inline-only reference pattern — filenames appear inline with the element they describe (identity lock inline with character, object ref inline with element, continuity ref inline with continuity statement). No header blocks like `Using reference image xxx.png for [purpose]` at top of prompts. No standalone identity lock lines separated from character description. No duplicate filenames within same prompt. SKILL.md has hard rule 46 for inline-only pattern.
**How to verify:**
1. Search `script-to-scene-bridge.md` Section 3 NB2 templates for `Using reference image` as standalone header lines — should return 0 matches in templates (only valid in legacy few-shot "BAD" examples)
2. Search `global-promo-config.md` Section 16 for "header block" — should exist in BANNED patterns list
3. Search `global-promo-config.md` Section 16 for "Inline-Only" or "inline-only" — should exist as section title or rule
4. Verify SKILL.md has hard rule 46 stating "Inline-only reference pattern"
5. Verify SKILL.md Scene Keyframe Quality Gate has checks for: no header blocks, no standalone identity lock lines, no duplicate filenames
6. Verify agent.md hard rules include inline-only reference pattern
7. Verify `prompt-reviewer-agent.md` has checklist item for inline-only pattern verification

## Output Format

```
=== Promo Engine Validation Report ===

Check 1:  VEO Mode Mutual Exclusivity ........ PASS
Check 2:  Audio Mandatory Rule ............... PASS
Check 3:  Dialogue Colon Syntax .............. PASS
Check 4:  Resolution Extend Rule ............. PASS
Check 5:  Reference File Count ............... PASS (23/23)
Check 6:  7-Beat Arc Completeness ............ PASS (8/8 beats)
Check 7:  Forbidden Words List ............... PASS (8/8 words)
Check 8:  Face Minimum Percentage ............ PASS (30%)
Check 9:  Cast System Consistency ............ PASS (0 legacy refs)
Check 10: Phase 3.5 Hard Block ............... PASS
Check 11: Ref Naming Convention .............. PASS (7/7 patterns)
Check 12: Language Selection Consistency ...... PASS
Check 13: Tone System Consistency ............ PASS
Check 14: VEO No Real Names in says: ......... PASS
Check 15: VEO No Em Dash in Audio ............ PASS
Check 16: VEO B-Roll Has VO Narrator ......... PASS
Check 17: VEO Face-Dominant Single I2V ........ PASS
Check 18: VEO No Face Ref Filenames .......... PASS
Check 19: Scene Logic Realism Checklist ....... PASS (7/7 points)
Check 20: Character Portrait-First Rule ....... PASS
Check 21: Narrative Arc Consistency ........... PASS
Check 22: Domain Deep Research ................ PASS
Check 23: NB2 Identity Lock Filename-Only ..... PASS
Check 24: Inline-Only Reference Pattern ....... PASS

Result: 24/24 checks passed
```

If any check FAILS, show:
```
Check N: {Name} ............................ FAIL
  Found in: {file}:{line}
  Expected: {expected}
  Actual: {actual}
  Fix: {suggested fix}
```
