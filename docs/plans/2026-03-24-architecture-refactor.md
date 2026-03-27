> **For Claude:** REQUIRED SKILL: Use gaspol-execute to implement this plan.
> **CRITICAL:** This plan modifies plugin architecture. Every edit must preserve
> existing functionality while adding new capabilities. Run /promo-validate after
> each phase to verify cross-file consistency.

## Goal

Refactor /promo-engine plugin architecture to fix the root cause of poor output quality: context overload, self-check bias, and rule blindness. Three structural changes: smart context loading (load only what's needed per phase), batch execution with independent validator (max 5 scenes/batch + separate reviewer agent), and few-shot examples (GOOD vs BAD pairs for critical rules).

## Architecture Context

**Current state (from SKILL.md):**
- 6-phase pipeline with approval gates between phases
- Phase 4B loops "For each scene in scene-plan.md" — no batching, all scenes in 1 pass
- Phase 5 same pattern — all scenes in 1 pass
- Phase 4A has tier-by-tier batching (only phase with batch logic)
- 44 hard rules, 9-point realism checklist, quality gates per phase
- 23 reference files, all listed in one place — Claude tends to load most/all regardless of phase
- 1 agent (promo-engine-agent.md) handles everything — no independent validation

**Target state:**
- Same 6-phase pipeline (iterative, not rewrite)
- Phase 4B/5: batch by ACT (max 5 scenes/batch), fresh context per batch
- NEW agent: prompt-reviewer-agent.md (independent validator, no generation instructions)
- Per-phase loading manifest: explicit READ list per phase (3-11 files, not 23)
- Few-shot GOOD/BAD examples for 5 critical rules

## Data Integration Map

| Feature | Data Source | File | Exists? | Action |
|---------|-----------|------|---------|--------|
| Phase READ lists | SKILL.md per-phase steps | skills/promo-engine/SKILL.md | Partial — files listed but not strict manifest | Refactor to explicit `### CONTEXT LOADING` block per phase |
| Batch loop logic | SKILL.md Phase 4B | skills/promo-engine/SKILL.md | No — currently "for each scene" | Add batch-by-ACT loop wrapping existing scene loop |
| Batch loop Phase 5 | SKILL.md Phase 5 | skills/promo-engine/SKILL.md | No | Same pattern as 4B |
| Validator agent | agents/ directory | agents/prompt-reviewer-agent.md | No | Create new file |
| Validator in plugin.json | .claude-plugin/plugin.json | .claude-plugin/plugin.json | No — only lists promo-engine-agent | Add prompt-reviewer-agent |
| Session start hook | hooks/session-start.sh | hooks/session-start.sh | Yes — announces 1 agent | Update to announce 2 agents |
| Few-shot examples | reference/script-to-scene-bridge.md | reference/script-to-scene-bridge.md | No | Add GOOD/BAD pairs in Sections 5, 7A, 7B, 7D |
| Few-shot examples | reference/image-video-gen/03-workflow-pipeline.md | reference/image-video-gen/03-workflow-pipeline.md | No | Add GOOD/BAD pair for camera constraint |
| CLAUDE.md architecture docs | CLAUDE.md | CLAUDE.md | Yes | Update to reflect new architecture |

---

## Phase A: Smart Context Loading — SKILL.md

**Files:**
- Modify: `skills/promo-engine/SKILL.md`

**Steps:**

1. Read SKILL.md Phase 1 (around line 139). Find the READ instruction. Replace with explicit `CONTEXT LOADING` block:
```markdown
### CONTEXT LOADING — Phase 1
READ these files ONLY (do NOT read other reference files):
1. `reference/global-promo-config.md`
2. `reference/creator-profile-system.md`
3. `reference/storytelling_script_gen/F1_Audience_Psychology_Matrix.md`
4. `reference/storytelling_script_gen/F8_Awareness_Level_Routing.md`
Total: 4 files. Do NOT preload Phase 2-5 references.
```

2. Read SKILL.md Phase 2 (around line 596). Replace READ instruction with:
```markdown
### CONTEXT LOADING — Phase 2
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 13-15 only: tone, cultural, language)
2. `reference/storytelling_script_gen/project-instruction.md`
3. `reference/storytelling_script_gen/F2_Narrative_Arc_and_Video_Typology.md`
4. `reference/storytelling_script_gen/F3_Cinematic_AV_Production_Rules.md`
5. `reference/storytelling_script_gen/F5_Hook_Vault.md`
6. `reference/storytelling_script_gen/F6_CTA_Vault.md`
7. `reference/storytelling_script_gen/F7_Foreshadow_and_Peak_Engineering.md`
8. `reference/storytelling_script_gen/F9_Platform_Adaptation_Matrix.md`
9. `reference/storytelling_script_gen/F10_Modular_Asset_and_AB_Testing.md`
10. `reference/storytelling_script_gen/F11_Pattern_Interrupt_and_Retention.md`
11. IF product is EV-related: `reference/storytelling_script_gen/F4_EV_Persona_Matrix.md`
Total: 10-11 files. This is the heaviest phase — script generation needs most references.
IMPORTANT: Do NOT load image-video-gen/ files in this phase.
```

3. Read SKILL.md Phase 3 (around line 658). Replace READ instruction with:
```markdown
### CONTEXT LOADING — Phase 3
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 6-10 only: output, resolution, VEO modes)
2. `reference/script-to-scene-bridge.md` (Sections 1-2 only: scene mapping, VEO mode selection)
3. `reference/image-video-gen/03-workflow-pipeline.md`
Total: 3 files. Do NOT load NB2 or storytelling files.
```

4. Read SKILL.md Phase 3.5 (around line 693). Replace READ instruction with:
```markdown
### CONTEXT LOADING — Phase 3.5
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 11-12 only: ref naming, categories)
2. `reference/creator-profile-system.md` (cast ref requirements only)
Plus: READ `{output_folder}/cast-profile.md` and `{output_folder}/scene-plan.md` as data inputs.
Total: 2 reference files + 2 output files.
```

5. Read SKILL.md Phase 4A (around line 936). Replace READ instruction with:
```markdown
### CONTEXT LOADING — Phase 4A
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 17-23: asset categories, dependency graph, NB2 defaults)
2. `reference/image-video-gen/01-nb2-image-generation.md`
3. `reference/script-to-scene-bridge.md` (Section 7B ONLY: 9-point realism checklist)
Plus: READ `{output_folder}/cast-profile.md`, `{output_folder}/scene-plan.md`, `{output_folder}/strategic-brief.md` (Domain Knowledge section only).
Total: 3 reference files + 3 output files. Do NOT load storytelling, VEO, or cinematography files.
```

6. Read SKILL.md Phase 4B (around line 1039). Replace READ instruction with:
```markdown
### CONTEXT LOADING — Phase 4B (per batch)
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 16-20: upload table, asset categories, NB2 defaults, aspect ratio)
2. `reference/image-video-gen/01-nb2-image-generation.md`
3. `reference/script-to-scene-bridge.md` (Sections 3-7 only: templates, transitions, checklists)
4. `reference/image-video-gen/04-cinematography-lookup.md`
Plus PER-BATCH context (NOT full files):
- `{output_folder}/cast-profile.md`: ONLY entries for characters appearing in this batch's scenes
- `{output_folder}/scene-plan.md`: ONLY entries for this batch's scenes
- `{output_folder}/strategic-brief.md`: Domain Knowledge section only
- Previous batch's last scene END frame filename (for dependency chain)
Total: 4 reference files + filtered output data. NEVER load storytelling or VEO files.
```

7. Read SKILL.md Phase 5 (around line 1095). Replace READ instruction with:
```markdown
### CONTEXT LOADING — Phase 5 (per batch)
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 6-10, 13: output, resolution, VEO modes, tone)
2. `reference/image-video-gen/02-veo-production-guide.md`
3. `reference/image-video-gen/03-workflow-pipeline.md`
4. `reference/image-video-gen/04-cinematography-lookup.md`
Plus PER-BATCH context:
- `{output_folder}/cast-profile.md`: ONLY entries for characters in this batch
- `{output_folder}/scene-plan.md`: ONLY entries for this batch's scenes
- `{output_folder}/av-script.md`: ONLY the AV rows for this batch's scenes
- `{output_folder}/image-prompts.md`: ONLY the prompts for this batch's scenes (as NB2→VEO reference)
Total: 4 reference files + filtered output data. NEVER load storytelling or NB2-specific files.
```

**Verification:**
- [ ] Every phase (1, 2, 3, 3.5, 4A, 4B, 5) has explicit `### CONTEXT LOADING` block
- [ ] No phase loads more than 11 reference files
- [ ] Phase 4B and 5 specify "per batch" context loading
- [ ] Each block ends with "Do NOT load [irrelevant files]" instruction
- [ ] `reference/global-promo-config.md` specifies WHICH SECTIONS per phase (not whole file)

---

## Phase B: Batch Execution — Phase 4B Refactor

**Files:**
- Modify: `skills/promo-engine/SKILL.md` (Phase 4B section, around lines 1037-1089)

**Steps:**

1. Read the current Phase 4B structure (Step 4B.2 "For each scene in scene-plan.md"). Wrap the existing scene loop inside a new batch loop. Replace the current loop with:

```markdown
### Step 4B.2: Batch-by-ACT Generation

**BATCH EXECUTION — max 5 scenes per batch.**

Group scenes by ACT from scene-plan.md. Each ACT = 1 batch. If an ACT has >5 scenes, split into sub-batches of max 5.

```
FOR each batch (ACT or sub-batch):

  1. CONTEXT RELOAD (fresh per batch):
     → Re-read Phase 4B CONTEXT LOADING files
     → Load ONLY this batch's cast entries + scene entries
     → Load previous batch's LAST scene END frame filename as dependency anchor

  2. GENERATE prompts for this batch's scenes:
     FOR each scene in this batch:
       [existing per-scene generation logic — Frame mode / Ingredients mode / Apply checks]
     END FOR

  3. VALIDATE — spawn prompt-reviewer agent:
     → Agent tool: subagent_type="ai-video-promo-engine:prompt-reviewer"
     → Pass: this batch's generated prompts + cast-profile.md + scene-plan.md
     → Agent returns: PASS / FAIL with per-prompt feedback

  4. IF validator returns FAIL:
     → Read validator feedback (specific prompts + specific issues)
     → Re-generate ONLY the failing prompts (not entire batch)
     → Re-validate (max 2 retry cycles per batch)

  5. APPROVE — AskUserQuestion:
     "Batch {N} ({ACT name}, Scenes {X}-{Y}) ready for review."
     A) Approve batch — proceed to next batch
     B) Revise specific scenes — list scene numbers
     C) Regenerate entire batch — start fresh

  6. APPEND approved batch to {output_folder}/image-prompts.md

END FOR
```

Write the Generation Checklist and Dependency Chain table AFTER all batches complete.
```

2. Update Step 4B.3 (Approval) to reflect batch-level approval is now handled inside the loop. The final Step 4B.3 becomes a "full file review" step:

```markdown
### Step 4B.3: Final Review

After ALL batches are generated and approved:
1. Read the complete `{output_folder}/image-prompts.md`
2. Verify cross-batch dependency chain integrity (Scene N→N+1 references correct across batch boundaries)
3. Present summary:
   - Total batches: {N}
   - Total scenes: {M}
   - Validator pass rate: {X}% first-pass, {Y}% after retry
4. AskUserQuestion: final approval or revision
```

**Verification:**
- [ ] Phase 4B has outer batch loop wrapping inner scene loop
- [ ] Each batch starts with CONTEXT RELOAD
- [ ] Each batch spawns prompt-reviewer agent after generation
- [ ] Retry logic limited to max 2 cycles
- [ ] Batch output appended (not overwritten) to image-prompts.md
- [ ] Cross-batch dependency chain verified in final review step

---

## Phase C: Batch Execution — Phase 5 Refactor

**Files:**
- Modify: `skills/promo-engine/SKILL.md` (Phase 5 section, around lines 1093-1157)

**Steps:**

1. Apply same batch pattern as Phase 4B. Wrap Phase 5 scene loop in batch-by-ACT loop:

```markdown
### Step 5.1: Batch-by-ACT VEO Generation

**BATCH EXECUTION — max 5 scenes per batch.**

Same ACT grouping as Phase 4B.

```
FOR each batch (ACT or sub-batch):

  1. CONTEXT RELOAD (fresh per batch):
     → Re-read Phase 5 CONTEXT LOADING files
     → Load ONLY this batch's scene entries + cast entries + AV script rows
     → Load this batch's NB2 keyframes from image-prompts.md (as NB2→VEO reference)

  2. GENERATE VEO prompts for this batch's scenes:
     FOR each scene in this batch:
       [existing per-scene VEO generation logic — Presenter / B-Roll / Extension]
     END FOR

  3. VALIDATE — spawn prompt-reviewer agent:
     → Agent tool: subagent_type="ai-video-promo-engine:prompt-reviewer"
     → Pass: this batch's VEO prompts + scene-plan.md + image-prompts.md (this batch only)
     → Agent returns: PASS / FAIL with per-prompt feedback

  4. IF FAIL → re-generate failing prompts only (max 2 retries)

  5. APPROVE — AskUserQuestion per batch

  6. APPEND to {output_folder}/video-prompts.md

END FOR
```
```

2. Update Step 5.3-5.4 to be final review + summary (same pattern as Phase 4B.3).

**Verification:**
- [ ] Phase 5 has batch loop matching Phase 4B pattern
- [ ] VEO prompts reference correct NB2 keyframes per batch
- [ ] Validator checks VEO-specific rules (audio layers, lip sync, no em dash)
- [ ] Summary includes batch count and validator pass rate

---

## Phase D: Create Prompt Reviewer Agent

**Files:**
- Create: `agents/prompt-reviewer-agent.md`
- Modify: `.claude-plugin/plugin.json` (add agent entry)
- Modify: `hooks/session-start.sh` (announce new agent)
- Modify: `CLAUDE.md` (document new agent)

**Steps:**

1. Read existing `agents/promo-engine-agent.md` to understand agent file format.

2. Create `agents/prompt-reviewer-agent.md` with this content:

```markdown
# Prompt Reviewer Agent

Independent validation agent for AI Video Promo Engine output. Reviews NB2 image prompts and VEO video prompts for quality, consistency, and rule compliance.

## CRITICAL: This agent is a VALIDATOR, not a GENERATOR.
- You have NO access to generation templates or storytelling references.
- You receive ONLY: the generated prompts + ground truth files (cast-profile, scene-plan).
- Your job: find issues the generator missed. Be strict. Be specific.
- You cannot "fix" prompts — only report issues with exact line references.

## Input

You will receive:
1. **Batch prompts** — a set of NB2 or VEO prompts for review (max 5 scenes)
2. **cast-profile.md** — character definitions (ground truth for costume, face refs)
3. **scene-plan.md** — scene specifications (ground truth for VEO mode, duration, resolution)
4. **Previous batch's last scene END frame filename** (for dependency chain validation)

## Validation Checklist

For EACH prompt in the batch, run ALL checks below. Report PASS or FAIL per check per prompt.

### A. Dependency Chain (NB2 only)
- [ ] Scene 2+ has `ref/scene-{NN-1}-end.png` in upload table
- [ ] Scene 2+ has `Using reference image scene-{NN-1}-end.png` in prompt body
- [ ] First scene in batch references last scene of previous batch (cross-batch continuity)

### B. Character Costume Consistency
- [ ] Every character's costume description is VERBATIM from cast-profile.md
- [ ] No paraphrasing, no abbreviation, no additions not in the profile
- [ ] Same character has IDENTICAL costume text across all prompts in batch

### C. Prop/Object Scale
- [ ] Every handheld prop has dimensions in cm/mm
- [ ] Every handheld prop has real-world analogy
- [ ] Every handheld prop has proportion relative to hand/body
- [ ] Every handheld prop has explicit negative for wrong sizes

### D. Camera Angle Constraint (NB2 Frame mode only)
- [ ] START and END frame share same lens focal length
- [ ] Shot size change is max 1 step (CU↔MCU↔MS↔MWS↔WS)
- [ ] Camera angle change is max 15 degrees
- [ ] If violated: report which scene, what the START says, what the END says

### E. Aspect Ratio
- [ ] NB2: aspect ratio in FIRST line, TECHNICAL section, LAST line (triple enforcement)
- [ ] VEO: aspect ratio in first line of prompt

### F. Scene Logic Realism (9-point)
- [ ] 1. Environment matches cultural research / ref images
- [ ] 2. Human behavior is plausible (workers work, supervisors supervise)
- [ ] 3. Data/display numbers consistent across scenes
- [ ] 4. Uniforms match rank/role
- [ ] 5. Explicit negatives present
- [ ] 6. Every ref in upload table has injection line in prompt body
- [ ] 7. Time-of-day lighting consistent across connected scenes
- [ ] 8. Prop/object at correct scale
- [ ] 9. DOMAIN CONTEXT populated with specific details (not generic)

### G. VEO-Specific (VEO prompts only)
- [ ] Correct VEO mode per scene-plan.md
- [ ] Face >30% scenes use Single I2V (NOT First+Last Frame)
- [ ] All 3 audio layers specified
- [ ] Dialogue uses `Host says:` (no real names)
- [ ] Voiceover uses `Voice-over narrator, [tone]:` (not bare `Voiceover:`)
- [ ] Every B-Roll has VO narration + `> POST-PROD VO:` backup
- [ ] No em dash `—` in says:/narrator: text
- [ ] No face ref filenames in VEO prompts
- [ ] 720p for extendable clips

### H. Upload Table Completeness
- [ ] Every ref image in prompt body has matching row in upload table
- [ ] Every row in upload table has matching injection line in prompt body
- [ ] Upload table has row for previous scene output (scenes 2+)

## Output Format

Return a structured report:

```
## Batch Validation Report

**Batch:** {ACT name} | Scenes {X}-{Y}
**Verdict:** PASS / FAIL

### Per-Scene Results

| Scene | Check A | Check B | Check C | Check D | Check E | Check F | Check G | Check H | Verdict |
|-------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
| {NN}  | ✅/❌   | ✅/❌   | ✅/❌   | ✅/❌   | ✅/❌   | ✅/❌   | ✅/❌   | ✅/❌   | PASS/FAIL |

### Issues Found (FAIL items only)

**Scene {NN} — Check {X}: {check name}**
- Problem: {exact description}
- Location: {line reference or quote from prompt}
- Expected: {what it should be}
- Source: {cast-profile.md line X / scene-plan.md line Y}
```

## Rules for the Reviewer

1. Be STRICT. If in doubt, FAIL it. A false positive is cheaper than a missed issue.
2. Quote exact text from the prompt when reporting issues.
3. Quote exact text from cast-profile.md when reporting costume mismatches.
4. For camera angle issues, state both the START and END camera lines.
5. Do NOT suggest fixes — only report issues. The generator will fix them.
6. Do NOT access generation templates, storytelling files, or any reference/ files except through the prompts being reviewed.
```

3. Read `.claude-plugin/plugin.json` and add the prompt-reviewer agent entry alongside the existing promo-engine-agent.

4. Read `hooks/session-start.sh` and add the prompt-reviewer agent announcement.

5. Read CLAUDE.md Architecture section and add prompt-reviewer-agent.md to the table.

**Verification:**
- [ ] `agents/prompt-reviewer-agent.md` exists with full validation checklist
- [ ] Agent has NO references to generation templates or storytelling files
- [ ] Agent output format is structured (table + per-issue detail)
- [ ] plugin.json lists both agents
- [ ] session-start.sh announces both agents
- [ ] CLAUDE.md documents the new agent

---

## Phase E: Few-Shot Examples — script-to-scene-bridge.md

**Files:**
- Modify: `reference/script-to-scene-bridge.md`

**Steps:**

1. Read Section 5 (Last Frame Secret / Scene Transition Handling, around line 497-510). After the MANDATORY rule text, add:

```markdown
#### Few-Shot: Dependency Chain

**BAD — no previous scene reference:**
```
#### START Frame → ref/scene-15-start.png
Using reference image cast-c1-face.png for driver face.
Using reference image vehicle-truck.png for truck.

Photorealistic medium shot at the stockpile area...
```
WHY BAD: Scene 15 has no reference to Scene 14 end frame. Environment, lighting, and character position will be inconsistent with the previous scene.

**GOOD — previous scene anchored:**
```
#### START Frame → ref/scene-15-start.png
Using reference image scene-14-end.png for environment continuity, lighting, and character position from previous scene.
Using reference image cast-c1-face.png for driver face.
Using reference image vehicle-truck.png for truck.

Photorealistic medium shot — continuation of scene-14-end.png. The SAME stockpile environment...
```
WHY GOOD: Scene 14 end frame is the FIRST reference listed, anchoring all visual elements.
```

2. Read Section 7B check 8 (Prop/Object Scale, around line 588). After the check row, add:

```markdown
#### Few-Shot: Prop Scale

**BAD — no size specification:**
```
The officer hands the routing slip to the driver through the window.
```
WHY BAD: "Routing slip" gives no size information. NB2 will generate it as A4 paper.

**GOOD — full size specification:**
```
The officer pinches a tiny thermal receipt slip between thumb and index finger — 5.7cm wide, ~15cm long, like a convenience store cash register receipt or ATM receipt. The slip is narrower than a credit card and LESS THAN the width of the officer's palm. NOT a sheet of paper, NOT A4, NOT letter size.
```
WHY GOOD: 4 anchors — exact cm, real-world analogy, hand proportion, explicit negative.
```

3. Read Section 7B check 9 (Domain Context, around line 589). After the check row, add:

```markdown
#### Few-Shot: Domain Context

**BAD — generic placeholder:**
```
DOMAIN CONTEXT: Industrial port facility with loading equipment.
```
WHY BAD: Could be any port in any country. NB2 will generate generic stock-photo environment.

**GOOD — specific from research:**
```
DOMAIN CONTEXT: Pelabuhan Pelindo 1 Cabang Dumai, Riau. Gate booth with KPLP officer in dark blue Pelindo uniform. ANPR camera system (Hikvision) auto-reads plate "BM" prefix (Riau plates). Weighbridge: Mettler Toledo 80-ton capacity. Cangkang kelapa sawit = dark brown broken shell fragments 2-5cm, NOT whole palm fruits.
```
WHY GOOD: Named brands, local plate prefix, specific equipment, visual description of commodity.
```

4. Read Section 7D (Costume Tracking Table, around line 628-643). After the 5 rules, add:

```markdown
#### Few-Shot: Costume Consistency

**BAD — paraphrased costume:**
Scene 15 prompt: "QC Inspector wearing a high-vis vest and safety helmet"
Scene 17 prompt: "QC Inspector in white lab coat with safety equipment"
WHY BAD: Same character, different costume text. NB2 generates completely different outfits.

**GOOD — verbatim from tracking table:**
cast-profile.md says: "high-visibility neon yellow/green safety vest with reflective strips over grey work shirt, safety helmet, work boots"
Scene 15 prompt: "QC Inspector (high-visibility neon yellow/green safety vest with reflective strips over grey work shirt, safety helmet, work boots)"
Scene 17 prompt: "QC Inspector (high-visibility neon yellow/green safety vest with reflective strips over grey work shirt, safety helmet, work boots)"
WHY GOOD: Identical text string in both scenes — copy-pasted from tracking table, zero variation.
```

**Verification:**
- [ ] 4 few-shot examples added (dependency chain, prop scale, domain context, costume)
- [ ] Each example has BAD + WHY BAD + GOOD + WHY GOOD format
- [ ] BAD examples are realistic (based on actual issues from Cangkang project)
- [ ] GOOD examples show the exact fix, not just theory

---

## Phase F: Few-Shot Example — 03-workflow-pipeline.md

**Files:**
- Modify: `reference/image-video-gen/03-workflow-pipeline.md`

**Steps:**

1. Read the First+Last Frame Checklist (around line 51-59, after the camera constraint items added earlier). Add:

```markdown
#### Few-Shot: Camera Angle Constraint

**BAD — drastic camera jump (will break VEO interpolation):**
```
START: Camera: 85mm f/1.8, eye-level, close-up of officer's face at desk
END:   Camera: 24mm f/8, overhead bird's-eye, wide shot of entire port facility
```
WHY BAD: CU→WS = 3-step jump. Eye-level→overhead = 90°+ angle change. VEO will produce distorted faces, warped environment, ghosting artifacts.

**GOOD — smooth transition (VEO interpolates cleanly):**
```
START: Camera: 50mm f/2.8, eye-level, MCU of officer sitting at desk with monitor
END:   Camera: 50mm f/2.8, eye-level, MS of officer standing up, desk and monitor visible
```
WHY GOOD: MCU→MS = 1 step. Same lens. Same angle. Subject moves (stands up) but camera stays grounded. VEO smoothly interpolates the motion.

**ALSO GOOD — slight angle shift:**
```
START: Camera: 35mm f/4, eye-level, MS of two men at truck rear
END:   Camera: 35mm f/4, slight low angle (10°), MS of same two men, one holds shells
```
WHY GOOD: Same shot size. Only 10° angle change. Same lens. VEO handles this smoothly.
```

**Verification:**
- [ ] Camera constraint few-shot added with BAD + GOOD + ALSO GOOD examples
- [ ] BAD example shows specific VEO artifact consequences
- [ ] GOOD examples show realistic scene transitions

---

## Phase G: Update CLAUDE.md + plugin.json + hooks

**Files:**
- Modify: `CLAUDE.md`
- Modify: `.claude-plugin/plugin.json`
- Modify: `hooks/session-start.sh`

**Steps:**

1. Read CLAUDE.md Architecture section (around line 17-30). Add `prompt-reviewer-agent.md` to the table:
```
| `agents/prompt-reviewer-agent.md` | Independent validator — reviews NB2/VEO prompt batches for quality |
```

2. Read CLAUDE.md Production Pipeline section (around line 74-142). Update Phase 4B and Phase 5 descriptions to mention batch execution:
```
Phase 4B: SCENE KEYFRAMES (NB2)   → Output: image-prompts.md
  ├─ **BATCH BY ACT (max 5 scenes/batch)**
  ├─ Per-batch: generate → validate (prompt-reviewer agent) → approve
  ...

Phase 5: VIDEO PROMPTS (VEO)   → Output: video-prompts.md
  ├─ **BATCH BY ACT (max 5 scenes/batch)**
  ├─ Per-batch: generate → validate (prompt-reviewer agent) → approve
  ...
```

3. Add new section to CLAUDE.md after "Key Technical Rules" (around line 198):
```markdown
### Smart Context Loading

Each phase loads ONLY the reference files it needs — NOT all 23. This prevents context window overflow.

| Phase | Files Loaded | Max |
|-------|-------------|-----|
| Phase 1 | global-promo-config, creator-profile-system, F1, F8 | 4 |
| Phase 2 | global-promo-config, project-instruction, F2-F11 (excl F4 unless EV) | 10-11 |
| Phase 3 | global-promo-config, script-to-scene-bridge, 03-workflow | 3 |
| Phase 3.5 | global-promo-config, creator-profile-system | 2 |
| Phase 4A | global-promo-config, 01-nb2, script-to-scene-bridge (7B only) | 3 |
| Phase 4B | global-promo-config, 01-nb2, script-to-scene-bridge, 04-cinematography | 4 per batch |
| Phase 5 | global-promo-config, 02-veo, 03-workflow, 04-cinematography | 4 per batch |

Phase 4B and 5 also load per-batch filtered data from output files (cast entries + scene entries for current batch only).
```

4. Add new section about Prompt Reviewer Agent:
```markdown
### Prompt Reviewer Agent (Independent Validator)

After each batch in Phase 4B/5, a separate `prompt-reviewer` agent validates the output:
- **Fresh context** — no generation instructions, no storytelling files
- **Reads only:** batch prompts + cast-profile.md + scene-plan.md (ground truth)
- **Checks:** dependency chain, costume consistency, prop scale, camera angle, aspect ratio, 9-point realism, upload table completeness
- **Returns:** PASS/FAIL with per-prompt line-level feedback
- **On FAIL:** generator re-generates only failing prompts (max 2 retries)

This eliminates self-check bias — the validator has never seen the generation rules, so it cannot "explain away" violations.
```

5. Read `.claude-plugin/plugin.json` and add the prompt-reviewer agent.

6. Read `hooks/session-start.sh` and update to announce both agents.

**Verification:**
- [ ] CLAUDE.md has prompt-reviewer-agent in Architecture table
- [ ] CLAUDE.md has Smart Context Loading section with per-phase table
- [ ] CLAUDE.md Phase 4B/5 descriptions mention batch execution
- [ ] plugin.json lists prompt-reviewer-agent
- [ ] session-start.sh announces prompt-reviewer agent
- [ ] Version bumped in CLAUDE.md and plugin.json

---

## Execution Order

Phases A-G can be partially parallelized:

```
Phase A (Smart Context Loading)  ──┐
Phase E (Few-Shot: bridge.md)    ──┤── can run in parallel (different files)
Phase F (Few-Shot: workflow.md)  ──┘

Phase B (Batch: Phase 4B)  ──┐
Phase C (Batch: Phase 5)   ──┘── sequential (Phase C depends on B pattern)

Phase D (Prompt Reviewer Agent) ── independent

Phase G (CLAUDE.md + metadata) ── LAST (depends on all above)
```

**Recommended:** Run A + E + F in parallel, then B + C sequentially, then D, then G.
