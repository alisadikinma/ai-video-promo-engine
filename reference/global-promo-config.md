# Global Promo Config — Single Source of Truth

All configurable values for the AI Video Promo Engine. Edit THIS file to change defaults — all skills and agents reference this file.

---

## 1. Language

| Setting | Value | Notes |
|---------|-------|-------|
| `narration_language` | Per user selection (Step 1.0) | Bahasa Indonesia / English / Bilingual |
| `prompt_language` | `English` | NB2/VEO prompts always in English (technical requirement) |
| `technical_terms` | `English` | Keep technical terms in English regardless of narration language |
| `script_language` | Follows `narration_language` | Script narration/dialogue in user's chosen language |

### Language Options (Step 1.0)

| Option | Narration | Dialogue (`says:`) | VEO/NB2 Prompt | Strategic Brief |
|--------|-----------|-------------------|----------------|-----------------|
| Bahasa Indonesia | Indonesian | Indonesian | English | Indonesian |
| English | English | English | English | English |
| Bilingual | Indonesian (primary) | Indonesian + English tech terms | English | Indonesian |

---

## 2. Video Defaults

| Setting | Value | Notes |
|---------|-------|-------|
| `video_aspect_ratio` | `16:9` | For YouTube/LinkedIn. Switch to `9:16` for TikTok/Reels |
| `video_resolution` | `720p` | Default 720p for extendable clips. 1080p only for final non-extendable |
| `video_duration` | `120-180s` | Target 2-3 minutes |
| `veo_clip_duration` | `8s` | Maximum per VEO generation |
| `veo_extend_duration` | `7s` | Per extension hop |
| `veo_max_extensions` | `20` | ~148s total possible |
| `veo_audio_quality` | `Highest Quality (Experimental Audio)` | Always use highest |
| `veo_negative_prompt` | `No subtitles, no text overlays, no watermarks, no blurry faces, no distorted hands, no cartoon effects, no audience sounds, no laugh track.` | Standard block |
| `frame_rate` | `24fps` | Fixed by VEO |

---

## 3. Image Defaults

| Setting | Value | Notes |
|---------|-------|-------|
| `image_model` | `Nano Banana 2` (Gemini 3.1 Flash Image) | Primary image model |
| `image_resolution` | `4K` (4096×4096) | For final keyframes |
| `image_resolution_draft` | `1K` (1024×1024) | For rapid iteration |
| `nb2_cfg` | `5.0–7.0` | >8 = hyper-processed |
| `nb2_denoise` | `0.35–0.45` | >0.50 = structural hallucination |
| `nb2_thinking_draft` | `Minimal` | 1-3s, for composition check |
| `nb2_thinking_final` | `High` | ~60s, for final 4K assets |
| `nb2_jpeg_quality` | `90–92` | >92 = no benefit |
| `color_space` | `sRGB` | For web/social delivery |

---

## 4. Cinematography Defaults

| Setting | Value |
|---------|-------|
| `film_stock` | `Kodak Vision3 500T` |
| `color_temp` | `3200K` (warm tungsten) |
| `color_grade` | `Teal & Orange` (Hollywood blockbuster) |
| `default_lighting_ratio` | `4:1` (cinematic contrast) |
| `atmosphere` | `Light haze` |

---

## 5. Audio Defaults

| Setting | Value | Notes |
|---------|-------|-------|
| `dialogue_syntax` | `[Character] says: text` | NEVER quotation marks |
| `voiceover_syntax` | `Voiceover: text` | For B-Roll (no lip sync) |
| `sfx_syntax` | `SFX: description` | Sound effects |
| `ambient_syntax` | `Ambient: description` | Background atmosphere |
| `dialogue_max_words` | `8-15` per 8s clip | 3-6s sweet spot |
| `dialogue_max_syllables` | `20-25` per 8s clip | |
| `face_min_frame_pct` | `30%` | Minimum for lip sync |
| `always_add` | `no subtitles, no audience sounds, no text overlays` | Every VEO prompt |

---

## 6. Output Defaults

| Setting | Value | Notes |
|---------|-------|-------|
| `output_mode` | `full` | `full` = production plan, `quick` = copy-paste prompts |
| `output_folder` | `{project-folder}/output/` | All output files saved here |
| `strategic_brief_file` | `strategic-brief.md` | Phase 1 output |
| `script_file` | `av-script.md` | Phase 2 output |
| `scene_plan_file` | `scene-plan.md` | Phase 3 output |
| `image_prompts_file` | `image-prompts.md` | Phase 4 output |
| `video_prompts_file` | `video-prompts.md` | Phase 5 output |

---

## 7. Cast System

| Setting | Value | Notes |
|---------|-------|-------|
| `max_cast` | `5` | Max characters total (matches NB2 identity lock limit) |
| `max_pemeran_utama` | `3` | Max main characters |
| `max_pemeran_pendamping` | `2` | Max supporting characters |
| `cast_profile_file` | `cast-profile.md` | In `{project}/` folder (replaces creator-profile.md) |
| `cast_ref_folder` | `ref/` | Reference images folder |
| `ali_preset_available` | `true` | Ali Sadikin preset can fill 1 cast slot |

### Cast Reference Requirements

| Role | Face Ref | Body Ref | Costume Ref | Identity Lock |
|------|----------|----------|-------------|---------------|
| Pemeran Utama | MANDATORY | MANDATORY | MANDATORY (if institutional) | FULL |
| Pemeran Pendamping | MANDATORY | OPTIONAL | OPTIONAL | PARTIAL |

---

## 8. Platform Routing

| Platform | Aspect | Duration | Notes |
|----------|--------|----------|-------|
| YouTube | 16:9 | 2-3 min | Primary target |
| LinkedIn | 16:9 | 1-2 min | Shorter, professional |
| Instagram Reels | 9:16 | 60-90s | Vertical, fast cuts |
| TikTok | 9:16 | 60-90s | Vertical, pattern interrupts |
| Twitter/X | 16:9 | 30-60s | Shortest, punchy |

---

## 9. Prompt Length Guidelines

| Context | Word Count | Notes |
|---------|-----------|-------|
| NB2 image prompt | 80-200 words | Up to 250 for complex scenes |
| VEO video prompt | 100-150 words | 1,024 token max |
| VEO extension prompt | 50-80 words | Reference previous clip context |

---

## 10. Version

| Setting | Value |
|---------|-------|
| `config_version` | `1.2.0` |
| `last_updated` | `2026-03-19` |

---

## 11. Reference Manifest

| Setting | Value | Notes |
|---------|-------|-------|
| `ref_manifest_file` | `ref-manifest.md` | In `{project}/output/` folder |
| `ref_validation_mode` | `hard_block` | Cannot proceed to Phase 4 without 100% refs |

### Naming Conventions

| Category | Pattern | Example |
|----------|---------|---------|
| Cast face | `ref/cast-c{N}-face.png` | `ref/cast-c1-face.png` |
| Cast body | `ref/cast-c{N}-body.png` | `ref/cast-c1-body.png` |
| Cast costume | `ref/cast-c{N}-costume.png` | `ref/cast-c1-costume.png` |
| Product | `ref/product-{name}.png` | `ref/product-hero.png` |
| Environment | `ref/env-{location}.png` | `ref/env-pelabuhan.png` |
| Brand asset | `ref/brand-{asset}.png` | `ref/brand-logo.png` |
| Institutional uniform | `ref/costume-{institution}.png` | `ref/costume-kai.png` |

### Reference Categories (All 5 Hard Block)

| # | Category | Required When |
|---|----------|---------------|
| 1 | Character (cast) | Any scene with character |
| 2 | Product | Any scene showing product |
| 3 | Environment | Any B-Roll or location-specific scene |
| 4 | Brand Assets | Any scene with visible logo/UI/brand |
| 5 | Costume/Uniform | When institution detected |

---

## 12. Institution Detection

| Institution Keyword | Uniform Type | Example Roles |
|---------------------|-------------|---------------|
| KAI / Kereta Api | Railway uniform | Masinis, petugas stasiun, kondektur |
| Pelindo / Pelabuhan | Port authority uniform | Petugas pelabuhan, operator crane |
| BRI / BNI / BCA / Mandiri | Banking uniform | Teller, CS, manager cabang |
| Pertamina | Energy sector uniform | Operator SPBU, engineer |
| PLN | Electricity utility uniform | Teknisi, petugas meter |
| Telkom / Telkomsel | Telecom uniform | Teknisi, CS |
| Garuda Indonesia | Airline uniform | Pilot, pramugari, ground crew |
| RS / Rumah Sakit | Medical uniform | Dokter, perawat, apoteker |
| TNI / Polri | Military/police uniform | Prajurit, polisi |
| Pos Indonesia | Postal uniform | Petugas pos, kurir |
| Damri | Bus transit uniform | Sopir, kondektur |
| BUMN (generic) | Corporate uniform | Per institution |

**Detection Logic:**
1. Scan brand_name + product description for keywords above
2. If match → AskUserQuestion to confirm: "Terdeteksi produk untuk {institution}. Pakai seragam?"
3. If confirmed → ALL cast in relevant scenes MUST have costume ref
4. If no match → skip costume category (unless user manually adds)

---

## 13. Tone/Mood System

| Tone | Keyword | Description |
|------|---------|-------------|
| `humorous` | Humorous / Playful | Ringan, ada jokes, approachable |
| `serious` | Serious / Dramatic | Berat, impactful, emosional |
| `professional` | Professional / Corporate | Formal, data-driven, polished |
| `inspirational` | Inspirational / Motivational | Uplifting, empowering |
| `casual` | Casual / Friendly | Santai, conversational, relatable |
| `edgy` | Edgy / Bold | Provocative, disruptive, berani |

### Tone Impact Matrix

| Phase | Humorous | Serious | Professional | Inspirational | Casual | Edgy |
|-------|----------|---------|-------------|---------------|--------|------|
| Script word choice | Witty, puns, wordplay | Weighty, stark | Precise, data-backed | Uplifting, aspirational | Conversational, slang OK | Provocative, confrontational |
| Hook style (F5) | Unexpected twist | Shocking stat/fact | Authority/credibility | Visionary question | Relatable complaint | Controversial statement |
| Lighting ratio | 2:1 (bright, flat) | 4:1+ (dramatic) | 2:1 (clean, even) | 3:1 (warm) | 2:1 (natural) | 6:1+ (harsh contrast) |
| Camera style | Wider shots, movement | Tight CU, slow | Steady, precise | Sweeping, grand | Handheld feel | Dutch angles, fast |
| Music | Upbeat, quirky | Orchestral, minimal | Corporate ambient | Swelling, emotional | Acoustic, chill | Electronic, aggressive |
| SFX | Comic timing, playful | Impact hits, silence | Subtle, clean | Swells, risers | Natural, minimal | Glitch, distortion |
| Expression (NB2) | Warm smile, playful | Stern, determined | Confident, neutral | Hopeful, inspired | Relaxed, friendly | Intense, challenging |
| Atmosphere (VEO) | Lighthearted, bright | Tense, dramatic | Clean, polished | Warm, golden | Natural, relaxed | Gritty, raw |

---

## 14. Cultural Location Research

### Essential Facts Checklist (5 per location)

| # | Fact | Example (Dumai) | Injection Point |
|---|------|-----------------|-----------------|
| 1 | Plat kendaraan | BM (Bengkalis/Dumai region) | NB2 environment prompts, VEO background |
| 2 | Etnis dominan & ciri fisik | Melayu Riau — kulit sawo matang, rambut hitam | NB2 character prompts (extras), cast-profile guidance |
| 3 | Landmark ikonik | Pelabuhan Dumai, Kilang Pertamina, Tugu Ikan Terubuk | NB2 establishing shots, VEO B-Roll |
| 4 | Arsitektur lokal | Rumah Melayu, atap lipat kajang, ornamen ukiran | NB2 environment detail, set design |
| 5 | Cuaca/musim khas | Tropis lembab, 26-33°C, musim kabut asap (Jul-Sep) | VEO atmosphere, NB2 sky/lighting |

### Search Strategy

| Query | Purpose |
|-------|---------|
| `{location} Indonesia kota karakteristik budaya` | General cultural overview |
| `{location} plat nomor kendaraan kode` | License plate code |
| `{location} arsitektur tradisional landmark` | Architecture and landmarks |

### Cultural Context Output Template

Save to `strategic-brief.md` > Cultural Context section:

| Fact | Detail | Source |
|------|--------|--------|
| Plat Kendaraan | {code} ({region}) | Web search |
| Etnis Dominan | {ethnicity} — {physical features} | Web search |
| Landmark | {list} | Web search |
| Arsitektur | {style} | Web search |
| Cuaca | {climate} | Web search |

---

## 15. Ref Image Prompt Generation

### NB2 Defaults for Reference Images (vs Scene Images)

| Setting | Ref Image | Scene Image | Notes |
|---------|-----------|-------------|-------|
| Background | Clean studio white / neutral | Scene-specific environment | Ref images need clean bg for identity lock |
| Lighting | Neutral diffused | Cinematic per mood | Ref images need even lighting for AI to extract features |
| Resolution | 4K | 4K (final) / 1K (draft) | Ref images always high-res |
| Thinking mode | High | Per stage | Ref images need max quality |
| CFG | 6.0 | 5.0-7.0 | Middle-range for ref reliability |
| Denoise | 0.40 | 0.35-0.45 | Balanced for ref clarity |

### Prompt Strategy per Category

| Category | Key Elements | Cannot Generate (user must provide) |
|----------|-------------|--------------------------------------|
| Cast face | Front view, ethnicity, age, features, neutral expression | — |
| Cast body | Standing pose, full wardrobe visible, neutral bg | — |
| Cast costume | Front view, institution-specific, emblem/badge detail | Actual institution logo/badge (describe instead) |
| Product | Hero angle, commercial lighting, clean bg | Real product photo if physical product |
| Environment | Wide establishing shot, cultural details, time of day | — |
| Brand logo | N/A | MUST be provided by user (AI cannot reliably generate logos) |

---

## 16. Reference Image Injection Rules

### CRITICAL: All reference images MUST be embedded directly in prompts

Reference images are NOT just files to upload — they MUST be explicitly referenced inside the NB2/VEO prompt text using character reference syntax. Without explicit injection, AI models will NOT maintain identity consistency.

### Injection Syntax

| Category | Injection Phrase (embed in prompt) |
|----------|-----------------------------------|
| Cast face | `maintain exact facial identity from reference image: ref/cast-c{N}-face.png` |
| Cast body | `maintain exact body proportions and build from reference image: ref/cast-c{N}-body.png` |
| Cast costume | `wearing exact uniform/costume as shown in reference image: ref/cast-c{N}-costume.png` |
| Product | `match exact product appearance from reference image: ref/product-{name}.png` |
| Environment | `match environment and architectural style from reference image: ref/env-{location}.png` |
| Brand asset | `use exact brand asset from reference image: ref/brand-{asset}.png` |
| Institution uniform | `match exact institutional uniform from reference image: ref/costume-{institution}.png` |

### Reference Image Table (MANDATORY per prompt)

Every generated NB2 or VEO prompt MUST include a **Required Reference Images** table listing all ref files needed for that specific prompt. This ensures the user uploads every required file before generating.

**Format:**

```markdown
#### Required Reference Images for Scene {N}

| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | `ref/cast-c1-face.png` | {Character 1 name} face — front view | ⬜ |
| 2 | `ref/cast-c1-body.png` | {Character 1 name} full body | ⬜ |
| 3 | `ref/product-{name}.png` | Product hero shot | ⬜ |
| 4 | `ref/env-{location}.png` | Environment establishing shot | ⬜ |
```

### Why This Matters

- Without explicit reference injection, AI generates from text description only → identity drift
- Face identity is the MOST critical — even slight deviation is immediately noticeable
- The reference image table per prompt prevents users from missing uploads
- Character reference concept = the model actively looks at and matches the ref image

---

## 17. Reference Image Dependency Graph & Generation Order

Reference images have dependencies — generating them in the wrong order causes identity drift because downstream refs can't lock onto upstream refs that don't exist yet.

### Dependency Graph

```
Tier 0: USER-PROVIDED (cannot AI-generate)
├── ref/brand-{name}.png           ← user uploads logo file
└── Cultural research data         ← web search (Step 3.5.2a), needed before environment

Tier 1: FOUNDATION (no ref image dependencies — parallel-safe)
├── ref/cast-c{N}-face.png        ← THE identity anchor, generated FIRST
├── ref/product-{name}.png        ← independent, no character dependency
└── ref/env-{location}.png        ← depends on cultural research data, NOT on other refs

Tier 2: IDENTITY-LOCKED (depends on Tier 1 face)
├── ref/cast-c{N}-body.png        ← MUST inject face ref for identity lock
└── ref/costume-{institution}.png ← master uniform template (standalone)

Tier 3: COMPOSITE (depends on Tier 1 face + Tier 2 body)
└── ref/cast-c{N}-costume.png     ← MUST inject face + body ref for identity lock

Tier 4: SCENE IMAGES (depends on ALL above)
├── NB2 start/end frames          ← uses face, body, costume, product, env refs
└── NB2 ingredient refs           ← uses face, body refs
```

### Generation Order (MANDATORY)

Engine MUST generate reference images in this exact order. Within each tier, items can be generated in parallel.

| Order | Tier | What to Generate | Dependencies | Parallel? |
|-------|------|-----------------|--------------|-----------|
| 0 | Pre-req | User uploads brand logo + cultural research completes | None | — |
| 1 | Tier 1 | All cast face refs + product refs + environment refs | Cultural data for env only | ✅ Yes, all Tier 1 parallel |
| 2 | Tier 2 | All cast body refs | Each body injects its own face ref | ✅ Yes, all Tier 2 parallel |
| 3 | Tier 3 | All cast costume refs | Each costume injects face + body ref | ✅ Yes, all Tier 3 parallel |
| 4 | Tier 4 | Scene NB2 images (start/end frames, ingredients) | ALL refs from Tier 0-3 | Per scene |

### Upstream Injection Rules

| Ref Being Generated | MUST Inject These Upstream Refs |
|--------------------|---------------------------------|
| Cast face | None (foundational) |
| Cast body | `maintain exact facial identity from reference image: ref/cast-c{N}-face.png` |
| Cast costume | `maintain exact facial identity from reference image: ref/cast-c{N}-face.png` + `maintain exact body proportions from reference image: ref/cast-c{N}-body.png` |
| Product | None (independent) |
| Environment | None (uses cultural research data, not other refs) |
| Scene NB2 image | ALL relevant refs (face + body + costume + product + env) |

### Why Order Matters

1. **Face first** — face is the identity anchor. Body/costume without face ref = different-looking person
2. **Body before costume** — costume on a body that doesn't match the face ref = inconsistent character
3. **All refs before scenes** — scene images reference ALL upstream refs. Missing any = identity drift in that scene
4. **Parallel within tier** — Character 1 face and Character 2 face have no dependency on each other

### Validation Gate

Before advancing to the next tier:
- Verify ALL images in current tier are generated/uploaded
- Verify identity consistency (face matches across face → body → costume chain)
- If any ref fails quality check, regenerate THAT ref only (don't cascade)

### Example: 2-Character Video (Ali Sadikin + Supporting)

```
Tier 0: User uploads ref/brand-logo.png
        Cultural research: Dumai → plat BM, Melayu Riau, pelabuhan, etc.

Tier 1 (parallel):
  ├── Generate ref/cast-c1-face.png (Ali Sadikin)
  ├── Generate ref/cast-c2-face.png (Supporting character)
  ├── Generate ref/product-app.png
  └── Generate ref/env-pelabuhan.png (uses Dumai cultural data)

Tier 2 (parallel, after Tier 1 complete):
  ├── Generate ref/cast-c1-body.png ← injects ref/cast-c1-face.png
  └── Generate ref/cast-c2-body.png ← injects ref/cast-c2-face.png

Tier 3 (parallel, after Tier 2 complete):
  ├── Generate ref/cast-c1-costume.png ← injects c1-face + c1-body
  └── Generate ref/cast-c2-costume.png ← injects c2-face + c2-body

Tier 4: Scene NB2 images ← injects ALL refs per scene
```
