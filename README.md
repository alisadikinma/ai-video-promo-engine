# AI Video Promo Engine

**v2.2.0** — Claude Code plugin that generates complete promotional video production packages — from brainstorm to script to image prompts (NB2) to video prompts (VEO 3.1 / Seedance 2.0).

Anyone — video agencies, freelancers, brand owners — can produce professional 2-3 minute promotional videos by following the generated production plan.

> **v2.2.0 hardening:** 4 new enforcement rules close gaps that previously allowed mid-production restructures — BODY 1 narrative completeness, NB2 reference uniqueness filter, max 5 inline refs per prompt, and environment-gated cross-scene references. See [v2.2.0 Hard Rules](#v220-hard-rules) below.

## What It Does

Give it a product or service, and the engine walks you through a 6-phase pipeline:

1. **Brainstorm** — language selection, cast builder (1-5 characters), institution detection, target market, awareness level, storyline input, tone/mood selection
2. **Script** — 2-3 min A/V script with 7-beat narrative arc (or 6-stage user framework alias: HOOK → Foreshadow → BODY 1 → BODY 2 → Peak → Ending+CTA), beat labels, timing, narration, audio direction. v2.2.0+: BODY 1 Completeness rule enforces ALL identified pains dramatized as dedicated scenes.
3. **Scene Breakdown** — auto-calculated scene count, VEO mode per scene, extension strategy
4. **Reference Collection** — auto-derive ref manifest, cultural location research, batch NB2 prompts for missing refs, hard-block validation gate
5. **Image Prompts (NB2)** — Phase 4A: asset library (atoms with dependency graph) → Phase 4B: scene keyframes (molecules composed from assets)
6. **Video Prompts (VEO 3.1 / Seedance 2.0)** — per-scene prompts with camera movement, 3-layer audio, lip sync, extensions, vocal performance direction. Seedance 2.0 alt: native 2K, @ reference system, dual-branch AV, 10+ lip-sync languages

Each phase has a user approval gate before proceeding. Phase 3.5 (Reference Collection) is a hard block — 100% of reference images must be validated before image generation.

## Installation

### Via Claude Code Marketplace (Recommended)

```bash
# Step 1: Add marketplace source
claude plugins marketplace add alisadikinma/ai-content-suite

# Step 2: Install plugin
claude plugins install ai-video-promo-engine
```

### Manual Installation

Clone into your Claude Code plugins directory:

```bash
# macOS / Linux
git clone https://github.com/alisadikin/ai-video-promo-engine.git \
  ~/.claude/plugins/ai-video-promo-engine

# Windows
git clone https://github.com/alisadikin/ai-video-promo-engine.git ^
  %USERPROFILE%\.claude\plugins\ai-video-promo-engine
```

Then restart Claude Code. The plugin auto-registers on session start.

## Usage

### Full Pipeline (End-to-End)

```
/video-full
```

Starts the full interactive pipeline. The orchestrator runs all 4 production skills in sequence, asking questions and generating outputs phase-by-phase with approval gates.

**Flags:**
- `--full` (default) — full production plan with storyboard notes, NB2 prompts, VEO prompts, audio specs, extension strategy, post-production checklist
- `--quick` — copy-paste ready prompts only (NB2 + VEO per scene, no production plan)
- `--preset ali` — use Ali Sadikin creator preset instead of generic brand profile

### Individual Skills

Run any phase independently:

```
/video-brainstorm      # Phase 1: brainstorm, cast, product, location, domain research
/video-script          # Phase 2-3.5: script, scene breakdown, reference collection
/video-image           # Phase 4: NB2 asset library + scene keyframes
/video-gen             # Phase 5: image review + VEO video prompts
```

### Utility Skills

```
/video-validate            # Unified validator (--script / --image / --video / --refs / --all)
/video-add-platform        # Scaffold support for a new AI video platform
```

### Agents

- **`video-engine-agent`** — handles batch or complex promo work, can be dispatched for parallel processing
- **`video-prompt-reviewer`** — independent validator for NB2/VEO prompt batches (auto-spawned during Phase 4B and Phase 5)

## Production Stack

| Component | Technology |
|-----------|------------|
| Image Generation | Nano Banana 2 (NB2) — Gemini 3.1 Flash Image |
| Video Generation (Primary) | VEO 3.1 — 720p/1080p, 8s clips, 148s extension chain |
| Video Generation (Alt) | Seedance 2.0 — native 2K, 15s clips, @ reference system, dual-branch AV |
| Pipeline (VEO) | NB2 image → VEO First+Last Frame / Ingredients → VEO Extend |
| Pipeline (Seedance) | NB2 image → Seedance @Image refs + Omni mode → Seedance @Video extend |

## Key Features

- **Multi-Character Cast System** — 1-5 characters with Pemeran Utama/Pendamping roles, per-character identity lock, institution-aware costume detection
- **Language Selection** — Bahasa Indonesia, English, or Bilingual (NB2/VEO prompts always English)
- **6 Tone/Mood Options** — Humorous, Serious, Professional, Inspirational, Casual, Edgy — affects cinematography, audio, and expression across all phases
- **5 Target Markets** — C-Level, VP/Director, Manager, Individual Contributor, Social Media — each with adapted tone, depth, and CTA style
- **5 Awareness Levels** — Unaware → Most-Aware routing to different narrative strategies
- **7-Beat Universal Arc** — Pattern Interrupt → Hook → Foreshadow → Agitate → Guide+Plan → Peak → CTA → Won Day. **v2.2.0+: also exposed as 6-stage user framework alias** — HOOK → Foreshadow → BODY 1 (Problems) → BODY 2 (Solutions) → Peak → Ending+CTA. Internally identical, user-facing simpler.
- **Asset-First Production with Uniqueness Filter (v2.2.0+)** — recurring elements (2+ scenes) auto-detected and generated as standalone assets BUT filtered by uniqueness criterion (UNIQUE → generate, COMMON generic items → skip and render from text). Dependency graph and tier system. Max 5 inline references per Phase 4B prompt enforced.
- **Film Directing Guide** — 180° rule, gaze direction, actor blocking, vocal performance direction, natural acting methodology, visual continuity supervision
- **Reference Image Validation Gate** — Phase 3.5 hard block with 5 ref categories, cultural location research (5 facts per location), batch NB2 prompt generation for missing refs
- **24 Reference Documents** — storytelling psychology, cinematography lookup, hook vault (100 hooks), CTA frameworks, directing grammar, platform adaptation, Seedance 2.0 production guide, and more
- **Scene Auto-Calculation** — optimal scene count from script beats with VEO mode mapping
- **Dual Video Platform Support** — VEO 3.1 (primary) + Seedance 2.0 (alt) with platform-specific prompt generation, camera libraries, and audio specs
- **Seedance 2.0 Integration** — native 2K resolution, @ reference system (9 images + 3 videos + 3 audio), dual-branch AV generation, 3-Angle Rule identity lock, 10+ lip-sync languages including Indonesian, timestamp-based multi-shot storyboarding
- **Extension Strategy** — VEO Extend (up to ~148s chains) or Seedance @Video extend (unlimited chains, drift ~20th hop)
- **"Last Frame Secret"** — seamless scene transitions by feeding Clip A's final frame into Clip B's NB2 start frame
- **Image Review Before Video** — per-scene collaborative review where AI reads actual keyframe images (multimodal), compares with NB2 prompts, and brainstorms VEO approach with user before generating video prompts
- **Cross-File Validation** — unified validator with 5 targets: script, image, video, refs, all

## Storytelling Philosophy

> Product is NEVER the hero. Product is the BRIDGE. Customer is the hero. Brand is the guide.

The script engine enforces **9 commandments (v2.2.0+)** (no opening with brand name, no jargon without translation, every feature needs a human consequence, **BODY 1 must dramatize ALL identified problems**, etc.) and auto-checks for 22+ structural failure patterns.

## v2.2.0 Hard Rules

Released 2026-05-14 to close gaps revealed during real-world production (IRN-Logistik hero promo). The 4 rules are enforced at validator phase gates:

| # | Rule | Validator | Phase | What it prevents |
|---|---|---|---|---|
| 1 | **BODY 1 Completeness** — count(pains dramatized in BODY 1 scenes) ≥ count(pains identified in brainstorm). Pairing OK if shared root cause (max 2/scene). Anchor pain non-pairable. | C1 | Phase 2 (Script) | Solutions outweighing problems → under-earned Peak. Auto-fails when script overlay says "1 dari N" while N>1, or coverage <50%. |
| 2 | **NB2 Reference Uniqueness Filter** — generate Phase 4A assets ONLY for UNIQUE items (faces, logos, custom UI, industry-specific equipment). SKIP for COMMON items (generic phone, kopi gelas, pavement) — NB2 renders these reliably from text. | C2 | Phase 4A (Asset Library) | Wasted generation budget on generic assets that don't need refs. Cluttered upload tables. |
| 3 | **Max 5 Inline References per Phase 4B Prompt** — combined cap on faces + bodies + costumes + objects + envs + UI. All inline. Each filename max 1× per prompt. Replaces old "Max 3 identity locks". | C3 | Phase 4B (Scene Keyframes) | NB2 ignoring lower-priority refs when prompts exceed cap. Forces scene splitting or composite asset consolidation. |
| 4 | **Cross-Scene Reference Env-Gated** — Scene N+1 START references `scene-N-end.png` ONLY IF env(N) == env(N+1). Character/prop continuity alone is NOT sufficient. Hard cuts (different env) drop cross-ref entirely. | C4 | Phase 4B (Scene Keyframes) | NB2 mixing wrong-location elements when treating cross-env scene-end.png as compositional template (e.g., yard pavement bleeding into customer warehouse floor). |

Full rule text + decision tables + examples: [`reference/global-promo-config.md`](reference/global-promo-config.md) §25, §26, §27.

Validator details: [`agents/video-prompt-reviewer.md`](agents/video-prompt-reviewer.md) checks C1-C4.

Implementation plan: [`docs/plans/2026-05-14-plugin-rules-hardening.md`](docs/plans/2026-05-14-plugin-rules-hardening.md).

## Project Structure

```
.claude-plugin/plugin.json          # Plugin metadata
hooks/                              # Session start hook
skills/
  video-brainstorm/SKILL.md         # Phase 1 — brainstorm, cast, product, location
  video-script/SKILL.md             # Phase 2-3.5 — script, scene, reference collection
  video-image/SKILL.md              # Phase 4 — NB2 asset library + scene keyframes
  video-gen/SKILL.md                # Phase 5 — image review + VEO video prompts
  video-full/SKILL.md               # Orchestrator — runs all 4 skills in sequence
  video-validate/SKILL.md           # Unified validator (5 targets)
  video-add-platform/SKILL.md       # Scaffold new video platform
agents/
  video-engine-agent.md             # Subagent for batch/complex work
  video-prompt-reviewer.md          # Independent prompt quality validator
reference/
  global-promo-config.md            # Single source of truth for all settings
  creator-profile-system.md         # Creator/brand profile setup
  script-to-scene-bridge.md         # Script → scene → prompts bridge
  storytelling_script_gen/           # 12 storytelling & script reference files
  image-video-gen/                  # 9 image & video production reference files
```

## Configuration

All configurable values live in `reference/global-promo-config.md` — the single source of truth. Settings include default language, video/image resolution, film stock, color temperature, NB2 parameters, VEO duration, output mode, and creator preset.

## Contributing

1. **Change a setting** — edit `reference/global-promo-config.md` only
2. **Add a reference file** — create in `reference/`, update relevant SKILL.md + agent + CLAUDE.md, run `/video-validate --refs`
3. **Add a video platform** — run `/video-add-platform` to scaffold everything

## License

[MIT](LICENSE)

## Author

**Ali Sadikin** — [GitHub](https://github.com/alisadikin)
