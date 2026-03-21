# AI Video Promo Engine

Claude Code plugin that generates complete promotional video production packages — from brainstorm to script to image prompts (NB2) to video prompts (VEO 3.1).

Anyone — video agencies, freelancers, brand owners — can produce professional 2-3 minute promotional videos by following the generated production plan.

## What It Does

Give it a product or service, and the engine walks you through a 6-phase pipeline:

1. **Brainstorm** — language selection, cast builder (1-5 characters), institution detection, target market, awareness level, storyline input, tone/mood selection
2. **Script** — 2-3 min A/V script with 7-beat narrative arc, beat labels, timing, narration, audio direction
3. **Scene Breakdown** — auto-calculated scene count, VEO mode per scene, extension strategy
4. **Reference Collection** — auto-derive ref manifest, cultural location research, batch NB2 prompts for missing refs, hard-block validation gate
5. **Image Prompts (NB2)** — Phase 4A: asset library (atoms with dependency graph) → Phase 4B: scene keyframes (molecules composed from assets)
6. **Video Prompts (VEO 3.1)** — per-scene prompts with camera movement, 3-layer audio, lip sync, extensions, vocal performance direction

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

### Main Skill

```
/promo-engine
```

Starts the full interactive pipeline. The engine asks questions, generates outputs phase-by-phase, and waits for your approval at each gate.

**Flags:**
- `--full` (default) — full production plan with storyboard notes, NB2 prompts, VEO prompts, audio specs, extension strategy, post-production checklist
- `--quick` — copy-paste ready prompts only (NB2 + VEO per scene, no production plan)
- `--preset ali` — use Ali Sadikin creator preset instead of generic brand profile

### Utility Skills

```
/promo-validate        # Cross-file consistency checker (23 reference files)
/promo-add-platform    # Scaffold support for a new AI video platform
```

### Subagent

The `promo-engine-agent` handles batch or complex promo work and can be dispatched for parallel processing.

## Production Stack

| Component | Technology |
|-----------|------------|
| Image Generation | Nano Banana 2 (NB2) — Gemini 3.1 Flash Image |
| Video Generation | VEO 3.1 (primary, extensible) |
| Pipeline | NB2 image → VEO First+Last Frame / Ingredients → VEO Extend |

## Key Features

- **Multi-Character Cast System** — 1-5 characters with Pemeran Utama/Pendamping roles, per-character identity lock, institution-aware costume detection
- **Language Selection** — Bahasa Indonesia, English, or Bilingual (NB2/VEO prompts always English)
- **6 Tone/Mood Options** — Humorous, Serious, Professional, Inspirational, Casual, Edgy — affects cinematography, audio, and expression across all phases
- **5 Target Markets** — C-Level, VP/Director, Manager, Individual Contributor, Social Media — each with adapted tone, depth, and CTA style
- **5 Awareness Levels** — Unaware → Most-Aware routing to different narrative strategies
- **7-Beat Universal Arc** — Pattern Interrupt → Hook → Foreshadow → Agitate → Guide+Plan → Peak → CTA → Won Day
- **Asset-First Production** — recurring elements (2+ scenes) auto-detected and generated as standalone assets before scene keyframes, with dependency graph and tier system
- **Film Directing Guide** — 180° rule, gaze direction, actor blocking, vocal performance direction, natural acting methodology, visual continuity supervision
- **Reference Image Validation Gate** — Phase 3.5 hard block with 5 ref categories, cultural location research (5 facts per location), batch NB2 prompt generation for missing refs
- **23 Reference Documents** — storytelling psychology, cinematography lookup, hook vault (100 hooks), CTA frameworks, directing grammar, platform adaptation, and more
- **Scene Auto-Calculation** — optimal scene count from script beats with VEO mode mapping
- **Extension Strategy** — same-scene continuity via VEO Extend (up to ~148s chains)
- **"Last Frame Secret"** — seamless scene transitions by feeding Clip A's final frame into Clip B's NB2 start frame
- **Cross-File Validation** — consistency checker across all 23 reference files

## Storytelling Philosophy

> Product is NEVER the hero. Product is the BRIDGE. Customer is the hero. Brand is the guide.

The script engine enforces 8 commandments (no opening with brand name, no jargon without translation, every feature needs a human consequence, etc.) and auto-checks for 22 structural failure patterns.

## Project Structure

```
.claude-plugin/plugin.json          # Plugin metadata
hooks/                              # Session start hook
skills/
  promo-engine/SKILL.md             # Main skill — end-to-end pipeline
  promo-validate/SKILL.md           # Cross-file consistency checker
  promo-add-platform/SKILL.md       # Scaffold new video platform
agents/
  promo-engine-agent.md             # Subagent for batch/complex work
reference/
  global-promo-config.md            # Single source of truth for all settings
  creator-profile-system.md         # Creator/brand profile setup
  script-to-scene-bridge.md         # Script → scene → prompts bridge
  storytelling_script_gen/           # 12 storytelling & script reference files
  image-video-gen/                  # 8 image & video production reference files
```

## Configuration

All configurable values live in `reference/global-promo-config.md` — the single source of truth. Settings include default language, video/image resolution, film stock, color temperature, NB2 parameters, VEO duration, output mode, and creator preset.

## Contributing

1. **Change a setting** — edit `reference/global-promo-config.md` only
2. **Add a reference file** — create in `reference/`, update SKILL.md + agent + CLAUDE.md, run `/promo-validate`
3. **Add a video platform** — run `/promo-add-platform` to scaffold everything

## License

[MIT](LICENSE)

## Author

**Ali Sadikin** — [GitHub](https://github.com/alisadikin)
