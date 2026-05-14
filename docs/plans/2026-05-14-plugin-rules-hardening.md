# Plugin Rules Hardening — Narrative Arc + NB2 Reference Discipline

**Date:** 2026-05-14
**Author:** Ali Sadikin
**Trigger:** IRN-Logistik production session revealed 4 gaps in plugin enforcement that caused mid-production restructure (BODY 1 single-pain dramatization + over-aggressive cross-scene refs + over-generated NB2 assets).
**Plugin version target:** 2.1.1 → 2.2.0 (minor: additive rules + 1 weakened rule)
**Approach:** Hybrid SSoT (Approach A) — new sections in `reference/global-promo-config.md`, cross-referenced from consumer files.

---

## Design

### Problem Statement

During IRN-Logistik hero video production, 4 issues required mid-production restructure:

1. **Narrative arc completeness gap** — BODY 1 (Agitate) dramatized only 1 of 7 owner pains identified in Phase 1 brainstorm. Result: BODY 2 solutions outweighed BODY 1 problems, Peak emotional weight under-earned. Plugin did NOT block this — F2 narrative arc defines beats but does not enforce pain-coverage completeness.

2. **NB2 over-referencing** — Plugin Phase 4A generates standalone asset for every "recurring element (2+ scenes)". Result: generates references for generic items (plain phone, kopi gelas, concrete pavement) where NB2 could render from text. Wastes Phase 4A generation budget + adds noise to Phase 4B prompt body.

3. **Reference count drift** — Current "Max 3 identity locks per scene" applies to FACES only. Object/environment refs uncounted. Result: scene prompts accumulate 8-10 refs (faces + bodies + costumes + envs + objects + UIs) — NB2 fails to honor priorities at >5.

4. **Cross-scene reference over-enforcement** — Parent CLAUDE.md RULE 3 says "Scene N+1 START MUST reference Scene N END." Result: hard-cut scenes (different env, different character, different prop) carry useless `scene-NN-end.png` cross-refs that confuse NB2.

### User Framework (Locked)

The canonical narrative arc going forward:

```
HOOK → Foreshadow → BODY 1 (Problems) → BODY 2 (Solutions) → Peak → Ending + CTA
```

Maps to existing 7-beat plugin terminology as alias:

| User Beat | Plugin 7-Beat (existing F2) |
|---|---|
| HOOK | Pattern Interrupt + HOOK |
| Foreshadow | FORESHADOW |
| **BODY 1 (Problems)** | **AGITATE** |
| **BODY 2 (Solutions)** | **GUIDE + PLAN** |
| Peak | PEAK |
| Ending + CTA | CTA + WON DAY |

Both terminologies remain valid — user-facing copy uses 6-stage names, internal validator references 7-beat IDs.

### 4 New Rules

#### Rule 1 — BODY 1 Completeness (Hard)

**Rule text:** Count of pains dramatized as dedicated visual scenes in BODY 1 ≥ count of pains identified in Phase 1 emotional-core brainstorm. Pairing allowed when 2 pains share visual logic (single scene dramatizes 2 related pains, e.g., "field blindness" + "container location unknown" both = location-unknown frame).

**Pairing rules:**
- 1 scene can carry max 2 paired pains
- Pairing only valid if pains share root cause (e.g., both = location-blindness, both = data-blindness, both = trust-gap)
- Anchor pain (strongest emotional dramatization) gets dedicated scene at minimum 8-12s — paired pains get 6s each

**Auto-fail triggers:**
- Script overlay text "1 dari N" / "1 of N" / "satu dari banyak" → suggests only 1 problem dramatized → reject
- BODY 1 covers <50% of identified pains → REJECT
- BODY 1 covers 50-99% of pains → AMBER (require user confirmation to proceed)
- BODY 1 covers 100% of pains → PASS

#### Rule 2 — NB2 Reference Uniqueness Filter (Hard)

**Rule text:** Generate Phase 4A standalone asset reference ONLY for unique assets that NB2 cannot reliably render from text alone.

**3-tier classification:**

| Tier | Examples | Action |
|---|---|---|
| **UNIQUE** | Faces, company logos, custom UI screens, industry-specific equipment (UHF RFID reader, fuel sensor probe, ESP32 controller, chassis ID plate), specific product hero shots, location-specific landmarks (Pelindo signage, Batam port gate) | **GENERATE reference** |
| **COMMON** | Generic phone in hand, kopi gelas, concrete pavement, plain office chair, generic paper stack, ceiling fan, generic shirt sleeve, generic concrete wall | **SKIP reference** — let NB2 render from text |
| **AMBIGUOUS** | Anything borderline | Default GENERATE (safer; user drops in Phase 4B) |

**Decision test:** "Can a competent prompt writer describe this in 20 words and trust NB2 to render correctly?" YES → skip reference. NO → generate reference.

**Combined filter:** Asset must be (UNIQUE) AND (recurring 2+ scenes OR critical-identity). If not unique → skip even if recurring.

#### Rule 3 — Max 5 Inline References per Prompt (Hard)

**Rule text:** Each Phase 4B scene prompt has MAX 5 inline references (combined: faces + bodies + costumes + objects + environments + UI). All references inline with the element they describe (no header blocks, no standalone lines). Each filename appears MAX 1× per prompt.

**Replaces:** Old "Max 3 identity locks per scene" (which applied to faces only).

**If prompt needs >5 refs:** Split scene into 2 OR consolidate via composite asset (Tier 5+ in dependency graph).

#### Rule 4 — Cross-Scene Reference Conditional (Environment-Gated)

**Rule text (user-corrected 2026-05-14):** Scene N+1 START frame references Scene N END frame output **ONLY IF same environment (same location)**. Character continuity OR prop continuity alone is NOT sufficient — environment is the sole gating criterion.

**Environment-change case:** If location differs (indoor↔outdoor, office↔yard, yard↔warehouse, etc.) → NO cross-reference. Character/prop continuity carried by text SUBJECT spec + standalone identity refs (cast-c{N}-face.png) ONLY. NO `scene-NN-end.png` cross-ref.

**Same-environment case:** If location continues → cross-reference allowed. Camera/shot-size delta rule (max 15° change, max 1 shot-size step between linked START/END) applies.

**REPLACES:** Parent CLAUDE.md RULE 3 blanket "MUST reference Scene N END" (now strictly environment-gated).

**Camera/shot-size delta rule** (max 15° change, max 1 shot-size step) still applies WITHIN scene (START → END), NOT between scenes.

**Decision algorithm (validator C4):**
```
For each Scene N+1 START that uses `scene-N-end.png` as reference:
  IF env(N) == env(N+1):
    PASS — cross-ref valid
  ELSE:
    FAIL — drop cross-ref, use text-only continuity spec
```

**Examples:**
- Scene 11 (indoor office) → Scene 13 (outdoor customer warehouse) = env differs → **NO cross-ref** (drop `scene-11-end.png`)
- Scene 17 (IRN yard chassis QR scan) → Scene 18 (customer warehouse delivery) = env differs → **NO cross-ref** (drop `scene-17-end.png`, even though same character + same HP prop)
- Scene 2 end (kopitiam table) → Scene 3 start (kopitiam table HP close-up) = same env → **cross-ref valid** ✓
- Scene 24 end (dashboard recap part 1) → Scene 25 start (dashboard recap part 2) = same UI/dashboard env → **cross-ref valid** ✓

### Validator Agent Updates (video-prompt-reviewer.md)

Add 4 new check IDs:

| ID | Check | Trigger Phase | Failure Action |
|---|---|---|---|
| **C1** | BODY 1 pain coverage ≥ 50% (auto-fail <50%, amber 50-99%, pass 100%) | Phase 2 script | FAIL — return to Phase 2 with pain inventory + required dramatization list |
| **C2** | Asset uniqueness filter applied (no generic assets generated) | Phase 4A asset list | FLAG — list generic assets for user dropdown approval |
| **C3** | ≤5 inline refs per Phase 4B prompt | Phase 4B scene prompts | FAIL — return to Phase 4B with split-scene OR composite-asset recommendation |
| **C4** | Cross-scene refs only when ENV continues (env-gated, char/prop alone insufficient) | Phase 4B scene prompts | FAIL — return with cross-ref removal recommendation; visual continuity via text-only SUBJECT + identity ref (cast-c{N}-face.png) |

## Implementation Plan

### File-by-File Changes

#### 1. `reference/global-promo-config.md` (PRIMARY — single source of truth)

**Add Section §25 — Narrative Arc Hard Rules**
- 6-stage user framework alias to 7-beat
- BODY 1 Completeness Rule (Rule 1 above)
- Auto-fail trigger checklist
- Pairing rules

**Add Section §26 — NB2 Reference Image Inclusion Rule**
- Uniqueness Filter (Rule 2)
- 3-tier classification table with examples
- Decision test question
- Max 5 inline refs rule (Rule 3)
- Inline-only enforcement (cross-ref to existing §18)

**Add Section §27 — Cross-Scene Dependency Conditional**
- Conditional rule (Rule 4)
- Replaces parent RULE 3 blanket behavior
- Camera/shot-size delta clarification
- Examples: hard-cut, location-continue, character-continue, prop-continue

#### 2. `reference/storytelling_script_gen/F2_Narrative_Arc_and_Video_Typology.md`

- Add 6-stage user framework table at top
- Cross-ref §25 for BODY 1 Completeness Rule
- Update existing 7-beat description to call out BODY 1 = ALL problems, BODY 2 = ALL solutions paired

#### 3. `reference/storytelling_script_gen/project-instruction.md`

- Add Commandment #9: "BODY 1 must dramatize ALL identified problems from Phase 1 brainstorm. No 'one of many' framing without ALL covered first."
- Update commandment count from 8 → 9

#### 4. `reference/script-to-scene-bridge.md`

- Section 7C (Narrative Arc Consistency): Update "Sequential scenes without this continuity anchor will have inconsistent environments" — add location-change exception
- Section 11 / Required Reference Images: Cross-ref §26 uniqueness filter
- Add cross-scene dependency conditional decision tree (cross-ref §27)

#### 5. `reference/image-video-gen/01-nb2-image-generation.md`

- Section "Reference Image Strategy": Cross-ref §26 uniqueness filter
- Update "Max identity locks" guidance from 3 → 5 combined refs (cross-ref §26)

#### 6. `agents/video-prompt-reviewer.md`

- Add 4 new check entries to validator checklist: C1, C2, C3, C4
- Update PASS/FAIL/AMBER decision logic
- Add per-check action messages (what to return to generator)

#### 7. `skills/video-script/SKILL.md` (Phase 2)

- Add C1 gate at script approval gate
- Phase 2 output must include pain-coverage table showing brainstorm pain → BODY 1 dramatization scene mapping

#### 8. `skills/video-image/SKILL.md` (Phase 4A + 4B)

- Phase 4A: Add C2 uniqueness pre-filter before generating asset
- Phase 4B: Add C3 ref-count check + C4 cross-scene conditional check per batch

#### 9. `CLAUDE.md` (plugin root)

- Update Key Concepts section: add "BODY 1 Pain Coverage" entry referencing §25
- Update Debugging table: add 4 new entries for Rule 1-4 failure modes
- Update Version bump 2.1.1 → 2.2.0

#### 10. `reference/global-promo-config.md` — Version & Changelog

- Bump plugin version
- Add changelog entry for §25-§27 + validator C1-C4

### Phase Execution Order

**Stage 1 — Add new SSoT sections (foundational):**
1. Write §25, §26, §27 in `global-promo-config.md`

**Stage 2 — Update consumer files (cross-references):**
2. F2 narrative arc — add 6-stage framework + cross-ref §25
3. project-instruction.md — add Commandment #9
4. script-to-scene-bridge.md — update Section 7C + cross-ref §27
5. 01-nb2-image-generation.md — cross-ref §26

**Stage 3 — Update validator + skills:**
6. video-prompt-reviewer.md — add C1-C4 checks
7. video-script SKILL.md — add C1 gate
8. video-image SKILL.md — add C2/C3/C4 gates

**Stage 4 — Parent docs:**
9. CLAUDE.md (plugin root) — Key Concepts + Debugging table + version bump

**Stage 5 — Validate:**
10. Run `/video-validate --refs` to verify cross-file consistency
11. Sanity-check by running plugin against IRN-Logistik scenario (mental simulation): does new rule set catch the 4 originally-missed issues?

### Anti-Placeholder Verification

All target files exist (verified via CLAUDE.md mapping). No new external dependencies. All changes are markdown rule documentation. Zero runtime/API/plugin-config changes required.

### Acceptance Criteria

- [ ] global-promo-config.md has §25, §26, §27 with concrete decision tables
- [ ] F2, project-instruction.md, script-to-scene-bridge.md, 01-nb2 cross-reference §25-§27 (no rule duplication)
- [ ] video-prompt-reviewer.md has C1-C4 check entries with PASS/FAIL/AMBER thresholds
- [ ] video-script SKILL.md gates Phase 2 on C1
- [ ] video-image SKILL.md gates Phase 4A on C2 + Phase 4B on C3, C4
- [ ] CLAUDE.md (plugin root) Key Concepts + Debugging table updated
- [ ] Version bumped to 2.2.0
- [ ] `/video-validate --refs` passes
- [ ] Mental simulation: IRN-Logistik scenario rejected at Phase 2 (C1 fail — only 1 of 7 pains in BODY 1) — confirms enforcement works

## Risks & Mitigations

| Risk | Mitigation |
|---|---|
| Rule changes break existing in-flight projects (mid-production) | Plugin version is 2.1.1 → 2.2.0. Existing projects retain their generated outputs. New rules apply to new generations only. No retroactive enforcement. |
| Pairing rule for BODY 1 too lenient — allows under-dramatization via aggressive pairing | Cap: max 2 paired pains per scene, pairing must share root cause. Validator checks pairing logic, not just count. |
| Uniqueness filter mis-classifies (false positives skip useful refs) | Default AMBIGUOUS → generate (safer). User can drop refs in Phase 4B review. |
| Cross-scene conditional too strict — drops valid cross-refs in env-change scenes that share character | INTENTIONAL per user spec (2026-05-14 koreksi): env is the SOLE gating criterion. Character continuity carried by standalone identity refs (cast-c{N}-face.png) — sufficient without `scene-N-end.png` cross-ref. Rationale: NB2 treats scene-end.png as compositional template; cross-environment use confuses model into mixing wrong location elements. |
| Validator agent context bloat from 4 new checks | Checks are additive, ~30 lines per check. Total validator agent stays <1500 lines (well within context). |

## Cross-References

- Plugin CLAUDE.md: `D:\Projects\claude-plugin\ai-video-promo-engine\CLAUDE.md`
- Production trigger session: IRN-Logistik (D:\project-video\IRN-Logistik\)
- Parent project rules: `D:\project-video\CLAUDE.md`
- Plugin issue history: `docs/plans/2026-03-29-plugin-restructure-plan.md` (architectural precedent)

---

**Ready for implementation:** Yes. Stage-by-stage execution map above. Estimated effort: 60-90 minutes focused editing across 9 files.
