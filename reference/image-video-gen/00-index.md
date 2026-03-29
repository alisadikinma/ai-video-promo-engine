---
source: Consolidated from 10 project knowledge files
curated: 2026-03-19
version: 2.0
tokens: ~200
platform: claude-projects
---

# AI Video Production — Knowledge Index

## Production Stack
- **Image Model:** Nano Banana 2 (Gemini 3.1 Flash Image) — all start/end frames
- **Video Model (Primary):** Google VEO 3.1 — temporal animation, audio, lip sync
- **Video Model (Alt):** Bytedance Seedance 2.0 — native 2K, dual-branch AV, @ reference system
- **Pipeline (VEO):** NB2 image → VEO First+Last Frame → VEO Extend (same scene)
- **Pipeline (Seedance):** NB2 image → Seedance @Image refs + Omni mode → Seedance @Video extend

## File Map

| File | Content | Read When |
|------|---------|-----------|
| `01-nb2-image-generation.md` | NB2 params, resolution, color, text, identity lock | Generating any image asset |
| `02-veo-production-guide.md` | VEO 3.1 specs, motion library, lip sync, audio, extend | Creating video from images |
| `03-workflow-pipeline.md` | NB2→VEO handoff, decision tree, extend vs keyframe | Planning production sequence |
| `04-cinematography-lookup.md` | Lighting, camera, lens, film stocks, emotion mapping, atmosphere | Crafting any visual prompt |
| `05-creator-and-holidays.md` | Ali Sadikin profile, holiday palettes, thumbnail templates | Creator content or seasonal campaigns |
| `07-seedance-production-guide.md` | Seedance 2.0 specs, @ reference system, modes, audio, camera, materials | Using Seedance 2.0 as video model |

## Critical Constraints (Always Apply)
- VEO max 8s/clip, 24fps, 720p for extensions, 1080p for final only
- Seedance max 15s/clip, 24-60fps, native 2K, unlimited extension chains (drift ~20th hop)
- NB2 image aspect ratio MUST match video model target ratio — mismatch = edge hallucination
- "Ingredients to Video" and "First+Last Frame" are **mutually exclusive** in VEO
- Seedance: First/Last Frame and Omni are separate modes — use Omni for character consistency
- Audio is NOT optional — VEO: unspecified = random sounds; Seedance: native dual-branch AV
- All dialogue: colon syntax (`says:` not `says ""`)
- Seedance: real face upload BANNED — use AI-generated faces only
- Keep critical action in **central 60%** of frame for cross-platform safety
