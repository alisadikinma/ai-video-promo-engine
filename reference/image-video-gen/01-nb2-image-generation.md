---
source: NB2 Technical Standards, Composition, Prompting, Video Workflow (Docs 01-04)
curated: 2026-03-19
version: 2.0
tokens: ~1800
platform: claude-projects
---

# Nano Banana 2 (Gemini 3.1 Flash Image) — Image Generation Reference

## Model Identity

| Model | Designation | Speed | Max Resolution | Use Case |
|-------|------------|-------|----------------|----------|
| Nano Banana 2 | Gemini 3.1 Flash Image | Flash | Native 4K (4096×4096) | Production keyframes, start/end frames |
| Nano Banana Pro | Gemini 3 Pro Image | Production | Native 4K | Maximum fidelity, complex layering |

NB2 = primary image model for this pipeline. NB Pro = fallback for extreme precision only.

## Thinking Mode

Activate reasoning layer for spatial logic, occlusion, refraction before pixel diffusion.

| Level | Use | Time |
|-------|-----|------|
| Minimal | Rapid iteration, aesthetic exploration | 1-3s |
| High | Complex spatial logic, physics, final 4K output | ~60-65s |

Triggers: "calculate light transmission through glass", "subject behind third column from left"
Result: ~35-point quality increase on 100-pt scale. Eliminates spatial hallucinations.

## Core Parameters

| Parameter | Range | Violation Effect |
|-----------|-------|-----------------|
| **CFG Scale** | 5.0–7.0 | >8 = hyper-processed, crushed colors, noise |
| **Denoise/Variation** | 0.35–0.45 | >0.50 = structural hallucination, identity loss |
| **JPEG Quality** | 90–92 | >92 = no perceptual benefit, bloated file |
| **Color Space** | sRGB (web), Adobe RGB (print) | Unmanaged Adobe RGB = dull on web browsers |

## Resolution & Cost

| Tier | Pixels | Tokens | Cost (Standard/Batch) | Use |
|------|--------|--------|-----------------------|-----|
| 1K | 1024² | 560 | $0.067 / $0.034 | Drafts, social thumbnails |
| 2K | 2048² | 1,120 | $0.134 / $0.067 | Web heroes, presentations |
| 4K | 4096² | 2,000 | $0.240 / $0.120 | Print, commercial, video keyframes |

Third-party (LaoZhang AI): ~$0.05 flat any resolution, OpenAI-compatible API.
API = watermark-free. Gemini App = SynthID watermark included.

## Aspect Ratios (14 Native)

| Ratio | Purpose | Video Motion |
|-------|---------|-------------|
| 16:9 | Widescreen standard | Horizontal pans, tracking |
| 9:16 | Mobile-first (TikTok, Reels) | Vertical crane, tall subjects |
| 21:9 | CinemaScope storytelling | Expansive landscapes, negative space |
| 4:1 / 8:1 | Ultra-wide panoramic | Hero headers, matte paintings |
| 1:1 | Square format | Feed posts |

**Auto Mode:** NB2 selects ratio from prompt reasoning.
**Cropping cost:** 16:9 → 9:16 = **68% pixel loss**. Generate natively instead.
**60% Rule:** Keep critical action in central 60% for cross-platform safety.

## Identity Lock System

Track up to **5 characters + 14 objects** per workflow.

**Workflow:**
1. Generate high-res "Hero Shot" (neutral lighting)
2. Create reference sheet: front, profile, ¾ view
3. Upload: 4 person refs + 10 object refs to API/AI Studio
4. Inject via `@identity` tag: "Place @character1 in rainy Shibuya street"
5. Quality audit via multi-turn: "Keep facial features identical to Image 1"

**CRITICAL — Reference Image Injection Rule:**
All reference images MUST be explicitly embedded in the prompt text, not just uploaded as files. The prompt must tell the model to look at and match the reference:

```
maintain exact facial identity from reference image: cast-c1-face.png
```

Without this injection, the model generates from text description only — causing identity drift. This is especially critical for faces where even slight deviation is immediately noticeable.

Every NB2 prompt MUST also include a **Required Reference Images** table listing all ref files needed for that prompt, so the user never misses uploading a file. See `global-promo-config.md` Section 16 for table format.

## Text Rendering (94.2% Accuracy)

- Exact wording in **quotes**: `"SALE"`
- Font directive: `"bold sans-serif"`, `"modern geometric"`
- Anchor placement: `"centered 40px above the subject"`
- Don't use tag soup → use full-sentence technical instructions

## Prompt Formula

```
Subject/Material + Lighting Architecture + Camera/Lens + Campaign Context
```

**Example:**
"A heavy crystal perfume bottle [Material] on black marble, side-lit by 5500K softbox creating long shadows [Lighting], shot on Hasselblad X2D 85mm f/2.8 [Camera], for luxury fragrance editorial [Context]."

## Material Shaders

| Material | Trigger | Physics |
|----------|---------|---------|
| Glass | "Crystal" + 1.5 refraction index | Light bending, transmission |
| Metal | "Anisotropic reflections" | Directional scatter, normal mapping |
| Skin | "Subsurface scattering, visible pores" | Non-plastic, dewy finish |
| Textiles | "Fabric drape by weight" | Weave-level light interaction |
| Plastic | "Specular highlights" | Hard mirror reflections |

## Multi-Turn Refinement (Not Prompt Roulette)

1. **Brief/Ratio Lock** — set native aspect ratio
2. **Low-Thinking 1K Draft** — composition check
3. **Semantic Masking** — "Make text neon", "Increase shadow depth"
4. **Promote to High-Thinking 4K** — final production asset
5. **Localization** — re-prompt same ad into 10+ languages, pixel-perfect
