---
source: Synthesized from PROD_STEP1-3, NB2 docs, VEO guide + gap analysis
curated: 2026-03-19
version: 2.0
tokens: ~1500
platform: claude-projects
---

# Production Pipeline — NB2 → VEO 3.1 Workflow

## Decision Tree: Which VEO Mode?

```
Need to show a CHARACTER consistently across shots?
├── YES → "Ingredients to Video" (1-3 ref images)
│         ⚠️ Cannot use First+Last Frame in same generation
│         ⚠️ Cannot combine with keyframe control
│
└── NO, need controlled TRANSITION between two states?
    ├── YES → Does scene have FACE >30% of frame?
    │         ├── YES → "Single I2V" (start frame only)
    │         │         ⚠️ Safety filter rejects 2 face images
    │         │         Generate START image (NB2) only
    │         │         VEO animates from single frame
    │         │
    │         └── NO → "First + Last Frame" (Keyframe Control)
    │                   Generate START image (NB2) + END image (NB2)
    │                   VEO interpolates the motion between them
    │                   ✅ Safe for: dashboards, products, environments
    │
    └── NO, need to CONTINUE an existing clip?
        └── "Scene Extension" (Extend)
            Source must be VEO-generated, 720p only
            Uses final 1 second as context anchor
```

**Mutual Exclusivity Rule:** Ingredients ≠ First+Last Frame. Pick ONE per generation.

**Safety Filter Rule:** First+Last Frame with 2 photorealistic face images → VEO rejects as "prominent people." Use single I2V (start frame only) for any face-dominant scene.

## Phase 1: NB2 Image Asset Creation

### Pre-Generation Checklist
- [ ] Aspect ratio matches VEO target (16:9 or 9:16)
- [ ] Resolution ≥ 1280×720 (VEO I2V minimum)
- [ ] Thinking Mode = High (for final assets)
- [ ] CFG 5-7, Denoise 0.35-0.45
- [ ] Critical action within central 60% of frame
- [ ] Material shaders defined (glass/metal/skin/textile)

### For First+Last Frame Mode
- [ ] **NO dominant face (>30% frame)** — safety filter rejects 2 face images (use single I2V instead)
- [ ] Start frame and end frame share SAME aspect ratio
- [ ] SAME lighting temperature (Kelvin) in both frames
- [ ] SAME color palette / grading style
- [ ] Character wardrobe identical between frames
- [ ] Camera lens consistent (same focal length)
- [ ] End frame represents plausible physical destination from start

### For Ingredients Mode
- [ ] 1-3 reference images generated in NB2
- [ ] Multiple angles: front, ¾, profile (for face consistency)
- [ ] Neutral diffused lighting on references (clean identity data)
- [ ] Same character description verbatim across all prompts

## Phase 2: VEO Generation

### Image-to-Video Handoff Rules
1. **Describe MOTION only** — VEO sees the image, don't repeat visual details
2. **Specify audio explicitly** — ambient + SFX + dialogue (or "no music")
3. **Include "no subtitles, no audience sounds"** in every prompt
4. **Match camera movement to emotion** (see `04-cinematography-lookup.md`)

### Quality Settings

| Setting | Value |
|---------|-------|
| Quality | "Highest Quality (Experimental Audio)" |
| Resolution | 720p if extending, 1080p if final-only |
| Duration | Match dialogue length (3-6s dialogue sweet spot) |
| Audio | Always enabled for dialogue shots |

## Phase 3: Scene Extension (Same Scene Continuity)

### When to Extend vs New Generation

| Scenario | Method |
|----------|--------|
| Same scene, continue action | Extend |
| Same character, different location | New gen with Ingredients |
| Transition between two distinct states | First+Last Frame |
| Same scene, change camera angle | New gen (extend won't change angle) |

### Extension Chain Pattern
```
Clip 1 (8s, 720p) → Extend → Clip 2 (+7s) → Extend → Clip 3 (+7s) → ...
```

**Critical:** 
- Generate initial clip at **720p** (1080p cannot extend)
- Ensure final 1 second has clear, non-blurry movement
- Hold pose for final 0.5s for stable handoff
- Monitor for clothing/texture drift across iterations
- Resolution lock: same resolution across ALL segments

### The "Last Frame Secret"
For clips that need stitching but aren't direct extensions:
1. Export final frame of Clip A
2. Feed into NB2 as reference for Clip B's start frame
3. This preserves grading, character position, lighting across the cut

## Phase 4: Post-Production

### Upscaling
- 1080p and 4K upscaling available in Flow, Gemini API, Vertex AI
- This is a **post-generation** step, not at generation time
- Upscale AFTER all extensions are complete

### Quality Audit Checklist
- [ ] No identity drift across clips
- [ ] Lighting consistent across all segments
- [ ] Audio seamless at extension joints
- [ ] No edge hallucination from ratio mismatch
- [ ] SynthID watermark present (ethical compliance)
- [ ] No subtitle artifacts from wrong dialogue syntax

## Common Pitfalls & Fixes

| Problem | Cause | Fix |
|---------|-------|-----|
| Edge hallucination | Aspect ratio mismatch NB2↔VEO | Generate natively in target ratio |
| Plastic texture | Over-denoising | Prompt "visible pores", "natural grain", "micro-scratches" |
| Light jumps between clips | Different lighting in start/end frames | Match Kelvin + light direction in both NB2 images |
| Character morph during extend | Weak context in final second | Hold clear pose, avoid blur at clip end |
| Stutter at extension joint | Abrupt motion at clip end | Maintain consistent camera speed through final second |
| Wrong VEO mode selected | Ingredients + Keyframe confusion | They are mutually exclusive — pick one |
| "Prominent people" safety error | First+Last Frame with face >30% | Use single I2V (start frame only) for face-dominant scenes |
| On-screen char lip-syncs VO | `Voiceover:` with face visible | Use `Voice-over narrator, [tone]: text` |
