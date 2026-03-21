# AI Video Promo Engine — Claude Project Instructions

## Project Overview

Claude Code plugin that generates complete promotional video production packages: from brainstorm to script to image prompts (NB2) to video prompts (VEO 3.1). 1 main skill + 2 utility skills + 1 agent + 23 reference documents as RAG knowledge base.

**Core Value:** Anyone — video agencies, freelancers, brand owners — can produce professional 2-3 minute promotional videos by following the generated production plan.

## Commands

| Command | Description |
|---------|-------------|
| `/promo-engine` | Run end-to-end video promo pipeline (brainstorm → script → images → video) |
| `/promo-validate` | Cross-file consistency checker across all 23 reference files |
| `/promo-add-platform` | Scaffold new AI video platform support |

## Architecture

| Path | Purpose |
|------|---------|
| `.claude-plugin/plugin.json` | Plugin metadata (name, version, author) |
| `hooks/hooks.json` | SessionStart hook definition |
| `hooks/session-start.sh` | Session start script — announces available skills |
| `skills/promo-engine/SKILL.md` | Main skill — end-to-end promo video pipeline |
| `skills/promo-validate/SKILL.md` | Cross-file consistency checker |
| `skills/promo-add-platform/SKILL.md` | Scaffold new video platform support |
| `agents/promo-engine-agent.md` | Subagent for batch/complex promo work (6-phase pipeline) |
| `reference/` | 23 reference docs read on-demand by skill/agent |
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

#### Image & Video Production (8 files)

| File | When Used |
|------|-----------|
| `image-video-gen/00-index.md` | ALWAYS for image/video — production stack overview, critical constraints |
| `image-video-gen/01-nb2-image-generation.md` | NB2 image prompts — parameters, resolution, identity lock, material shaders, text rendering |
| `image-video-gen/02-veo-production-guide.md` | VEO 3.1 video prompts — specs, camera movement, I2V motion, lip sync, extensions, audio |
| `image-video-gen/03-workflow-pipeline.md` | NB2 → VEO pipeline — decision tree, handoff rules, extension chain, "Last Frame Secret" |
| `image-video-gen/04-cinematography-lookup.md` | Emotion → complete setup mapping (lighting, lens, film stock, atmosphere, camera motion) |
| `image-video-gen/05-creator-and-holidays.md` | Ali Sadikin as cast slot, cast-c{N} naming, holiday palettes, cultural context |
| `image-video-gen/06-directing-and-performance.md` | Film directing grammar — 180° rule, gaze direction, blocking, vocal performance, continuity supervision |
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
  ├─ Start frame + End frame per scene (Frame mode)
  ├─ Ingredient images (Ingredients mode)
  ├─ EVERY visual element references Phase 4A asset (no text-only descriptions)
  ├─ Aspect ratio triple enforcement
  ├─ Output filename per prompt
  ├─ Ref-to-prompt body binding
  ├─ UI text localization
  └─ [USER APPROVAL GATE]

Phase 5: VIDEO PROMPTS (VEO)   → Output: video-prompts.md
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
- **Video Model**: VEO 3.1 (primary, extensible to other platforms)
- **Pipeline**: NB2 image → VEO First+Last Frame / Ingredients → VEO Extend

### Critical Audio Rules

- Audio is NEVER optional — unspecified = VEO guesses random sounds
- Presenter scenes: `[Character] says: text` (colon syntax, NEVER quotation marks) — lip sync ON, face >30% frame
- B-Roll scenes: `Voiceover:` NOT `says:` — no lip sync, music mandatory
- Always add: `no subtitles, no audience sounds, no text overlays`
- See `image-video-gen/02-veo-production-guide.md` for full audio specs and duration rules

### VEO 3.1 Mode Selection (Mutual Exclusivity)

```
Need consistent CHARACTER across shots?
├── YES → "Ingredients to Video" (1-3 ref images)
│         Cannot combine with First+Last Frame
│
└── NO, need controlled TRANSITION between two states?
    ├── YES → "First + Last Frame" (Keyframe Control)
    │         Generate START image (NB2) + END image (NB2)
    │         VEO interpolates the motion between them
    │
    └── NO, need to CONTINUE an existing clip?
        └── "Scene Extension" (Extend)
            Source must be VEO-generated, 720p only
            Uses final 1 second as context anchor
```

**CRITICAL: Ingredients ≠ First+Last Frame. They are MUTUALLY EXCLUSIVE. Pick ONE per generation.**

### Key Technical Rules

- **Resolution Rule:** Generate initial clip at **720p** if ANY extensions planned. 1080p = 8s only, CANNOT extend.
- **NB2 aspect ratio MUST match VEO target** — mismatch = edge hallucination.
- **NB2 Prompt Formula:** `Subject/Material + Lighting Architecture + Camera/Lens + Campaign Context`
- Scene count auto-calculated from script beats. Scene → VEO mode mapping in `script-to-scene-bridge.md`.
- VEO specs (resolution, duration, extensions, prompt limits) in `image-video-gen/02-veo-production-guide.md`.
- NB2 parameters (CFG, denoise, thinking mode, identity lock) in `image-video-gen/01-nb2-image-generation.md`.
- Cinematography defaults per content type in `image-video-gen/04-cinematography-lookup.md`.

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
3. Add entry to the Reference Files table in `agents/promo-engine-agent.md`
4. Update this CLAUDE.md file
5. Run `/promo-validate` to verify cross-file consistency

### Adding a New Video Platform
1. Run `/promo-add-platform` skill
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
| B-Roll voiceover rendered as lip sync | B-Roll should use `Voiceover:` NOT `says:` — no lip sync for B-Roll |
| Identity conflict between cast members | Different characters look too similar — use distinct clothing + accessories + positioning per character |
| Wrong character appears in scene | NB2 prompt missing specific `ref/cast-c{N}-face.png` — each prompt must reference exact cast slot |
| Costume doesn't match institution | Wrong/generic uniform generated — use `ref/costume-{institution}.png` as reference, describe badge/emblem details |
| Missing ref blocks Phase 4 | ref-manifest.md validation failed — upload ALL required refs to `{project}/ref/` per manifest |
| Multi-char dialogue overlap | VEO renders garbled speech — lip sync is 1 speaker at a time, use sequential delivery with reaction pauses |
| Cast member inconsistent across scenes | Weak reference phrase — use EXACT verbatim phrase from cast-profile.md in EVERY NB2 prompt |
| Wrong language in dialogue | narration_language not applied in Phase 2 — check strategic-brief.md Language field, ensure script uses it |
| Tone inconsistent across scenes | video_tone not applied uniformly — reference global-promo-config.md Section 13 Tone Impact Matrix |
| Wrong license plate in video | No cultural research performed — run Step 3.5.2a web search, check plat kendaraan fact |
| Wrong ethnicity for local extras | Cultural context missing — check strategic-brief.md Cultural Context, inject into NB2 |
| AI-generated logo looks wrong | Logo generation unreliable — brand logo MUST be user-provided, not AI-generated |
| Storyline missing beats | User input incomplete — Step 1.7 maps to 7-beat arc, AI suggests missing beats |
| Cross-file drift | Run `/promo-validate` — checks all 23 reference files for consistency |
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

---

**Version:** 1.5.0
**Last Updated:** March 2026
