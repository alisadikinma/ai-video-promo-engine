# Plugin Restructure Design — video-* Naming + Skill Split + Image Review

**Date:** 2026-03-29
**Status:** Approved

## Problem Statement

1. **Naming confusion**: Plugin is `ai-video-promo-engine` but skills use `promo-*` prefix — hard to discover via autocomplete
2. **Monolithic skill**: Single `promo-engine` SKILL.md (~1350 lines) handles all 6 phases — too much context loaded at once
3. **Image→Video handoff gap**: Phase 5 reads NB2 text prompts but not actual generated images. User manually edits images, but VEO prompts don't reflect edits.

## Decisions

### Skill Structure (7 skills)

| # | Skill | Purpose | Phases |
|---|-------|---------|--------|
| 1 | `/video-brainstorm` | Brainstorm, cast, product, location, domain research | Phase 1 |
| 2 | `/video-script` | Script, scene breakdown, reference collection | Phase 2, 3, 3.5 |
| 3 | `/video-image` | NB2 asset library + scene keyframes | Phase 4A, 4B |
| 4 | `/video-gen` | VEO video prompts (with Image Review step) | Phase 5 |
| 5 | `/video-full` | Orchestrator — runs 1→2→3→4 in sequence | All |
| 6 | `/video-validate` | Unified validator: `--script` / `--image` / `--video` / `--refs` / `--all` | Utility |
| 7 | `/video-add-platform` | Scaffold new video platform | Utility |

### Agent Renaming

| Old | New |
|-----|-----|
| `promo-engine-agent.md` | `video-engine-agent.md` |
| `prompt-reviewer-agent.md` | `video-prompt-reviewer.md` |

### New Feature: Image Review Step (`/video-gen` Step 0) — Per-Scene Collaborative

```
Step 0: IMAGE REVIEW — Per-Scene Validation & Brainstorm

FOR each scene in current batch:

  Step 0.1: VISUAL ANALYSIS
  - READ start/end keyframe .png (multimodal)
  - Load NB2 prompt text + scene-plan + av-script for this scene

  Step 0.2: AI OBSERVATION REPORT
  - AI describes what it SEES in the actual image
  - Notes differences from original NB2 prompt
  - States scene intent from script
  - Suggests VEO approach (camera, emphasis, transition, audio)

  Step 0.3: USER BRAINSTORM
  - AskUserQuestion per scene:
    A) Setuju, lanjut
    B) Ada arahan tambahan
    C) Image perlu re-generate, skip

  Step 0.4: SAVE SCENE CONTEXT
  - Actual image description (not original prompt)
  - User notes/direction
  - Agreed VEO approach

END FOR

VEO generation uses ACTUAL IMAGE DESCRIPTIONS + user notes,
not original NB2 prompt text.
```

### Unified Validator (`/video-validate`)

| Flag | Validates | Input |
|------|-----------|-------|
| `--script` | Script rules (7-beat arc, forbidden words, etc.) | av-script.md |
| `--image` | NB2 prompt rules + actual image visual check | image-prompts.md + keyframes/*.png |
| `--video` | VEO prompt rules (audio, safety, modes, etc.) | video-prompts.md |
| `--refs` | Cross-file reference consistency (23+ files) | reference/*.md + SKILL.md + CLAUDE.md |
| `--all` | Everything above | All files |

### Output per Skill

| Skill | Output Files |
|-------|-------------|
| video-brainstorm | strategic-brief.md, cast-profile.md |
| video-script | av-script.md, scene-plan.md, ref-manifest.md |
| video-image | nb2-reference-prompts.md, image-prompts.md |
| video-gen | video-prompts.md |
| video-full | All of the above |

### Data Integration Map

| Skill | Reads (Input) | Writes (Output) | Shared State |
|-------|--------------|-----------------|-------------|
| video-brainstorm | global-promo-config, creator-profile-system, F1, F8 | strategic-brief.md, cast-profile.md | Used by all downstream |
| video-script | strategic-brief, cast-profile, 10+ storytelling refs | av-script.md, scene-plan.md, ref-manifest.md | Used by image & gen |
| video-image | scene-plan, cast-profile, NB2 refs, ref/ folder | nb2-reference-prompts.md, image-prompts.md, keyframes/*.png | Used by gen |
| video-gen | scene-plan, cast-profile, image-prompts, keyframes/*.png | video-prompts.md | Final output |
| video-full | None directly — delegates to 4 skills | All outputs | Orchestrator only |
| video-validate | All output files + reference files + keyframes/ | Validation report | Read-only |

### Files Changed

| File | Action |
|------|--------|
| `skills/promo-engine/SKILL.md` | DELETE (split into 4 new skills) |
| `skills/video-brainstorm/SKILL.md` | CREATE — Phase 1 from old promo-engine |
| `skills/video-script/SKILL.md` | CREATE — Phase 2+3+3.5 from old promo-engine |
| `skills/video-image/SKILL.md` | CREATE — Phase 4A+4B from old promo-engine |
| `skills/video-gen/SKILL.md` | CREATE — Phase 5 + new Image Review step |
| `skills/video-full/SKILL.md` | CREATE — orchestrator |
| `skills/promo-validate/` | RENAME → `skills/video-validate/` (+ rewrite for unified validator) |
| `skills/promo-add-platform/` | RENAME → `skills/video-add-platform/` |
| `agents/promo-engine-agent.md` | RENAME → `agents/video-engine-agent.md` + update content |
| `agents/prompt-reviewer-agent.md` | RENAME → `agents/video-prompt-reviewer.md` + update content |
| `.claude-plugin/plugin.json` | UPDATE version |
| `hooks/session-start.sh` | UPDATE skill/agent names |
| `CLAUDE.md` | UPDATE all references |
| `README.md` | UPDATE |
