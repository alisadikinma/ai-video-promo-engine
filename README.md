# AI Video Promo Engine

Claude Code plugin that generates complete promotional video production packages — from brainstorm to script to image prompts (NB2) to video prompts (VEO 3.1).

Anyone — video agencies, freelancers, brand owners — can produce professional 2-3 minute promotional videos by following the generated production plan.

## What It Does

Give it a product or service, and the engine walks you through a 5-phase pipeline:

1. **Brainstorm** — interactive discovery: target market, awareness level, emotional transformation
2. **Script** — 2-3 min A/V script with 7-beat narrative arc, beat labels, timing, narration, audio direction
3. **Scene Breakdown** — auto-calculated scene count, VEO mode per scene, extension strategy
4. **Image Prompts (NB2)** — start/end frames, ingredient images, creator face & product references
5. **Video Prompts (VEO 3.1)** — per-scene prompts with camera movement, 3-layer audio, lip sync, extensions

Each phase has a user approval gate before proceeding to the next.

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

- **5 Target Markets** — C-Level, VP/Director, Manager, Individual Contributor, Social Media — each with adapted tone, depth, and CTA style
- **5 Awareness Levels** — Unaware → Most-Aware routing to different narrative strategies
- **7-Beat Universal Arc** — Pattern Interrupt → Hook → Foreshadow → Agitate → Guide+Plan → Peak → CTA → Won Day
- **22 Reference Documents** — storytelling psychology, cinematography lookup, hook vault (100 hooks), CTA frameworks, platform adaptation, and more
- **Creator Profile System** — generic mode for any brand + preset support
- **Scene Auto-Calculation** — optimal scene count from script beats with VEO mode mapping
- **Extension Strategy** — same-scene continuity via VEO Extend (up to ~148s chains)
- **"Last Frame Secret"** — seamless scene transitions by feeding Clip A's final frame into Clip B's NB2 start frame
- **Cross-File Validation** — consistency checker across all reference files

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
  image-video-gen/                  # 7 image & video production reference files
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
