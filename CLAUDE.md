# AI Video Promo Engine — Claude Project Instructions

## Project Overview

Claude Code plugin that generates complete promotional video production packages: from brainstorm to script to image prompts (NB2) to video prompts (VEO 3.1 / Seedance 2.0). 4 production skills + 1 orchestrator + 2 utility skills + 2 agents + 24 reference documents as RAG knowledge base.

**Core Value:** Anyone — video agencies, freelancers, brand owners — can produce professional 2-3 minute promotional videos by following the generated production plan.

## Commands

| Command | Description |
|---------|-------------|
| `/video-full` | End-to-end pipeline orchestrator (brainstorm → script → images → video) |
| `/video-brainstorm` | Phase 1: brainstorm, cast, product, location, domain research |
| `/video-script` | Phase 2-3.5: script generation, scene breakdown, reference collection |
| `/video-image` | Phase 4: NB2 asset library + scene keyframes |
| `/video-gen` | Phase 5: image review + VEO video prompts |
| `/video-validate` | Unified validator: `--script` / `--image` / `--video` / `--refs` / `--all` |
| `/video-add-platform` | Scaffold new AI video platform support |

## Architecture

| Path | Purpose |
|------|---------|
| `.claude-plugin/plugin.json` | Plugin metadata (name, version, author) |
| `hooks/hooks.json` | SessionStart hook definition |
| `hooks/session-start.sh` | Session start script — announces available skills |
| `skills/video-brainstorm/SKILL.md` | Phase 1 — brainstorm, cast, product, location, domain research |
| `skills/video-script/SKILL.md` | Phase 2-3.5 — script, scene breakdown, reference collection |
| `skills/video-image/SKILL.md` | Phase 4 — NB2 asset library + scene keyframes |
| `skills/video-gen/SKILL.md` | Phase 5 — image review + VEO video prompts |
| `skills/video-full/SKILL.md` | Orchestrator — runs all 4 production skills in sequence |
| `skills/video-validate/SKILL.md` | Unified validator (--script / --image / --video / --refs / --all) |
| `skills/video-add-platform/SKILL.md` | Scaffold new video platform support |
| `agents/video-engine-agent.md` | Subagent for batch/complex video production (6-phase pipeline) |
| `agents/video-prompt-reviewer.md` | Independent validator — reviews NB2/VEO prompt batches for quality |
| `reference/` | 24 reference docs read on-demand by skill/agent |
| `README.md` | Repo README |
| `LICENSE` | MIT license |

### Reference Files

#### Storytelling & Script Generation (12 files)

| File | When Used |
|------|-----------|
| `storytelling_script_gen/project-instruction.md` | ALWAYS for script generation — master operating system, 2-phase state machine, 8 commandments, 7-beat arc |
| `storytelling_script_gen/F1_Audience_Psychology_Matrix.md` | Target market selection — C-Level, VP/Director, Manager, IC, End Consumer psychographics |
| `storytelling_script_gen/F2_Narrative_Arc_and_Video_Typology.md` | Narrative arc selection — 7-beat universal arc, 12 video types, duration mapping |
| `storytelling_script_gen/F3_Cinematic_AV_Production_Rules.md` | Lighting grammar, audio design, camera directions for script |
| `storytelling_script_gen/F4_EV_Persona_Matrix.md` | CONDITIONAL — only when product is EV-related |
| `storytelling_script_gen/F5_Hook_Vault.md` | Hook selection — 100 hooks in 5 categories |
| `storytelling_script_gen/F6_CTA_Vault.md` | CTA frameworks per awareness level |
| `storytelling_script_gen/F7_Foreshadow_and_Peak_Engineering.md` | Psychological techniques for tension and peak moments |
| `storytelling_script_gen/F8_Awareness_Level_Routing.md` | 5 awareness levels — routes to correct narrative strategy |
| `storytelling_script_gen/F9_Platform_Adaptation_Matrix.md` | Platform specs — YouTube, LinkedIn, IG, TikTok, Twitter |
| `storytelling_script_gen/F10_Modular_Asset_and_AB_Testing.md` | Modular asset creation and A/B testing strategy |
| `storytelling_script_gen/F11_Pattern_Interrupt_and_Retention.md` | Pattern interrupt techniques and retention optimization |

#### Image & Video Production (9 files)

| File | When Used |
|------|-----------|
| `image-video-gen/00-index.md` | ALWAYS for image/video — production stack overview, critical constraints |
| `image-video-gen/01-nb2-image-generation.md` | NB2 image prompts — parameters, resolution, identity lock, material shaders, text rendering |
| `image-video-gen/02-veo-production-guide.md` | VEO 3.1 video prompts — specs, camera movement, I2V motion, lip sync, extensions, audio |
| `image-video-gen/03-workflow-pipeline.md` | NB2 → VEO pipeline — decision tree, handoff rules, extension chain, "Last Frame Secret" |
| `image-video-gen/04-cinematography-lookup.md` | Emotion → complete setup mapping (lighting, lens, film stock, atmosphere, camera motion) |
| `image-video-gen/05-creator-and-holidays.md` | Ali Sadikin as cast slot, cast-c{N} naming, holiday palettes, cultural context |
| `image-video-gen/06-directing-and-performance.md` | Film directing grammar — 180° rule, gaze direction, blocking, vocal performance, continuity supervision |
| `image-video-gen/07-seedance-production-guide.md` | Seedance 2.0 video prompts — native 2K, @ reference system, dual-branch audio, modes, materials |
| `image-video-gen/project-instruction.md` | Image/video project instructions — critical rules, example workflows |

#### Global Config & Bridge (3 files)

| File | When Used |
|------|-----------|
| `global-promo-config.md` | ALWAYS (read FIRST) — single source of truth for all configurable values |
| `creator-profile-system.md` | Phase 1 (Cast Builder) — multi-character cast profiles, institution detection, generic + Ali Sadikin preset |
| `script-to-scene-bridge.md` | Phase 3 (Scene Breakdown) — script → scene list → VEO mode → image/video prompts |

## Key Concepts

### Production Pipeline (6-Phase Full Pipeline)

The plugin operates as a single end-to-end pipeline with mandatory approval gates between phases:

```
Phase 1: BRAINSTORM          → Output: strategic-brief.md + cast-profile.md
  ├─ Language selection (Bahasa Indonesia / English / Bilingual)
  ├─ Cast builder (1-5 characters, Utama/Pendamping roles)
  ├─ Institution detection + costume confirmation
  ├─ Product discovery + tech doc upload
  ├─ **Location & setting context (city, country, setting type)**
  ├─ **Domain Deep Research (6 location-aware WebSearch queries)**
  ├─ Target market, awareness level, platform selection
  ├─ Emotional core discovery
  ├─ Storyline input (user freeform / brainstorm / reference) + 7-beat arc mapping
  ├─ Tone/mood selection (Humorous / Serious / Professional / Inspirational / Casual / Edgy)
  └─ [USER APPROVAL GATE]

Phase 2: SCRIPT               → Output: av-script.md
  ├─ Generate 2-3 min video script
  ├─ A/V table with beat labels + timing
  ├─ Narration/dialogue per scene
  ├─ Audio direction (SFX, music, ambient)
  └─ [USER APPROVAL GATE]

Phase 3: SCENE BREAKDOWN       → Output: scene-plan.md
  ├─ Script → Scene list (auto-calculated)
  ├─ VEO mode per scene (Frame / Ingredients / Extend)
  ├─ Duration allocation
  ├─ Extension strategy
  └─ [USER APPROVAL GATE]

Phase 3.5: REFERENCE COLLECTION  → Output: ref-manifest.md
  ├─ Auto-derive from scene-plan.md + cast-profile.md
  ├─ Present manifest checklist (5 categories)
  ├─ Cultural location web search (5 facts per location via WebSearch)
  ├─ Batch NB2 prompt generation for missing refs (6 categories)
  ├─ User generates/uploads to {project}/ref/
  ├─ Validate ALL refs exist
  └─ [HARD BLOCK — 100% required before Phase 4]

Phase 4A: ASSET LIBRARY (NB2)   → Output: nb2-reference-prompts.md
  ├─ Auto-scan ref/ folder (user photos = ground truth)
  ├─ Recurring element detection (2+ scenes → standalone asset)
  ├─ Dynamic tier assignment with dependency graph
  ├─ Tier-by-tier generation with validation gates
  ├─ Extended categories: cast, vehicles, objects, products, product closeups, environments, UI composites
  ├─ Product closeup + location photo enforcement
  ├─ Climate-aware costume check
  └─ [USER APPROVAL GATE]

Phase 4B: SCENE KEYFRAMES (NB2)  → Output: image-prompts.md
  ├─ **BATCH BY ACT (max 5 scenes/batch)**
  ├─ Per-batch: generate → validate (prompt-reviewer agent) → approve
  ├─ Start frame + End frame per scene (Frame mode)
  ├─ Ingredient images (Ingredients mode)
  ├─ EVERY visual element references Phase 4A asset (no text-only descriptions)
  ├─ Aspect ratio triple enforcement
  ├─ Output filename per prompt
  ├─ Ref-to-prompt body binding
  ├─ UI text localization
  └─ [USER APPROVAL GATE]

Phase 5: VIDEO PROMPTS (VEO)   → Output: video-prompts.md
  ├─ **BATCH BY ACT (max 5 scenes/batch)**
  ├─ Per-batch: generate → validate (prompt-reviewer agent) → approve
  ├─ Per-scene VEO 3.1 prompts
  ├─ Extension prompts (same-scene continuity)
  ├─ Audio specs (dialogue + SFX + ambient)
  ├─ Transition end instructions
  ├─ Post-production checklist
  └─ [FINAL OUTPUT]
```

### Output Modes

- **`--full`** (default): Full production plan with cast-profile.md, ref-manifest.md, scene breakdown, storyboard notes, NB2 prompts, VEO prompts, audio specs, extension strategy, post-production checklist
- **`--quick`**: Copy-paste ready prompts only (NB2 + VEO per scene, no production plan)

### Production Stack

- **Image Model**: Nano Banana 2 (NB2) — Gemini 3.1 Flash Image
- **Video Model (Primary)**: VEO 3.1 — 720p/1080p, 8s clips, 148s extension chain
- **Video Model (Alt)**: Seedance 2.0 — native 2K, 15s clips, @ reference system, dual-branch AV
- **Pipeline (VEO)**: NB2 image → VEO First+Last Frame / Ingredients → VEO Extend
- **Pipeline (Seedance)**: NB2 image → Seedance @Image refs + Omni mode → Seedance @Video extend

### Critical Audio Rules

- Audio is NEVER optional — unspecified = VEO guesses random sounds
- Presenter scenes: `Host says: text` (generic role, colon syntax) — NEVER real person names (safety filter). Lip sync ON, face >30% frame
- B-Roll scenes: `Voice-over narrator, [tone]: text` — NEVER bare `Voiceover:` (lip-syncs to visible character). Every B-Roll MUST have VO narration + `> POST-PROD VO:` backup
- NEVER use em dash `—` in dialogue/voiceover text — VEO audio engine mistranslates. Use `,` or `. `
- Always add: `no subtitles, no audience sounds, no text overlays`
- VEO prompts: NO face ref filenames (`cast-c{N}-face.png`) — use generic continuity language. Face refs are NB2-only.
- NB2 prompt body text: use filename only (e.g., `cast-c1-face.png`), NEVER add `ref/` folder prefix — NB2 matches by uploaded filename, not path. All filenames MUST be inline with the element they describe (no header blocks, no standalone lines, each filename MAX 1x per prompt).
- See `image-video-gen/02-veo-production-guide.md` for full audio specs, safety filter rules, and duration rules

### VEO 3.1 Mode Selection (Mutual Exclusivity + Safety Filter)

```
Need consistent CHARACTER across shots?
├── YES → "Ingredients to Video" (1-3 ref images)
│         Cannot combine with First+Last Frame
│
└── NO, need controlled TRANSITION between two states?
    ├── YES → Does scene have FACE >30% of frame?
    │         ├── YES → "Single I2V" (start frame only)
    │         │         Safety filter rejects 2 face images
    │         │
    │         └── NO → "First + Last Frame" (Keyframe Control)
    │                   Generate START (NB2) + END (NB2)
    │                   Only for faceless scenes (dashboards, products, environments)
    │
    └── NO, need to CONTINUE an existing clip?
        └── "Scene Extension" (Extend)
            Source must be VEO-generated, 720p only
            Uses final 1 second as context anchor
```

**CRITICAL: Ingredients ≠ First+Last Frame. They are MUTUALLY EXCLUSIVE. Pick ONE per generation.**
**SAFETY: First+Last Frame with 2 photorealistic face images → rejected as "prominent people." Use single I2V for face-dominant scenes.**

### Key Technical Rules

- **Resolution Rule:** Generate initial clip at **720p** if ANY extensions planned. 1080p = 8s only, CANNOT extend.
- **NB2 aspect ratio MUST match VEO target** — mismatch = edge hallucination.
- **NB2 Prompt Formula:** `Subject/Material + Lighting Architecture + Camera/Lens + Campaign Context`
- Scene count auto-calculated from script beats. Scene → VEO mode mapping in `script-to-scene-bridge.md`.
- VEO specs (resolution, duration, extensions, prompt limits) in `image-video-gen/02-veo-production-guide.md`.
- NB2 parameters (CFG, denoise, thinking mode, identity lock) in `image-video-gen/01-nb2-image-generation.md`.
- **NB2 Identity Lock Syntax:** `Maintain exact facial identity from reference image: filename.png` — use bare filename only (NO `ref/` or `keyframes/` prefix). NB2 matches uploaded files by filename; `ref/cast-c1-face.png` fails to match the uploaded `cast-c1-face.png`. Max 3 identity locks per scene.
- **Inline-Only Reference Pattern:** All NB2 reference image filenames MUST appear inline with the element they describe, NOT in header blocks. Each filename MAX 1x per prompt. Three categories: (1) identity lock inline with character: `[Name] (Maintain exact facial identity from reference image: cast-c1-face.png) in uniform...`, (2) object/env ref inline: `...the monitor — EXACTLY matching ui-anpr-screen.png: interface...`, (3) scene continuity inline: `...continuation from scene-{NN-1}-end.png — maintaining position...`. BANNED: header blocks (`Using reference image xxx.png for [purpose]`), standalone identity lock lines, duplicate filenames.
- **Required Reference Images Table Placement:** Table MUST appear directly BELOW each image/prompt heading, BEFORE the prompt body text — NOT above the heading, NOT after the prompt body. Use bare filenames only (NO `ref/` prefix). Add note: "Upload all files to `{project}/ref/` folder."
- **No Em Dash in VEO Audio Text:** NEVER use `—` (em dash) in `says:` or `Voice-over narrator:` text — VEO audio engine mistranslates it. Replace with `,` or `. ` in all dialogue/voiceover template placeholders.
- Cinematography defaults per content type in `image-video-gen/04-cinematography-lookup.md`.

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
| Phase 5 (VEO) | global-promo-config, 02-veo, 03-workflow, 04-cinematography | 4 per batch |
| Phase 5 (Seedance) | global-promo-config, 07-seedance, 03-workflow, 04-cinematography | 4 per batch |

Phase 4B and 5 also load per-batch filtered data from output files (cast entries + scene entries for current batch only).

### Prompt Reviewer Agent (Independent Validator)

After each batch in Phase 4B/5, a separate `prompt-reviewer` agent validates the output:
- **Fresh context** — no generation instructions, no storytelling files
- **Reads only:** batch prompts + cast-profile.md + scene-plan.md (ground truth)
- **Checks:** dependency chain, costume consistency, prop scale, camera angle, aspect ratio, 9-point realism, upload table completeness
- **Returns:** PASS/FAIL with per-prompt line-level feedback
- **On FAIL:** generator re-generates only failing prompts (max 2 retries)

This eliminates self-check bias — the validator has never seen the generation rules, so it cannot "explain away" violations.

### Location & Domain Deep Research (MANDATORY — Steps 1.2c + 1.2d)

AI is blind about specific product domains, AND domains are **location-specific**. RS Indonesia ≠ RS USA ≠ RS Japan. Factory di Cikarang ≠ Factory di Shenzhen. Same domain, completely different visuals — architecture, equipment brands, uniforms, signage, safety standards.

**Step 1.2c: Location Context** — Confirm location/setting BEFORE domain research:
- City/region, country, setting type (factory/hospital/port/office), indoor/outdoor

**Step 1.2d: Domain Deep Research** — 6 location-qualified WebSearch queries:

| # | Query | Purpose |
|---|-------|---------|
| 1 | `{domain} in {country} production process workflow` | Local process flow |
| 2 | `{domain} {country} equipment machines brands commonly used` | Local equipment brands |
| 3 | `{domain} {country} worker roles uniforms PPE requirements` | Local workforce, dress norms |
| 4 | `{domain} {location} facility layout photos` | Local architecture, interior |
| 5 | `{product_name} product interface dashboard features` | Product appearance |
| 6 | `{domain} {country} regulations standards signage` | Local safety signage, certifications |

Output saved to `strategic-brief.md` > Domain Knowledge section with **Local Differentiators** table (generic AI default vs actual local reality). Every NB2/VEO prompt includes `DOMAIN CONTEXT:` line with location-specific details.

**HARD RULES:**
- Location MUST be confirmed before domain research begins
- Domain research MUST complete before Phase 2 (Script)
- Domain research + cultural research (Step 3.5.2a) are COMPLEMENTARY

See `global-promo-config.md` Section 24.

### Scene Logic Realism (9-Point)

Every NB2/VEO prompt must pass 9 realism checks to prevent "stock photo generic" output:

1. **Environment Accuracy** — location matches cultural research, architecture/vegetation/signage match real location
2. **Human Behavior Realism** — workers work, supervisors supervise, no "standing and smiling at camera" in action scenes
3. **Data/Display Consistency** — dashboard numbers, ANPR readings, metrics consistent across all scenes
4. **Uniform & Rank Accuracy** — institutional uniforms match rank/role (supervisor ≠ operator uniform, correct epaulettes/stripes)
5. **Explicit Negatives** — prompt states what should NOT appear ("no outdoor elements" for indoor, "no sunlight" for night)
6. **Reference Photo Enforcement** — every element with ref/ image uses it, user photos = ground truth
7. **Timeline & Shift Consistency** — time-of-day/lighting matches across connected scenes, PPE matches shift

Full checklist and per-prompt algorithm in `script-to-scene-bridge.md` Section 7B.

### Character Portrait-First Rule

**Any character in 2+ scenes MUST have standalone face portrait generated FIRST in Phase 4A.** Text descriptions alone = different faces every time. Applies to cast members AND recurring named extras.

- Cast Pemeran Utama: face → body → costume → scene (mandatory chain)
- Cast Pemeran Pendamping: face → scene (minimum)
- Recurring extras (2+ scenes): face portrait in Phase 4A FIRST
- Scene keyframes MUST reference the portrait inline — NB2 injects `cast-c{N}-face.png` inline with character description (e.g., `[Name] (Maintain exact facial identity from reference image: cast-c{N}-face.png) — description...`), filename only (NO `ref/` prefix), VEO uses generic continuity

See `global-promo-config.md` Section 18.

### Narrative Arc Consistency

Connected scenes MUST explicitly reference each other. Every NB2/VEO prompt includes a `NARRATIVE CONTEXT:` block:

```
NARRATIVE CONTEXT:
  Previous: Scene {N-1} — {what happened}.
  This scene: {what happens now and WHY}.
  Next: Scene {N+1} — {what this scene sets up}.
  Visual breadcrumb: {shared element connecting adjacent scenes}.
  Emotional arc: {start emotion} → {end emotion}.
```

Key rules: name the connection, add visual breadcrumbs (shared props/screens/landmarks), state cause-effect chains, share environment references, maintain character state continuity, pin data labels in UI scenes. See `script-to-scene-bridge.md` Section 7C.

### Cast System (Multi-Character)

Supports 1-5 characters per video.

- **Pemeran Utama** (main, 1-3): FULL identity lock — face + body + costume ref MANDATORY
- **Pemeran Pendamping** (supporting, 0-2): PARTIAL identity lock — face ref MANDATORY, body/costume OPTIONAL
- **Ali Sadikin preset**: Pre-configured profile that fills 1 Pemeran Utama cast slot
- **Institution-aware costume**: Auto-detects institutional brand (KAI, Pelindo, BRI, etc.) and requires uniform reference images
- **Reference images**: `{project-folder}/ref/` — naming: `cast-c{N}-face.png`, `cast-c{N}-body.png`, `cast-c{N}-costume.png`
- See `creator-profile-system.md` for full cast builder details and institution keyword list

### Language Selection

Pipeline starts with language choice (Phase 1 Step 1.0):

| Option | Narration/Dialogue | NB2/VEO Prompts | Strategic Brief |
|--------|-------------------|-----------------|-----------------|
| Bahasa Indonesia | Indonesian | English (fixed) | Indonesian |
| English | English | English (fixed) | English |
| Bilingual | Indonesian + English tech terms | English (fixed) | Indonesian |

**Key rule:** NB2/VEO prompt structure ALWAYS stays English (technical requirement for AI models). Only narration text and `says:` dialogue follow user's language choice.

### Tone/Mood System

Selected in Phase 1 Step 1.7b. 6 tones (Humorous / Serious / Professional / Inspirational / Casual / Edgy) that affect script style, lighting, camera, music, and expression across ALL subsequent phases. Full impact matrix in `global-promo-config.md` Section 13.

### User Storyline Input

Phase 1 Step 1.7 offers 3 modes: **freeform** (user pastes storyline, AI maps to 7-beat arc), **brainstorm** (AI guides through pain points/USP/CTA), or **reference video** (user describes a video, AI extracts and adapts structure).

### Phase 3.5: Reference Image Validation Gate

Mandatory gate between Scene Breakdown (Phase 3) and Image Prompts (Phase 4).

**HARD BLOCK:** Cannot proceed to Phase 4 without ALL reference images validated.

**5 Reference Categories (all hard block):**

| # | Category | Naming Pattern | Required When |
|---|----------|---------------|---------------|
| 1 | Character (cast) | `ref/cast-c{N}-face.png`, `-body.png`, `-costume.png` | Any scene with character |
| 2 | Product | `ref/product-{name}.png` | Any scene showing product |
| 3 | Environment | `ref/env-{location}.png` | Any B-Roll or location-specific scene |
| 4 | Brand Assets | `ref/brand-{asset}.png` | Any scene with visible logo/UI/brand |
| 5 | Costume/Uniform | `ref/costume-{institution}.png` | When institution detected |

**Auto-derive logic:** Engine scans scene-plan.md + cast-profile.md → builds ref-manifest.md → user uploads → engine validates 100% → proceed.

**No skip. No override. No "lanjut dulu."**

### Cultural Location Research

Phase 3.5 web searches 5 facts per location (license plates, ethnicity, landmarks, architecture, climate). Without this, AI generates generic visuals — wrong plate numbers, wrong ethnicity, wrong architecture. Results inject into NB2 environment prompts and VEO atmosphere. See `global-promo-config.md` Section 14.

**Brand logos MUST be user-provided** — AI cannot generate reliable logos. Ref image NB2 templates in `script-to-scene-bridge.md` Section 11.

### Storytelling Core Rules

**Product is NEVER the hero. Product is the BRIDGE. Customer is the hero. Brand is the guide.**

8 Commandments (cannot be overridden):
1. NEVER open with company name or logo
2. NEVER use jargon without immediate translation
3. Every feature MUST have a human consequence
4. Forbidden words: synergy, leverage, robust, revolutionary, cutting-edge, seamlessly, innovative solution, state-of-the-art
5. B-roll MUST advance the story (never decorative)
6. Every scene MUST pass the "So What?" test
7. CTA must be specific, time-bound, and low-friction
8. The first 3 seconds determine everything

22 rejection signals auto-checked — see `storytelling_script_gen/project-instruction.md`. Target market adaptation in `F1_Audience_Psychology_Matrix.md`. 7-beat arc and awareness routing in `F2` and `F8`.

## Technical Defaults

All configurable values live in `reference/global-promo-config.md` — single source of truth. Includes: resolution, aspect ratio, film stock, NB2 CFG/denoise, VEO duration, cast limits, ref naming conventions, institution keywords, tone impact matrix, and cultural search settings.

## Conventions for Contributors

### Changing Any Setting (Global, Cast, Tone, etc.)
1. Edit `reference/global-promo-config.md` — single source of truth (cast = Section 7)
2. No need to edit other files — they all reference global-promo-config.md

### Adding a New Reference File
1. Create `.md` file in `reference/`
2. Add entry to the Reference Files table in skill SKILL.md
3. Add entry to the Reference Files table in `agents/video-engine-agent.md`
4. Update this CLAUDE.md file
5. Run `/video-validate --refs` to verify cross-file consistency

### Adding a New Video Platform
1. Run `/video-add-platform` skill
2. It scaffolds platform guide, updates cross-references

### File Naming
- Reference files: lowercase, kebab-case (e.g., `global-promo-config.md`)
- No spaces in filenames
- Storytelling refs: `F{N}_{Name}.md` format (existing convention)
- Image-video refs: `{NN}-{name}.md` format (existing convention)

## Debugging

| Issue | Check |
|-------|-------|
| Edge hallucination in video | NB2 aspect ratio doesn't match VEO target — generate natively in target ratio |
| Wrong VEO mode selected | Ingredients ≠ First+Last Frame — they are MUTUALLY EXCLUSIVE |
| No audio in video | Audio is NEVER optional — specify all 3 layers (dialogue/VO, SFX, ambient) |
| Lip sync fails | Wrong dialogue syntax — use colon syntax `says:` not quotation marks |
| Frozen mouth in video | Camera too far — MCU/CU, face >30% frame, add "visible mouth openings" |
| Identity drift across clips | Weak context in final second — hold clear pose, use same description verbatim |
| Light jumps between clips | Different lighting in start/end frames — match Kelvin + direction in both NB2 images |
| Can't extend clip | Clip was generated at 1080p — use 720p for extendable clips |
| Stutter at extension joint | Abrupt motion at clip end — maintain consistent camera speed through final second |
| Script too corporate | Check 8 Commandments — forbidden words, missing human consequences |
| Weak hook | Must pass "So What?" test in first 3 seconds — check F5 Hook Vault |
| CTA too generic | Must be specific, time-bound, low-friction — check F6 CTA Vault |
| Wrong target market tone | Check F1 Audience Psychology Matrix for correct psychographic profile |
| Missing emotional beats | Check 7-Beat Arc compliance — all beats mandatory |
| Plastic texture in image | Over-denoising — prompt "visible pores", "natural grain", "micro-scratches" |
| B-Roll voiceover rendered as lip sync | Bare `Voiceover:` assigns speech to visible character — use `Voice-over narrator, [tone]: text` (VEO treats narrator as off-screen) |
| "Prominent people" safety error | Real person name in VEO `says:` + photorealistic face — use `Host says:` / `Presenter says:`, NEVER real names. NB2 can still use real names. |
| "Prominent people" on First+Last Frame | Two photorealistic face images uploaded to VEO — use single I2V (start frame only) for face-dominant scenes (face >30% frame) |
| Em dash audio artifact | `—` in says:/narrator: text — VEO audio engine mistranslates em dashes. Replace with `,` or `. ` |
| B-Roll scene has no narration | Silent B-Roll breaks continuous VO flow — every B-Roll MUST have `Voice-over narrator, [tone]: text` + `> POST-PROD VO:` backup |
| Face ref filename in VEO prompt | `cast-c{N}-face.png` in VEO prompt is useless and may trigger safety filter — face ref injection is NB2-only. VEO uses `Maintain visual continuity with reference frame character appearance.` |
| Identity conflict between cast members | Different characters look too similar — use distinct clothing + accessories + positioning per character |
| Wrong character appears in scene | NB2 prompt missing specific `cast-c{N}-face.png` identity lock — each prompt must reference exact cast slot (filename only, NO `ref/` prefix) |
| Costume doesn't match institution | Wrong/generic uniform generated — use `ref/costume-{institution}.png` as upload reference, describe badge/emblem details |
| Missing ref blocks Phase 4 | ref-manifest.md validation failed — upload ALL required refs to `{project}/ref/` per manifest |
| Multi-char dialogue overlap | VEO renders garbled speech — lip sync is 1 speaker at a time, use sequential delivery with reaction pauses |
| Cast member inconsistent across scenes | Weak reference phrase — use EXACT verbatim phrase from cast-profile.md in EVERY NB2 prompt |
| Wrong language in dialogue | narration_language not applied in Phase 2 — check strategic-brief.md Language field, ensure script uses it |
| Tone inconsistent across scenes | video_tone not applied uniformly — reference global-promo-config.md Section 13 Tone Impact Matrix |
| Wrong license plate in video | No cultural research performed — run Step 3.5.2a web search, check plat kendaraan fact |
| Wrong ethnicity for local extras | Cultural context missing — check strategic-brief.md Cultural Context, inject into NB2 |
| AI-generated logo looks wrong | Logo generation unreliable — brand logo MUST be user-provided, not AI-generated |
| Storyline missing beats | User input incomplete — Step 1.7 maps to 7-beat arc, AI suggests missing beats |
| Cross-file drift | Run `/video-validate --refs` — checks all reference files for consistency |
| Same element looks different across scenes | Recurring element not generated as standalone asset — auto-detect from av-script.md, generate in Phase 4A first |
| Gate/facility hallucinated wrong | No user photo used — auto-scan ref/ folder, existing photos = ground truth, NEVER override with text description |
| Product texture completely wrong | No product closeup reference — user photo mandatory (AI generates wrong species/shape for commodities like cangkang) |
| Wrong aspect ratio in NB2 output | Missing triple enforcement — add aspect ratio to FIRST line, TECHNICAL section, and LAST line of every prompt |
| UI text in wrong language | ui_text_language not applied — on-screen text must match narration_language, except technical abbreviations |
| Composite asset has wrong sub-elements | Wrong tier assignment — composite tier = max(sub-element tiers) + 1. Generate sub-elements FIRST |
| Ref in upload table but model ignores it | Missing ref-to-prompt body binding — every ref in table needs matching injection line in prompt body text |
| User doesn't know where to save output | Missing Output filename — every NB2 prompt needs explicit `**Output →** ref/filename.png` line |
| Costume inappropriate for climate | No climate-aware check — cross-check costume vs location climate after cultural research (Step 3.5.2a) |
| Scene keyframe describes element from scratch | Asset-first violation — if element has ref in Phase 4A, scene keyframe MUST reference it, not describe from text |
| Identity conflict between cast members | Different characters look too similar — use distinct clothing + accessories + positioning per character |
| Wrong character appears in scene | NB2 prompt missing specific `cast-c{N}-face.png` identity lock — each prompt must reference exact cast slot (filename only, NO `ref/` prefix) |
| Costume doesn't match institution | Wrong/generic uniform generated — use `ref/costume-{institution}.png` as upload reference, describe badge/emblem details |
| Missing ref blocks Phase 4 | ref-manifest.md validation failed — upload ALL required refs to `{project}/ref/` per manifest |
| Multi-char dialogue overlap | VEO renders garbled speech — lip sync is 1 speaker at a time, use sequential delivery with reaction pauses |
| Cast member inconsistent across scenes | Weak reference phrase — use EXACT verbatim phrase from cast-profile.md in EVERY NB2 prompt |
| Wrong language in dialogue | narration_language not applied in Phase 2 — check strategic-brief.md Language field, ensure script uses it |
| Generic stock-photo environment | Scene Logic Realism check 1 failed — prompt must reference cultural research + ref/env-{location}.png, not generic "modern office" |
| Workers posing instead of working | Scene Logic Realism check 2 failed — direct plausible actions: "supervisor reviewing clipboard," not "supervisor smiling at camera" |
| Dashboard numbers inconsistent | Scene Logic Realism check 3 failed — pin specific numbers and names across all scenes showing same data |
| Supervisor in operator uniform | Scene Logic Realism check 4 failed — uniform details must match institutional rank hierarchy (stripes, helmet color, vest) |
| AI adds wrong elements to scene | Scene Logic Realism check 5 failed — add explicit negatives: "no outdoor elements," "no sunlight" for indoor/night |
| Dawn scene followed by midday lighting | Scene Logic Realism check 7 failed — timeline consistency: connected scenes must share same time-of-day lighting |
| Character face changes between scenes | Character portrait-first rule violated — generate standalone face ref in Phase 4A Tier 1 BEFORE any scene keyframe |
| Scenes feel disconnected / no flow | Narrative arc consistency missing — add NARRATIVE CONTEXT block: connections, visual breadcrumbs, cause-effect chains |
| Same dashboard shows different names | Data not pinned across scenes — use exact same text/numbers in every prompt showing the same data display |
| Wrong machine/equipment in scene | No domain research — Step 1.2c Domain Deep Research must complete before script. WebSearch 5 queries about domain process/equipment/roles |
| Operator doing wrong action | Domain knowledge missing — check strategic-brief.md Domain Knowledge > Operator Roles table for plausible actions per role |
| Generic "factory" instead of specific domain | Missing DOMAIN CONTEXT line in prompt — inject specific equipment/process details from Domain Knowledge section |
| Product UI/interface looks nothing like real thing | No product research — WebSearch "{product_name} product interface screenshots features" in Step 1.2c |
| NB2 identity lock fails / face not matched | Prompt body text uses `ref/cast-c1-face.png` instead of bare `cast-c1-face.png` — NB2 matches by uploaded filename, `ref/` prefix causes lookup failure. Remove ALL folder prefixes from identity lock lines and reference image mentions in prompt body |
| Ref image uploaded but model ignores identity | Reference filename in header block at top of prompt, not inline with character — model reads past header blocks. Move filename inline: `[Name] (Maintain exact facial identity from reference image: cast-c1-face.png) — description...` |
| Same ref file mentioned multiple times | Duplicate filename dilutes reference signal. Each filename MAX 1x per prompt — place inline with the primary element it describes |
| ref/ prefix in Required Reference Images table | Upload table filenames use `ref/filename.png` — user copies wrong filename to NB2. Table MUST use bare filenames only (e.g., `cast-c1-face.png`), add "Upload all to `{project}/ref/` folder" note |
| Reference table appears above image heading | Table placement wrong — table MUST appear directly BELOW each image/prompt heading, BEFORE the prompt body. Not above heading, not after prompt body |
| VEO voiceover mispronounces words | Em dash `—` in `says:` or `Voice-over narrator:` text — VEO audio engine mistranslates em dashes. Replace with `,` or `. ` in all dialogue/voiceover text including template placeholders |

---

**Version:** 2.1.1
**Last Updated:** 2026-04-09
