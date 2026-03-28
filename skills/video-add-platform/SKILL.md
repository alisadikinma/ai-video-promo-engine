---
name: video-add-platform
description: >
  Scaffold all files needed to add a new AI video platform to the video promo engine.
  Creates platform guide in reference/, updates cross-references in SKILL.md, agent,
  CLAUDE.md, and global-promo-config.md. Then runs validation.
  Triggers on: add platform, new platform, tambah platform, scaffold platform,
  video add platform, video platform baru.
---

# Add Video Platform

Scaffold all files needed to support a new AI video generation platform alongside VEO 3.1.

## When to Use

When user wants to add support for a new video AI platform (e.g., Sora 2, Grok 3, Kling 3.0, Seedance 2.0, Meta AI).

## Workflow

### Step 1: Collect Platform Info

```
AskUserQuestion:
"Platform video AI apa yang ingin ditambahkan?"

Options:
A) Sora 2 (OpenAI)
B) Grok 3 (xAI)
C) Kling 3.0 (Kuaishou)
D) Seedance 2.0 (ByteDance)
E) Other (sebutkan nama + provider)
```

### Step 2: Research Platform Capabilities

Research via web search (if available) or ask user for documentation:
- Max resolution
- Max clip duration
- Supported aspect ratios
- Image-to-video modes (equivalent to Ingredients / Frame / Extend)
- Audio support (dialogue, SFX, ambient)
- Lip sync capability
- API/pricing
- Prompt format and limitations

### Step 3: Create Platform Guide

Create `reference/image-video-gen/{NN}-{platform}-production-guide.md` following the structure of `02-veo-production-guide.md`:

- Core Specs table
- Prompt Formula
- Audio specs
- Camera Movement Library (platform-verified)
- I2V Motion Description
- Lip Sync (if supported)
- Scene Extension (if supported)
- Negative Prompts
- Common Pitfalls & Fixes

### Step 4: Update Cross-References

Update the following files to include the new platform:

1. **`CLAUDE.md`** — Add to Reference Files table, Architecture section
2. **`skills/video-gen/SKILL.md`** — Add to Phase 5 reference table
3. **`agents/video-engine-agent.md`** — Add to reference table
4. **`reference/global-promo-config.md`** — Add platform to routing table
5. **`reference/image-video-gen/00-index.md`** — Add to production stack
6. **`reference/script-to-scene-bridge.md`** — Add platform-specific templates

### Step 5: Run Validation

Run `/video-validate --refs` to verify cross-file consistency after adding the new platform.

### Step 6: Summary

Report what was created and updated:
- New file: `reference/image-video-gen/{NN}-{platform}-production-guide.md`
- Updated: list of modified files
- Validation result: PASS/FAIL
