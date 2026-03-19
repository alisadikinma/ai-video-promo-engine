# AI Video Promo Engine — Design Specification

**Date:** 2026-03-19
**Status:** Approved & Implemented

## Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Target User | Hybrid (generic + Ali Sadikin preset) | Scalable for agencies, preset for creator's own use |
| Plugin Flow | Full Pipeline (1 skill, 5 phases) | End-to-end with approval gates = quality control |
| Output Format | Both (--quick / --full) | Quick for fast iteration, full for agencies |
| Video Platform | VEO 3.1 only (extensible) | Complete knowledge base, add platforms later |
| Image Model | NB2 (Gemini 3.1 Flash Image) | Fast, cost-effective, full reference available |
| Scene Strategy | Auto-calculate from script beats | No manual scene planning needed |
| Audio Strategy | Full narration + lip sync (presenter) / Voiceover + SFX + music (B-Roll) | Two distinct audio modes per scene type |

## Architecture

```
ai-video-promo-engine/
├── .claude-plugin/plugin.json
├── hooks/hooks.json + session-start.sh
├── skills/
│   ├── promo-engine/SKILL.md        (main pipeline)
│   ├── promo-validate/SKILL.md      (8 consistency checks)
│   └── promo-add-platform/SKILL.md  (platform scaffolding)
├── agents/promo-engine-agent.md     (batch subagent)
├── reference/
│   ├── storytelling_script_gen/     (12 files, existing)
│   ├── image-video-gen/             (7 files, existing)
│   ├── global-promo-config.md       (NEW)
│   ├── creator-profile-system.md    (NEW)
│   └── script-to-scene-bridge.md    (NEW)
├── CLAUDE.md
└── docs/plans/
```

## 5-Phase Pipeline

1. **Brainstorm** → strategic-brief.md
2. **Script** → av-script.md (7-beat arc, A/V table)
3. **Scene Breakdown** → scene-plan.md (auto-calculated)
4. **Image Prompts** → image-prompts.md (NB2 start/end frames)
5. **Video Prompts** → video-prompts.md (VEO 3.1 + extensions)

## Knowledge Base: 22 Reference Files

- 12 storytelling files (audience psychology, narrative arcs, hooks, CTAs, etc.)
- 7 image-video files (NB2 specs, VEO guide, pipeline, cinematography)
- 3 new bridge files (global config, creator profile, script-to-scene)

## Gap Analysis (Resolved)

| Gap | Resolution |
|-----|-----------|
| Script → Scene Bridge | `script-to-scene-bridge.md` — complete decomposition algorithm |
| VEO Mode per Scene | Decision tree in bridge file Section 1 Step 3 |
| Creator Profile Generic | `creator-profile-system.md` — profile collection flow |
| Interactive Skill Flow | AskUserQuestion at every phase in SKILL.md |
| B-Roll Audio | Distinct `Voiceover:` syntax (no lip sync) vs `says:` (lip sync) |
