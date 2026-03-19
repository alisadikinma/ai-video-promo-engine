# AI Video Promo Engine — Claude Project Instructions

## Project Overview

Claude Code plugin that generates complete promotional video production packages: from brainstorm to script to image prompts (NB2) to video prompts (VEO 3.1). 1 main skill + 2 utility skills + 1 agent + 22 reference documents as RAG knowledge base.

**Core Value:** Anyone — video agencies, freelancers, brand owners — can produce professional 2-3 minute promotional videos by following the generated production plan.

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
| `reference/` | 22 reference docs read on-demand by skill/agent |
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

#### Image & Video Production (7 files)

| File | When Used |
|------|-----------|
| `image-video-gen/00-index.md` | ALWAYS for image/video — production stack overview, critical constraints |
| `image-video-gen/01-nb2-image-generation.md` | NB2 image prompts — parameters, resolution, identity lock, material shaders, text rendering |
| `image-video-gen/02-veo-production-guide.md` | VEO 3.1 video prompts — specs, camera movement, I2V motion, lip sync, extensions, audio |
| `image-video-gen/03-workflow-pipeline.md` | NB2 → VEO pipeline — decision tree, handoff rules, extension chain, "Last Frame Secret" |
| `image-video-gen/04-cinematography-lookup.md` | Emotion → complete setup mapping (lighting, lens, film stock, atmosphere, camera motion) |
| `image-video-gen/05-creator-and-holidays.md` | Ali Sadikin as cast slot, cast-c{N} naming, holiday palettes, cultural context |
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
  ├─ Upload tech doc (optional)
  ├─ Cast builder (1-5 characters, Utama/Pendamping roles)
  ├─ Institution detection + costume confirmation
  ├─ Discuss product, storyline, pain points
  ├─ Select target market (C-Level / Manager / Social Media / etc.)
  ├─ Select awareness level
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
  ├─ User uploads to {project}/ref/
  ├─ Validate ALL refs exist
  └─ [HARD BLOCK — 100% required before Phase 4]

Phase 4: IMAGE PROMPTS (NB2)   → Output: image-prompts.md
  ├─ Start frame + End frame per scene (Frame mode)
  ├─ Ingredient images (Ingredients mode)
  ├─ Cast face/body/costume references per character
  ├─ Product/brand reference images
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

### Audio Strategy (Two Scene Types)

| Scene Type | Lip Sync | Dialogue | SFX | Music | Ambient |
|------------|----------|----------|-----|-------|---------|
| **Presenter/Talking Head** | YES | `Host says: [text]` (colon syntax) | YES | Optional | YES |
| **B-Roll** | NO | Voiceover in background (NOT lip sync) | YES | YES (mandatory) | YES |

**Critical Audio Rules:**
- Audio is NEVER optional — unspecified = VEO guesses random sounds
- VEO dialogue uses colon syntax: `[Character] says: text` — NEVER quotation marks
- 3-6s dialogue sweet spot, 8-15 words per 8s clip
- B-Roll voiceover = narration track, NOT lip-synced to character
- Always add: `no subtitles, no audience sounds, no text overlays`
- Face must be >30% of frame for lip sync to work

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

### Scene Strategy (Auto-Calculated)

The engine auto-calculates optimal scene count from script beats:

| Video Duration | Typical Scenes | Per Scene | Strategy |
|---------------|---------------|-----------|----------|
| 120s (2 min) | 8-12 scenes | 8-16s each | 1 gen + 0-1 extend |
| 150s (2.5 min) | 10-14 scenes | 8-16s each | 1 gen + 0-1 extend |
| 180s (3 min) | 12-16 scenes | 8-16s each | 1 gen + 0-2 extend |

**Scene → VEO Mode Mapping:**
| Scene Type | VEO Mode | Reason |
|------------|----------|--------|
| Hook (opening) | First+Last Frame | Controlled dramatic transition |
| Presenter talking | Ingredients | Character consistency across shots |
| B-Roll product | First+Last Frame | Show product state change |
| B-Roll environment | First+Last Frame | Controlled camera movement |
| Demo/walkthrough | Ingredients + Extend | Same character, continuous action |
| Testimonial | Ingredients + Extend | Face consistency for lip sync |
| CTA (closing) | First+Last Frame | Dramatic ending transition |
| Multi-char dialogue | Ingredients | Character consistency, sequential lip sync |
| Multi-char B-Roll | First+Last Frame | Controlled environment with multiple characters |
| Same scene continuation | Extend | 720p, +7s per hop |
| Different scene | New generation | New start/end frames needed |

### VEO Technical Constraints

| Param | Value | Notes |
|-------|-------|-------|
| Resolution | 720p (default), 1080p | 1080p = 8s clips only, CANNOT extend |
| Aspect | 16:9, 9:16 | No 1:1 support |
| Frame rate | 24fps | Fixed |
| Duration | 4, 6, 8 seconds | 8s required for extensions |
| Max extensions | +7s per hop, max 20 | ~148s total possible |
| Reference images | Up to 3 | Asset or style type |
| Prompt tokens | 1,024 max | Optimal: 100-150 words |

**Resolution Rule:** Generate initial clip at **720p** if ANY extensions planned. 1080p only for final non-extendable clips.

### NB2 Image Generation

| Parameter | Range | Notes |
|-----------|-------|-------|
| CFG Scale | 5.0–7.0 | >8 = hyper-processed |
| Denoise | 0.35–0.45 | >0.50 = structural hallucination |
| Thinking Mode | Minimal (drafts) / High (final 4K) | High = ~35pt quality increase |
| Max Resolution | Native 4K (4096×4096) | |
| Aspect Match | NB2 ratio MUST match VEO target | Mismatch = edge hallucination |
| Central 60% | Keep critical action in center | Cross-platform safety |

**Prompt Formula:** `Subject/Material + Lighting Architecture + Camera/Lens + Campaign Context`

**Identity Lock:** Track up to 5 characters + 14 objects per workflow (maps to cast system max 5 characters). Generate hero shot → reference sheet → inject via `@identity` tag. Each cast member uses `ref/cast-c{N}-face.png` as identity anchor.

### Cast System (Multi-Character)

Replaces the single-creator model. Supports 1-5 characters per video.

- **Pemeran Utama** (main, 1-3): FULL identity lock — face + body + costume ref MANDATORY
- **Pemeran Pendamping** (supporting, 0-2): PARTIAL identity lock — face ref MANDATORY, body/costume OPTIONAL
- **Ali Sadikin preset**: Pre-configured profile that fills 1 Pemeran Utama cast slot
- **Institution-aware costume**: Auto-detects institutional brand (KAI, Pelindo, BRI, etc.) and requires uniform reference images
- **Cast profile storage**: `{project-folder}/cast-profile.md` with per-character reference phrases
- **Reference images**: `{project-folder}/ref/` using naming convention `cast-c{N}-face.png`, `cast-c{N}-body.png`, `cast-c{N}-costume.png`
- **Max characters**: 5 total (matches NB2 identity lock limit of 5 characters + 14 objects)

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

### Institution-Aware Costume System

Auto-detects if the product/brand is tied to a specific Indonesian institution and requires matching uniform reference images.

**Detection:** Engine scans brand name + product description for keywords (KAI, Pelindo, BRI, PLN, Pertamina, Garuda, RS, TNI/Polri, Pos Indonesia, Damri, Telkom, BUMN generic) → confirms with user via AskUserQuestion → flags costume_type = "institutional"

**Impact:** When institutional, ALL cast members in relevant scenes MUST have costume reference uploaded. NB2 prompts inject: "wearing official {institution} uniform as shown in reference image ref/cast-c{N}-costume.png"

### Target Market Differentiation

The script engine adapts tone, depth, and CTA based on target market:

| Target | Tone | Depth | CTA Style | Video Style |
|--------|------|-------|-----------|-------------|
| **C-Level** | Strategic, ROI-focused | High-level business impact | "Schedule strategic briefing" | Cinematic, data overlays |
| **VP/Director** | Operational, efficiency | Department-level impact | "Request team demo" | Professional, case studies |
| **Manager** | Practical, workflow | Day-to-day improvements | "Start free trial" | Demo-heavy, before/after |
| **Individual Contributor** | Technical, hands-on | Feature deep-dive | "Try it now" | Tutorial, screen captures |
| **Social Media** | Emotional, punchy, Gen-Z | Surface + hook | "Comment [WORD]" | Fast cuts, pattern interrupts |

### Storytelling Core Axiom

**Product is NEVER the hero. Product is the BRIDGE. Customer is the hero. Brand is the guide.**

### 7-Beat Universal Arc (Mandatory)

| Beat | Timing | Purpose |
|------|--------|---------|
| Pattern Interrupt | 0–1.7s | Stop the scroll |
| Hook | 1.7–5s | Promise value |
| Foreshadow | 5–8s | Create anticipation |
| Agitate | 8–15s | Deepen the problem |
| Guide + Plan | 15–40s | Present solution |
| Peak | 60–75% mark | Emotional climax |
| CTA | Post-peak | Convert attention |
| Won Day | Final frame | Future-state visualization |

### 8 Scriptwriting Commandments (Cannot Be Overridden)

1. NEVER open with company name or logo
2. NEVER use jargon without immediate translation
3. Every feature MUST have a human consequence
4. Forbidden words: synergy, leverage, robust, revolutionary, cutting-edge, seamlessly, innovative solution, state-of-the-art
5. B-roll MUST advance the story (never decorative)
6. Every scene MUST pass the "So What?" test
7. CTA must be specific, time-bound, and low-friction
8. The first 3 seconds determine everything

### Rejection Signals (22 Structural Failure Patterns)

The script engine auto-checks for 22 failure patterns including:
- Feature listing without human consequence
- Generic stock footage descriptions
- Missing emotional beats
- CTA without specificity
- Opening with brand name
- Jargon without translation
- See `storytelling_script_gen/project-instruction.md` for full list

### Interactive Flow (AskUserQuestion)

Every phase uses `AskUserQuestion` for user interaction:

**Phase 1 (Brainstorm + Cast Builder):**
- "What product/service is this video for?"
- "Do you have technical documentation to upload?"
- "How many characters in this video?" → 1-5, with role assignment (Pemeran Utama / Pemeran Pendamping)
- "Is this tied to a specific institution?" → auto-detected from brand name, confirmed with user
- "Who is the target audience?" → C-Level / Manager / Social Media / etc.
- "What's the awareness level?" → Unaware / Problem-Aware / Solution-Aware / Product-Aware / Most-Aware
- "What's the core emotional transformation?" → options based on product category

**Phase 2 (Script):**
- Present script with A/V table
- "Approve this script?" → Approve / Revise (specify) / Start over

**Phase 3 (Scene Breakdown):**
- Present scene plan with VEO modes
- "Approve scene plan?" → Approve / Adjust scenes / Change VEO modes

**Phase 3.5 (Reference Collection):**
- Present ref-manifest.md checklist (5 categories)
- "Upload all required reference images to {project}/ref/"
- Engine validates 100% — HARD BLOCK until all refs present

**Phase 4 (Image Prompts):**
- Present NB2 prompts per scene
- "Approve image prompts?" → Approve / Revise specific scenes

**Phase 5 (Video Prompts):**
- Present VEO prompts with audio specs
- "Final approval?" → Approve / Revise

### Extension Strategy for Same-Scene Continuity

When a scene needs more than 8s (same location, continuous action):
1. Generate initial clip at **720p** (mandatory for extend)
2. Hold pose/camera movement for final 0.5s
3. Extension prompt: `"Continue from previous clip. [New action]. Camera continues [same movement]. Maintain lighting, environment, character. Audio continues: [same ambient]. No subtitles."`
4. Monitor for identity drift across extensions
5. Maximum 20 extensions (~148s) per chain

### Scene Transition Strategy

When switching to a different scene:
1. Generate NEW start frame + end frame in NB2
2. Both frames must share: same aspect ratio, same lighting Kelvin, same color palette, same wardrobe, same lens
3. Use transition end instruction in previous scene's VEO prompt
4. **"Last Frame Secret"**: Export final frame of Clip A → feed into NB2 as reference for Clip B's start frame (preserves grading, position, lighting)

### Cinematography Defaults per Content Type

| Content | Shot | Lens | Lighting | Ratio | Atmosphere |
|---------|------|------|----------|-------|------------|
| Hook | CU/MCU | 85mm | Rembrandt 4:1 | 4:1 | Light haze |
| Explanation | MCU/MS | 50mm | Loop 2:1 | 2:1 | Clean |
| Demo | MS/MWS | 35mm | Soft 2:1 | 2:1 | Clean |
| Testimonial | MCU | 85mm | Butterfly 2:1 | 2:1 | Clean |
| CTA | CU | 85mm | Rembrandt 4:1 | 4:1 | Light haze |
| B-roll product | Various | 50-100mm | Soft commercial | — | Minimal |
| B-roll environment | WS/EWS | 24-35mm | Natural | — | Atmospheric |

## Capabilities

1. **Brainstorm & Discovery** — interactive AskUserQuestion flow, tech doc upload, target market selection, awareness routing
2. **Script Generation** — 2-3 min A/V script with 7-beat arc, beat labels, timing, narration, audio direction
3. **Scene Breakdown** — auto-calculated scene count, VEO mode per scene, extension strategy, duration allocation
4. **NB2 Image Prompts** — start/end frames, ingredient images, cast face/body/costume references, product references
5. **VEO 3.1 Video Prompts** — per-scene prompts with camera movement, audio 3-layer, lip sync, extension prompts
6. **Target Market Adaptation** — C-Level / VP / Manager / IC / Social Media tone and CTA differentiation
7. **Awareness Level Routing** — 5 levels route to different narrative strategies
8. **Multi-Character Cast System** — 1-5 characters with Pemeran Utama/Pendamping roles, per-character identity lock
9. **Reference Image Validation Gate** — Phase 3.5 hard block, auto-derive manifest from scene plan
10. **Institution-Aware Costume** — auto-detect Indonesian institutions, require uniform reference images
11. **Production Plan** — full production plan with storyboard notes, checklists (--full mode)
12. **Copy-Paste Prompts** — direct NB2/VEO prompts ready for platform (--quick mode)
13. **Platform Extensibility** — add new video AI platforms via /promo-add-platform skill
14. **Cross-File Validation** — consistency checker across all 22 reference files

## Technical Defaults

> All configurable values are in `reference/global-promo-config.md`. This table shows setting NAMES.

| Setting | Source |
|---------|--------|
| Default language | Per global-promo-config.md `default_language` |
| Video aspect ratio | Per global-promo-config.md `video_aspect_ratio` |
| Video resolution | Per global-promo-config.md `video_resolution` |
| Image resolution | Per global-promo-config.md `image_resolution` |
| Film stock | Per global-promo-config.md `film_stock` |
| Color temp | Per global-promo-config.md `color_temp` |
| NB2 CFG Scale | Per global-promo-config.md `nb2_cfg` |
| NB2 Denoise | Per global-promo-config.md `nb2_denoise` |
| VEO duration | Per global-promo-config.md `veo_duration` |
| VEO audio quality | Per global-promo-config.md `veo_audio_quality` |
| Output mode | Per global-promo-config.md `output_mode` (full/quick) |
| Ali Sadikin preset | Per global-promo-config.md `ali_preset_available` |
| Max cast members | Per global-promo-config.md `max_cast` |
| Cast ref requirements | Per global-promo-config.md Section 7 |
| Ref naming convention | Per global-promo-config.md Section 11 |
| Institution keywords | Per global-promo-config.md Section 12 |
| Ref validation mode | Per global-promo-config.md `ref_validation_mode` |

## Conventions for Contributors

### Changing a Global Setting
1. Edit `reference/global-promo-config.md` — single source of truth
2. No need to edit other files — they all reference global-promo-config.md

### Changing a Cast Setting
1. Edit `reference/global-promo-config.md` Section 7 — single source of truth
2. No need to edit other files — they reference global-promo-config.md

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
| Cross-file drift | Run `/promo-validate` — checks all 22 reference files for consistency |

---

**Version:** 1.1.0
**Last Updated:** March 2026
