> **For Claude:** REQUIRED SKILL: Use gaspol-execute to implement this plan.
> **CRITICAL:** This plan restructures a markdown-only Claude Code plugin. No code compilation,
> no tests. Verification is done via file existence checks and cross-reference validation.
> Each phase produces verifiable output. NEVER skip the verification step.

## Goal

Restructure the `ai-video-promo-engine` plugin from `promo-*` naming to `video-*` naming, split the monolithic `promo-engine` SKILL.md (~1371 lines) into 4 focused skills + 1 orchestrator, rewrite the validator as a unified multi-target skill, add an Image Review step to `video-gen`, and update all cross-references. This makes skills discoverable via `/video-` autocomplete and reduces context window usage per skill invocation.

## Architecture Context

From CLAUDE.md:
- Plugin root: `.claude-plugin/plugin.json` (version, metadata)
- Skills: `skills/{name}/SKILL.md` (3 current → 7 new)
- Agents: `agents/{name}.md` (2 agents, rename both)
- Hooks: `hooks/session-start.sh` (announces available skills/agents)
- References: `reference/` (23 docs — NOT changed, only cross-refs to them change)
- The `promo-engine` SKILL.md contains all 6 phases, 47 hard rules, 6 quality gates

## Tech Stack

Markdown files only. No compilation. Verification via `ls`, `grep`, file reads.

## Data Integration Map

| Feature | Data Source | Exists? | Action |
|---------|-----------|---------|--------|
| Phase 1 content | `skills/promo-engine/SKILL.md` lines 1-599 | Yes | Extract → `video-brainstorm/SKILL.md` |
| Phase 2-3.5 content | `skills/promo-engine/SKILL.md` lines 603-963 | Yes | Extract → `video-script/SKILL.md` |
| Phase 4A-4B content | `skills/promo-engine/SKILL.md` lines 967-1176 | Yes | Extract → `video-image/SKILL.md` |
| Phase 5 content | `skills/promo-engine/SKILL.md` lines 1180-1280 | Yes | Extract → `video-gen/SKILL.md` + add Image Review step |
| Hard Rules 1-47 | `skills/promo-engine/SKILL.md` lines 86-134 | Yes | Distribute relevant subset to each skill |
| Quality Gates | `skills/promo-engine/SKILL.md` lines 1289-1371 | Yes | Distribute relevant subset to each skill |
| Reference tables | `skills/promo-engine/SKILL.md` lines 29-83 | Yes | Copy relevant subset to each skill |
| Orchestrator | N/A | No | Create new `video-full/SKILL.md` |
| Unified validator | `skills/promo-validate/SKILL.md` | Yes | Rewrite with 5 target flags |
| Image Review step | N/A | No | Create new Step 0 in `video-gen/SKILL.md` |
| Script validator logic | N/A | No | Create new `--script` checks in `video-validate` |
| Image output validator | N/A | No | Create new `--image` checks in `video-validate` |
| Video output validator | N/A | No | Create new `--video` checks in `video-validate` |
| Agent promo-engine | `agents/promo-engine-agent.md` | Yes | Rename + update internal refs |
| Agent prompt-reviewer | `agents/prompt-reviewer-agent.md` | Yes | Rename + update internal refs |

---

## Phase A: Create Directory Structure + Rename Existing (Est: 3 min)

**Files:**
- Create: `skills/video-brainstorm/` (dir)
- Create: `skills/video-script/` (dir)
- Create: `skills/video-image/` (dir)
- Create: `skills/video-gen/` (dir)
- Create: `skills/video-full/` (dir)
- Rename: `skills/promo-validate/` → `skills/video-validate/`
- Rename: `skills/promo-add-platform/` → `skills/video-add-platform/`
- Rename: `agents/promo-engine-agent.md` → `agents/video-engine-agent.md`
- Rename: `agents/prompt-reviewer-agent.md` → `agents/video-prompt-reviewer.md`

**Steps:**
1. Create 5 new skill directories under `skills/`
2. `git mv skills/promo-validate skills/video-validate`
3. `git mv skills/promo-add-platform skills/video-add-platform`
4. `git mv agents/promo-engine-agent.md agents/video-engine-agent.md`
5. `git mv agents/prompt-reviewer-agent.md agents/video-prompt-reviewer.md`

**Verification:**
- [ ] `ls skills/` shows: video-brainstorm, video-script, video-image, video-gen, video-full, video-validate, video-add-platform, promo-engine (still exists, deleted later)
- [ ] `ls agents/` shows: video-engine-agent.md, video-prompt-reviewer.md
- [ ] No `promo-validate/`, `promo-add-platform/` directories remain
- [ ] No `promo-engine-agent.md`, `prompt-reviewer-agent.md` files remain

---

## Phase B: Create video-brainstorm/SKILL.md (Est: 5 min)

**Files:**
- Create: `skills/video-brainstorm/SKILL.md`
- Source: `skills/promo-engine/SKILL.md` (lines 1-599 + relevant hard rules + reference tables)

**Steps:**
1. Read `skills/promo-engine/SKILL.md` lines 1-599 (Phase 1 complete)
2. Write `skills/video-brainstorm/SKILL.md` with:
   - **Frontmatter:** name=`video-brainstorm`, description covers Phase 1 (brainstorm, cast, product, location, domain research), triggers on: video brainstorm, cast setup, karakter video, brainstorm video, pemeran, mulai video baru, start video, new video project
   - **Overview:** Phase 1 only — brainstorm to strategic-brief.md + cast-profile.md
   - **Reference Files:** Phase 1 table only (global-promo-config, creator-profile-system, F1, F8)
   - **Hard Rules:** Extract ONLY rules relevant to Phase 1: #8 (product not hero), #9 (first 3s), #10 (forbidden words), #13 (human consequence), #14 (AskUserQuestion), #15 (max 5 cast), #17 (cast ref by role), #18 (narration language), #19 (tone consistency), #20 (cultural accuracy), #40 (location context first), #41 (domain deep research)
   - **Workflow:** Steps 1.0 through 1.8 verbatim from source
   - **Quality Gate:** None for Phase 1 (approval gate is built into Step 1.8)
   - **Output:** strategic-brief.md, cast-profile.md
   - **Next Step:** "Run `/video-script` to continue to script generation."
3. Verify file structure is valid markdown with correct frontmatter

**Verification:**
- [ ] `skills/video-brainstorm/SKILL.md` exists and has valid `---` frontmatter
- [ ] Contains all Steps 1.0 through 1.8
- [ ] Contains Step 1.2c (Location) and Step 1.2d (Domain Deep Research)
- [ ] Reference Files table has exactly 4 entries (global-promo-config, creator-profile-system, F1, F8)
- [ ] Hard Rules are Phase 1-relevant only (no NB2/VEO rules)
- [ ] Contains "Next Step" pointing to `/video-script`
- [ ] No references to `promo-engine` or `promo-*` skill names

---

## Phase C: Create video-script/SKILL.md (Est: 5 min)

**Files:**
- Create: `skills/video-script/SKILL.md`
- Source: `skills/promo-engine/SKILL.md` (lines 603-963 + relevant hard rules + quality gates)

**Steps:**
1. Read `skills/promo-engine/SKILL.md` lines 603-963 (Phase 2 + Phase 3 + Phase 3.5)
2. Write `skills/video-script/SKILL.md` with:
   - **Frontmatter:** name=`video-script`, description covers Phase 2-3.5, triggers on: video script, script generation, scene breakdown, reference collection, buat script, scene plan, ref manifest
   - **Prerequisite:** "`strategic-brief.md` and `cast-profile.md` must exist (from `/video-brainstorm`)"
   - **Reference Files:** Phase 2 table (10-11 files) + Phase 3 table (3 files) + Phase 3.5 table (2 files)
   - **Hard Rules:** Extract Phase 2-3.5 relevant: #1 (never skip phase), #2 (approval gates), #8 (product not hero), #9 (first 3s), #10 (forbidden words), #11 (B-Roll VO), #13 (human consequence), #14 (AskUserQuestion), #16 (Phase 3.5 hard block), #18 (narration language), #19 (tone consistency), #20 (cultural accuracy), #25 (UI text localization)
   - **Workflow:** Phase 2 (Steps 2.1-2.3), Phase 3 (Steps 3.1-3.3), Phase 3.5 (Steps 3.5.1-3.5.4) — all verbatim from source
   - **Quality Gates:** Script Quality Gate + Reference Collection Quality Gate
   - **Output:** av-script.md, scene-plan.md, ref-manifest.md
   - **Next Step:** "Run `/video-image` to continue to image prompt generation."

**Verification:**
- [ ] `skills/video-script/SKILL.md` exists with valid frontmatter
- [ ] Contains Phase 2 context loading (10-11 files)
- [ ] Contains Phase 3 context loading (3 files)
- [ ] Contains Phase 3.5 context loading (2 files)
- [ ] Contains Step 3.5.2a (Cultural Location Research)
- [ ] Contains Step 3.5.2b (NB2 prompts for missing refs)
- [ ] Contains Script Quality Gate
- [ ] Contains Reference Collection Quality Gate
- [ ] Contains "Prerequisite" section referencing `/video-brainstorm` output
- [ ] Contains "Next Step" pointing to `/video-image`
- [ ] No references to `promo-engine` or `promo-*` skill names

---

## Phase D: Create video-image/SKILL.md (Est: 5 min)

**Files:**
- Create: `skills/video-image/SKILL.md`
- Source: `skills/promo-engine/SKILL.md` (lines 967-1176 + relevant hard rules + quality gates)

**Steps:**
1. Read `skills/promo-engine/SKILL.md` lines 967-1176 (Phase 4A + Phase 4B)
2. Write `skills/video-image/SKILL.md` with:
   - **Frontmatter:** name=`video-image`, description covers Phase 4A+4B, triggers on: video image, image prompt, NB2, nb2 prompt, generate image, asset library, scene keyframe, buat gambar, keyframe
   - **Prerequisite:** "`scene-plan.md`, `cast-profile.md`, `ref-manifest.md`, and `strategic-brief.md` must exist (from `/video-brainstorm` + `/video-script`). All reference images in ref/ must be validated."
   - **Reference Files:** Phase 4A table + Phase 4B table
   - **Hard Rules:** Extract Phase 4 relevant: #3 (VEO mode mutual exclusivity — for mode awareness), #5 (dialogue colon syntax — for reference), #7 (NB2 aspect ratio = VEO target), #14 (AskUserQuestion), #15 (max 5 cast), #17 (cast ref by role), #18 (narration language — UI text), #19 (tone consistency), #20 (cultural accuracy), #21 (asset-first scene-second), #22 (recurring element detection), #23 (auto-scan ref/), #24 (aspect ratio triple enforcement), #25 (UI text localization), #26 (product closeup mandatory), #27 (location photo mandatory), #28 (output filename per prompt), #29 (ref-to-prompt body binding), #30 (climate-aware costume), #31 (dynamic tier assignment), #37 (scene logic realism 9-point), #38 (character portrait-first), #39 (narrative arc consistency), #42 (sequential scene dependency), #43 (prop/object scale enforcement), #44 (camera angle constraint), #45 (NB2 identity lock filename only), #46 (inline-only reference pattern), #47 (multi-POV spatial context)
   - **Workflow:** Phase 4A (Steps 4A.0-4A.5) + Phase 4B (Steps 4B.1-4B.3) — all verbatim from source
   - **Quality Gates:** Asset Library Quality Gate + Scene Keyframe Quality Gate + Cross-Cutting Quality Gate
   - **Output:** nb2-reference-prompts.md, image-prompts.md
   - **Next Step:** "Run `/video-gen` to continue to video prompt generation."
   - **Agent spawn:** References `ai-video-promo-engine:video-prompt-reviewer` (new name) for Phase 4B batch validation

**Verification:**
- [ ] `skills/video-image/SKILL.md` exists with valid frontmatter
- [ ] Contains Phase 4A context loading (3 reference files + output data)
- [ ] Contains Phase 4B context loading (4 reference files + per-batch data)
- [ ] Contains Step 4A.0 (Auto-Scan ref/ + Domain Research Gate)
- [ ] Contains Step 4B.2 batch-by-ACT with prompt-reviewer agent spawn
- [ ] Agent spawn references `video-prompt-reviewer` (NOT `prompt-reviewer`)
- [ ] Contains Asset Library Quality Gate
- [ ] Contains Scene Keyframe Quality Gate
- [ ] Contains Cross-Cutting Quality Gate
- [ ] Contains "Prerequisite" section
- [ ] Contains "Next Step" pointing to `/video-gen`
- [ ] No references to `promo-engine` or `promo-*` skill names

---

## Phase E: Create video-gen/SKILL.md (Est: 5 min)

**Files:**
- Create: `skills/video-gen/SKILL.md`
- Source: `skills/promo-engine/SKILL.md` (lines 1180-1280 + relevant hard rules + quality gates) + **NEW** Image Review step

**Steps:**
1. Read `skills/promo-engine/SKILL.md` lines 1180-1280 (Phase 5)
2. Write `skills/video-gen/SKILL.md` with:
   - **Frontmatter:** name=`video-gen`, description covers Phase 5 + Image Review, triggers on: video gen, video generation, VEO, veo prompt, generate video, buat video prompt, video prompts
   - **Prerequisite:** "`scene-plan.md`, `cast-profile.md`, `image-prompts.md` must exist (from previous skills). All keyframe images should be generated."
   - **Reference Files:** Phase 5 table (4 files + per-batch data)
   - **Hard Rules:** Extract Phase 5 relevant: #1 (never skip phase), #2 (approval gates), #3 (VEO mode mutual exclusivity), #4 (audio NEVER optional), #5 (dialogue colon syntax), #6 (720p for extendable), #7 (NB2 aspect ratio = VEO target), #11 (B-Roll VO = Voice-over narrator), #12 (face >30% for lip sync), #14 (AskUserQuestion), #19 (tone consistency), #32 (VEO no real names), #33 (VEO no face ref filenames), #34 (VEO face-dominant = single I2V), #35 (VEO no em dash), #36 (VEO every B-Roll has VO), #37 (scene logic realism), #39 (narrative arc consistency), #42 (sequential scene dependency)
   - **NEW Step 0: IMAGE REVIEW (Per-Scene Collaborative)** — inserted BEFORE Step 5.1:
     ```
     Step 0: IMAGE REVIEW — Per-Scene Validation & Brainstorm

     FOR each scene in current batch:

       Step 0.1: VISUAL ANALYSIS
       1. READ start keyframe .png (multimodal — Claude sees the image)
       2. READ end keyframe .png if exists (Frame mode scenes)
       3. Load corresponding NB2 prompt text from image-prompts.md
       4. Load scene entry from scene-plan.md (VEO mode, duration, intent)
       5. Load narration/dialogue from av-script.md for this scene

       Step 0.2: AI OBSERVATION REPORT
       Present to user:
       "## Scene {NN} — Image Review

       **Saya lihat di keyframe image:**
       {AI describes what it actually SEES — characters, environment,
        lighting, props, expressions, composition, colors}

       **Dibanding NB2 prompt original:**
       {AI notes any differences — edits user made, or things
        that generated differently from prompt}

       **Scene intent (dari script):**
       {What this scene is supposed to convey — narration, beat, emotion}

       **VEO approach suggestion:**
       {AI suggests how to handle this in VEO — camera movement,
        what to emphasize, how to transition, audio approach}"

       Step 0.3: USER BRAINSTORM
       AskUserQuestion:
       "Scene {NN} — ada catatan atau arahan khusus untuk video prompt?"
       Options:
       A) Setuju dengan suggestion di atas, lanjut
       B) Ada arahan tambahan (saya jelaskan)
       C) Image ini perlu re-generate dulu, skip scene ini

       If B → user provides notes → AI incorporates into VEO prompt
       If C → skip scene, mark for re-generation later

       Step 0.4: SAVE SCENE CONTEXT
       Save per-scene context for VEO generation:
       - Actual image description (what AI sees, not original prompt)
       - User notes/direction (if any)
       - VEO approach (agreed upon with user)

     END FOR

     Proceed to Step 5.1 with per-scene context from Image Review
     - VEO prompts use ACTUAL IMAGE DESCRIPTIONS (not original NB2 text)
     - User notes injected as additional VEO direction
     ```
   - **Workflow:** Step 0 (Image Review) + Steps 5.1-5.4 from source, with modification in Step 5.1 to use revised descriptions for edited images
   - **Quality Gates:** Video Prompt Quality Gate + relevant Cross-Cutting checks
   - **Output:** video-prompts.md
   - **Agent spawn:** References `ai-video-promo-engine:video-prompt-reviewer` for Phase 5 batch validation

**Verification:**
- [ ] `skills/video-gen/SKILL.md` exists with valid frontmatter
- [ ] Contains **Step 0: IMAGE REVIEW** before Step 5.1 with per-scene collaborative flow
- [ ] Step 0 has 4 sub-steps: Visual Analysis, AI Observation Report, User Brainstorm, Save Scene Context
- [ ] Step 0 reads actual .png files (multimodal), compares with NB2 prompt, loads scene intent from script
- [ ] Step 0 includes per-scene AskUserQuestion with brainstorm options (agree/add notes/skip for re-gen)
- [ ] Contains Phase 5 context loading (4 reference files + per-batch data)
- [ ] Context loading includes `keyframes/*.png` for Image Review
- [ ] Contains Step 5.1 batch-by-ACT with prompt-reviewer agent spawn
- [ ] Step 5.1 references revised descriptions for edited images
- [ ] Agent spawn references `video-prompt-reviewer` (NOT `prompt-reviewer`)
- [ ] Contains Video Prompt Quality Gate
- [ ] Contains "Prerequisite" section
- [ ] No references to `promo-engine` or `promo-*` skill names

---

## Phase F: Create video-full/SKILL.md — Orchestrator (Est: 3 min)

**Files:**
- Create: `skills/video-full/SKILL.md`

**Steps:**
1. Write `skills/video-full/SKILL.md` as a thin orchestrator:
   - **Frontmatter:** name=`video-full`, description: "End-to-end AI video promotional production pipeline. Orchestrates video-brainstorm → video-script → video-image → video-gen in sequence with approval gates. Full 6-phase pipeline.", triggers on: video full, full pipeline, end to end, promo engine, video production, bikin video promosi, buat video lengkap, video marketing, iklan video, video agency, generate video complete
   - **Overview:** Orchestrator that runs all 4 skills in sequence. No logic of its own — delegates entirely.
   - **Reference Files:** "Read FIRST: `reference/global-promo-config.md`" — then delegates to sub-skills for phase-specific refs.
   - **Hard Rules:** Full list of all 47 rules (since it orchestrates everything). OR reference: "See individual skill files for phase-specific hard rules."
   - **Workflow:**
     ```
     Step 1: Run /video-brainstorm
       → Wait for Phase 1 approval
       → Verify: strategic-brief.md + cast-profile.md exist

     Step 2: Run /video-script
       → Wait for Phase 2, 3, 3.5 approval
       → Verify: av-script.md + scene-plan.md + ref-manifest.md exist

     Step 3: Run /video-image
       → Wait for Phase 4A, 4B approval
       → Verify: nb2-reference-prompts.md + image-prompts.md exist

     Step 4: Run /video-gen
       → Wait for Phase 5 approval (includes Image Review)
       → Verify: video-prompts.md exists

     Step 5: Production Summary
       → List all output files
       → Total scenes, clips, estimated duration
     ```
   - **Output:** All files from all 4 skills
   - **Flags:** `--full` (default) and `--quick` mode passthrough

**Verification:**
- [ ] `skills/video-full/SKILL.md` exists with valid frontmatter
- [ ] References all 4 sub-skills by correct name: video-brainstorm, video-script, video-image, video-gen
- [ ] Contains sequential workflow with verification between steps
- [ ] Contains `--full` and `--quick` flag documentation
- [ ] Trigger keywords include legacy terms (promo engine, video production) for discoverability

---

## Phase G: Rewrite video-validate/SKILL.md — Unified Validator (Est: 5 min)

**Files:**
- Modify: `skills/video-validate/SKILL.md`

**Steps:**
1. Read current `skills/video-validate/SKILL.md` (renamed from promo-validate)
2. Rewrite with unified multi-target structure:
   - **Frontmatter:** name=`video-validate`, description: "Unified validation for AI Video Promo Engine. Validates script output, image prompts + actual keyframe images, video prompts, and/or reference file consistency. Supports --script, --image, --video, --refs, --all flags.", triggers on: video validate, validate, check, consistency check, cek referensi, cek konsistensi, validate script, validate image, validate video
   - **Usage:** Document 5 flags with interactive picker fallback
   - **Flag `--refs`:** Preserve ALL 24 existing checks from current promo-validate, update file path references from `promo-*` to `video-*` (e.g., `skills/promo-engine/SKILL.md` → search across all `skills/video-*/SKILL.md`)
   - **Flag `--script`:** NEW checks for av-script.md output:
     - 7-beat arc completeness (all beats present)
     - No forbidden words in script text
     - Every feature has human consequence
     - Hook passes "So What?" test (first 3 seconds)
     - CTA is specific, time-bound, low-friction
     - Opening does NOT start with company name/logo
     - No jargon without translation
     - Narration language consistent with strategic-brief.md
     - Tone consistent with strategic-brief.md video_tone
   - **Flag `--image`:** NEW checks:
     - **Prompt text checks:** NB2 aspect ratio triple enforcement, identity lock filename-only (no ref/ prefix), inline-only reference pattern (no header blocks), ref-to-prompt body binding, output filename per prompt, DOMAIN CONTEXT populated, NARRATIVE CONTEXT block present, scale specs for props
     - **Actual image checks (multimodal):** Read each keyframe .png, verify aspect ratio matches prompt, character face consistency across scenes, lighting consistency in connected scenes, costume matches description, environment matches cultural research
   - **Flag `--video`:** NEW checks for video-prompts.md:
     - VEO mode correct per scene-plan.md
     - Face-dominant scenes use single I2V
     - All 3 audio layers per scene
     - Dialogue uses generic role (`Host says:`)
     - VO uses `Voice-over narrator, [tone]: text`
     - Every B-Roll has VO + POST-PROD VO backup
     - No em dash in audio text
     - No face ref filenames in VEO prompts
     - 720p for extendable clips
     - Extension prompts reference previous clip
   - **Flag `--all`:** Runs --refs + --script + --image + --video sequentially
   - **Interactive picker:** If no flag provided, AskUserQuestion with options for each flag
   - **Output format:** Same format as current (PASS/FAIL per check with file:line), extended with section headers per target
   - **Scope updates:** Replace `skills/promo-engine/SKILL.md` references with `skills/video-brainstorm/SKILL.md`, `skills/video-script/SKILL.md`, `skills/video-image/SKILL.md`, `skills/video-gen/SKILL.md` as appropriate

**Verification:**
- [ ] `skills/video-validate/SKILL.md` exists with valid frontmatter
- [ ] Contains 5 documented flags: --script, --image, --video, --refs, --all
- [ ] `--refs` section contains all 24 original checks (preserved)
- [ ] `--refs` checks reference `video-*` skill names (not `promo-*`)
- [ ] `--script` section contains at least 9 av-script.md checks
- [ ] `--image` section contains both prompt text checks AND actual image multimodal checks
- [ ] `--video` section contains at least 10 video-prompts.md checks
- [ ] Interactive picker uses AskUserQuestion when no flag provided
- [ ] No references to `promo-engine`, `promo-validate`, or `promo-add-platform`

---

## Phase H: Update video-add-platform/SKILL.md (Est: 2 min)

**Files:**
- Modify: `skills/video-add-platform/SKILL.md`

**Steps:**
1. Read `skills/video-add-platform/SKILL.md`
2. Update frontmatter: name=`video-add-platform`
3. Update Step 4 cross-reference list:
   - `skills/promo-engine/SKILL.md` → `skills/video-gen/SKILL.md` (Phase 5 reference table)
   - `agents/promo-engine-agent.md` → `agents/video-engine-agent.md`
4. Update Step 5: `/promo-validate` → `/video-validate --refs`

**Verification:**
- [ ] Frontmatter name is `video-add-platform`
- [ ] No references to `promo-engine`, `promo-validate`, or old agent names
- [ ] Step 4 references correct new skill and agent filenames
- [ ] Step 5 references `/video-validate`

---

## Phase I: Update Agents (Est: 3 min)

**Files:**
- Modify: `agents/video-engine-agent.md`
- Modify: `agents/video-prompt-reviewer.md`

**Steps:**
1. **video-engine-agent.md:**
   - Update title: "# Video Engine Agent — Subagent" (was "Promo Engine Agent")
   - Update WORKFLOW section line 120: `skills/promo-engine/SKILL.md` → reference individual skills:
     ```
     Follow the pipeline as defined across the skill files:
     - Phase 1: `skills/video-brainstorm/SKILL.md`
     - Phase 2-3.5: `skills/video-script/SKILL.md`
     - Phase 4: `skills/video-image/SKILL.md`
     - Phase 5: `skills/video-gen/SKILL.md`
     ```
   - No other content changes needed (capabilities, hard rules, reference files, audio strategy are all content-accurate)

2. **video-prompt-reviewer.md:**
   - Update title: "# Video Prompt Reviewer Agent" (was "Prompt Reviewer Agent")
   - Content is already self-contained (no references to skill names or agent names internally) — verify and confirm no changes needed

**Verification:**
- [ ] `agents/video-engine-agent.md` title starts with "# Video Engine Agent"
- [ ] `agents/video-engine-agent.md` WORKFLOW references 4 individual skill files (not `promo-engine/SKILL.md`)
- [ ] `agents/video-prompt-reviewer.md` title starts with "# Video Prompt Reviewer"
- [ ] No references to `promo-engine`, `promo-*` in either agent file
- [ ] Agent content (capabilities, hard rules, reference tables) is unchanged

---

## Phase J: Update Infrastructure Files (Est: 5 min)

**Files:**
- Modify: `.claude-plugin/plugin.json`
- Modify: `hooks/session-start.sh`

**Steps:**
1. **plugin.json:** Bump version from `1.8.0` to `2.0.0` (major version — breaking change in skill names)

2. **hooks/session-start.sh:** Rewrite to announce new skills and agents:
   ```bash
   #!/bin/bash
   echo "ai-video-promo-engine loaded. Skills available:"
   echo "  video-full        — end-to-end pipeline (brainstorm → script → images → video)"
   echo "  video-brainstorm  — Phase 1: brainstorm, cast, product, location, domain research"
   echo "  video-script      — Phase 2-3.5: script, scene breakdown, reference collection"
   echo "  video-image       — Phase 4: NB2 asset library + scene keyframes"
   echo "  video-gen         — Phase 5: VEO video prompts (with image review)"
   echo "  video-validate    — unified validator (--script / --image / --video / --refs / --all)"
   echo "  video-add-platform — scaffold new AI video platform support"
   echo ""
   echo "Agents available:"
   echo "  video-engine-agent    — subagent for batch/complex video production"
   echo "  video-prompt-reviewer — independent validator for NB2/VEO prompt batches"
   echo ""
   echo "REMINDER: Read reference/global-promo-config.md FIRST for any prompt generation."
   ```

**Verification:**
- [ ] `plugin.json` version is `2.0.0`
- [ ] `session-start.sh` lists all 7 skills with `video-*` names
- [ ] `session-start.sh` lists 2 agents with new names
- [ ] No references to `promo-*` in either file

---

## Phase K: Update CLAUDE.md (Est: 5 min)

**Files:**
- Modify: `CLAUDE.md`

**Steps:**
1. Update **Commands** table:
   - Replace 3 promo-* commands with 7 video-* commands
2. Update **Architecture** table:
   - Replace `skills/promo-engine/SKILL.md` with 5 new skill paths
   - Replace `skills/promo-validate/SKILL.md` with `skills/video-validate/SKILL.md`
   - Replace `skills/promo-add-platform/SKILL.md` with `skills/video-add-platform/SKILL.md`
   - Replace agent paths
   - Update purpose descriptions
3. Update **Production Pipeline** section:
   - Add note about individual skill entry points
   - Add `/video-full` as orchestrator
4. Update **Prompt Reviewer Agent** section:
   - Update agent name reference
5. Update **Conventions for Contributors** section:
   - Update "Adding a New Reference File" steps to reference new skill names
   - Update "Adding a New Video Platform" to reference `/video-add-platform`
6. Update **Debugging** table:
   - "Cross-file drift" entry: `/promo-validate` → `/video-validate`
7. Update **Version** to `2.0.0` and **Last Updated** to `2026-03-29`
8. Search entire file for remaining `promo-` references and replace

**Verification:**
- [ ] Commands table has 7 entries (video-brainstorm, video-script, video-image, video-gen, video-full, video-validate, video-add-platform)
- [ ] Architecture table references all new skill paths and agent paths
- [ ] `grep -c "promo-" CLAUDE.md` returns 0 (no remaining promo-* references, except possibly in the plugin name `ai-video-promo-engine` which stays)
- [ ] Version is `2.0.0`
- [ ] Last Updated is `2026-03-29`

---

## Phase L: Update README.md (Est: 3 min)

**Files:**
- Modify: `README.md`

**Steps:**
1. Update **Usage > Main Skill** section:
   - Replace `/promo-engine` with `/video-full` for end-to-end
   - Add individual skill commands: `/video-brainstorm`, `/video-script`, `/video-image`, `/video-gen`
2. Update **Usage > Utility Skills**:
   - Replace `/promo-validate` with `/video-validate`
   - Replace `/promo-add-platform` with `/video-add-platform`
   - Add flag documentation for `video-validate`
3. Update **Usage > Subagent**:
   - Replace `promo-engine-agent` with `video-engine-agent`
   - Add `video-prompt-reviewer` mention
4. Update **Project Structure** tree:
   - Replace promo-* skill paths with video-* paths
   - Replace agent paths
   - Add prompt-reviewer-agent to tree
5. Update **Contributing** section:
   - `/promo-validate` → `/video-validate`
   - `/promo-add-platform` → `/video-add-platform`
6. Search for remaining `promo-` references

**Verification:**
- [ ] Usage section shows `/video-full` as main command
- [ ] All 7 video-* skills documented
- [ ] Project Structure tree matches new directory layout
- [ ] `grep -c "/promo-" README.md` returns 0
- [ ] Contributing section references new command names

---

## Phase M: Delete Old promo-engine Skill (Est: 1 min)

**Files:**
- Delete: `skills/promo-engine/SKILL.md`
- Delete: `skills/promo-engine/` (directory)

**Steps:**
1. Verify all 4 new skills exist and are complete (video-brainstorm, video-script, video-image, video-gen)
2. `git rm skills/promo-engine/SKILL.md`
3. Remove empty directory if needed

**Verification:**
- [ ] `skills/promo-engine/` does not exist
- [ ] `ls skills/` shows exactly: video-add-platform, video-brainstorm, video-full, video-gen, video-image, video-script, video-validate
- [ ] Total: 7 skill directories

---

## Phase N: Final Cross-Reference Validation (Est: 3 min)

**Steps:**
1. `grep -r "promo-engine" skills/ agents/ hooks/ .claude-plugin/ CLAUDE.md README.md` → should return 0 matches (except plugin name `ai-video-promo-engine`)
2. `grep -r "promo-validate" skills/ agents/ hooks/ .claude-plugin/ CLAUDE.md README.md` → should return 0
3. `grep -r "promo-add-platform" skills/ agents/ hooks/ .claude-plugin/ CLAUDE.md README.md` → should return 0
4. `grep -r "prompt-reviewer-agent" skills/ agents/ hooks/ .claude-plugin/ CLAUDE.md README.md` → should return 0
5. `grep -r "promo-engine-agent" skills/ agents/ hooks/ .claude-plugin/ CLAUDE.md README.md` → should return 0
6. Verify all skill SKILL.md files have valid frontmatter (starts with `---`)
7. Verify agent spawn references in video-image and video-gen use `video-prompt-reviewer` name
8. Count total files: 7 skill SKILL.md + 2 agent .md + 1 plugin.json + 1 hooks.json + 1 session-start.sh + 1 CLAUDE.md + 1 README.md = 14 operational files

**Verification:**
- [ ] Zero `promo-engine` matches (except plugin name)
- [ ] Zero `promo-validate` matches
- [ ] Zero `promo-add-platform` matches
- [ ] Zero `prompt-reviewer-agent` matches (old name)
- [ ] Zero `promo-engine-agent` matches (old name)
- [ ] All 7 SKILL.md files have valid `---` frontmatter
- [ ] Agent spawn in video-image and video-gen correctly references `ai-video-promo-engine:video-prompt-reviewer`

---

## Execution Notes

- **Parallelizable phases:** B, C, D, E can run in parallel (4 independent skill files). F depends on none of them.
- **Sequential dependencies:** A must finish first (directories/renames). G, H, I, J, K, L depend on knowing final file names from A. M depends on B-F completing. N depends on everything.
- **No compilation or tests** — this is a markdown-only plugin. Verification is file existence + grep + content checks.
- **Risk:** The split distributes hard rules across skills. A rule might be accidentally omitted from a skill that needs it. Phase N catches this via cross-reference grep, but the executor should also manually scan each skill's hard rules against the original 47 rules.
