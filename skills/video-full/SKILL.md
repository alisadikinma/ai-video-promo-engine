---
name: video-full
description: >
  End-to-end AI video promotional production pipeline. Orchestrates the full 6-phase workflow:
  video-brainstorm (Phase 1) → video-script (Phase 2-3.5) → video-image (Phase 4A+4B) →
  video-gen (Phase 5 with Image Review). Generates complete 2-3 minute promotional video
  packages for any brand. Supports multi-character cast (max 5), any brand or Ali Sadikin preset.
  Triggers on: video full, full pipeline, end to end, video production, bikin video promosi,
  buat video lengkap, video marketing, iklan video, video agency, generate video complete,
  promotional video, product video, video promo, create promo.
---

# Video Full — End-to-End Promotional Video Pipeline

## Overview

Orchestrator skill that runs the complete 6-phase video production pipeline by invoking 4 specialized skills in sequence. Each skill handles its own context loading, reference files, and approval gates. This skill delegates entirely — it carries no generation logic of its own.

**Output:** Complete production package (8 files) for a 2-3 minute promotional video.

## Reference Files

Read FIRST: `reference/global-promo-config.md` — single source of truth for all configurable values.

Phase-specific references are loaded by each sub-skill automatically. See individual skill files for details.

## Flags

| Flag | Description |
|------|-------------|
| `--full` (default) | Full production plan: cast-profile, ref-manifest, scene breakdown, storyboard notes, NB2 prompts, VEO prompts, audio specs, extension strategy, post-production checklist |
| `--quick` | Copy-paste ready prompts only: NB2 + VEO per scene, no production plan |
| `--preset ali` | Use Ali Sadikin creator preset instead of generic brand profile |

## Workflow

### Step 1: Run `/video-brainstorm` (Phase 1)

Invoke the video-brainstorm skill for:
- Language selection (Bahasa Indonesia / English / Bilingual)
- Cast builder (1-5 characters, Pemeran Utama/Pendamping)
- Product/service discovery
- Institution detection + costume confirmation
- Location & setting context
- Domain Deep Research (6 location-aware WebSearch queries)
- Target market, awareness level, platform selection
- Emotional core discovery
- Storyline input + 7-beat arc mapping
- Tone/mood selection

**Wait for Phase 1 approval gate.**

**Verify output exists:**
- `{output_folder}/strategic-brief.md`
- `{output_folder}/cast-profile.md`

---

### Step 2: Run `/video-script` (Phase 2, 3, 3.5)

Invoke the video-script skill for:
- A/V script generation with 7-beat narrative arc
- Scene breakdown with VEO mode mapping
- Reference image collection (HARD BLOCK gate)
- Cultural location research
- Batch NB2 prompts for missing references

**Wait for Phase 2, 3, and 3.5 approval gates.**

**Verify output exists:**
- `{output_folder}/av-script.md`
- `{output_folder}/scene-plan.md`
- `{output_folder}/ref-manifest.md`

---

### Step 3: Run `/video-image` (Phase 4A, 4B)

Invoke the video-image skill for:
- Asset Library generation (Phase 4A) — standalone reusable assets with dependency graph
- Scene Keyframe generation (Phase 4B) — start/end frames composed from assets
- Batch-by-ACT with prompt-reviewer agent validation

**Wait for Phase 4A and 4B approval gates.**

**Verify output exists:**
- `{output_folder}/nb2-reference-prompts.md`
- `{output_folder}/image-prompts.md`

**User generates keyframe images from NB2 prompts and saves to `{output_folder}/keyframes/`.**

---

### Step 4: Run `/video-gen` (Phase 5 with Image Review)

Invoke the video-gen skill for:
- Image Review (Step 0) — per-scene collaborative review of actual keyframe images
- VEO 3.1 video prompt generation with camera movement, 3-layer audio, lip sync
- Batch-by-ACT with prompt-reviewer agent validation

**Wait for Image Review and Phase 5 approval gates.**

**Verify output exists:**
- `{output_folder}/video-prompts.md`

---

### Step 5: Production Summary

Present final production package:

```
## Production Package Complete

**Output folder:** {output_folder}/

| File | Content | Skill |
|------|---------|-------|
| strategic-brief.md | Strategic planning, domain knowledge, cultural context | /video-brainstorm |
| cast-profile.md | Character profiles, costume details, identity lock refs | /video-brainstorm |
| av-script.md | A/V script with 7-beat arc, narration, audio direction | /video-script |
| scene-plan.md | Scene breakdown, VEO modes, durations, extension strategy | /video-script |
| ref-manifest.md | Reference image manifest (validated 100%) | /video-script |
| nb2-reference-prompts.md | Asset library NB2 prompts (tiered) | /video-image |
| image-prompts.md | Scene keyframe NB2 prompts (start + end frames) | /video-image |
| video-prompts.md | VEO 3.1 video prompts with audio specs | /video-gen |

**Total scenes:** {N}
**Total VEO clips:** {M} (generations + extensions)
**Estimated total duration:** {X}s
```

## Hard Rules

All hard rules from individual skills apply. Key cross-cutting rules:

1. **NEVER skip a phase** — all phases must execute in order
2. **NEVER proceed without user approval** — every phase ends with approval gate
3. **Phase 3.5 is HARD BLOCK** — cannot proceed to Phase 4 without ALL refs validated
4. **Asset-first, scene-second** — Phase 4A atoms before Phase 4B molecules
5. **Image Review before VEO** — Phase 5 Step 0 reviews actual images before generating video prompts
6. **Audio is NEVER optional** — all 3 layers specified in every VEO prompt
7. **Product is NEVER the hero** — customer is hero, product is bridge

See individual skill files for complete hard rules per phase.
