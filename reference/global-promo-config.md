# Global Promo Config — Single Source of Truth

All configurable values for the AI Video Promo Engine. Edit THIS file to change defaults — all skills and agents reference this file.

---

## 1. Language

| Setting | Value | Notes |
|---------|-------|-------|
| `narration_language` | Per user selection (Step 1.0) | Bahasa Indonesia / English / Bilingual |
| `prompt_language` | `English` | NB2/VEO prompt INSTRUCTIONS always in English (technical requirement — AI model needs English) |
| `technical_terms` | `English` | Keep technical terms/abbreviations in English regardless of narration language |
| `script_language` | Follows `narration_language` | Script narration/dialogue in user's chosen language |
| `ui_text_language` | Follows `narration_language` | On-screen text (dashboards, labels, signage) in user's chosen language |

### Language Options (Step 1.0)

| Option | Narration/VO | Dialogue (`says:`) | On-screen UI text | NB2/VEO Prompt Instructions | Strategic Brief |
|--------|-------------|-------------------|-------------------|------------------------------|-----------------|
| Bahasa Indonesia | Indonesian | Indonesian | Indonesian | English (ALWAYS) | Indonesian |
| English | English | English | English | English (ALWAYS) | English |
| Bilingual | Indonesian primary | Indonesian + English tech terms | Indonesian + English tech terms | English (ALWAYS) | Indonesian |

### Language Separation Summary

See Section 21 for full rules and examples. Key principle:
- **Prompt instructions** (SUBJECT, CAMERA, LIGHTING, reference image injection) → ALWAYS English
- **Content in final video** (dialogue, voiceover, on-screen text, labels) → follows `narration_language`
- **Technical abbreviations** (ANPR, GPS, RFID, etc.) → ALWAYS English everywhere

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
| `dialogue_syntax` | `Host says: text` | Generic role — NEVER real person names (safety filter) |
| `voiceover_syntax` | `Voice-over narrator, [tone]: text` | Off-screen narrator — NEVER bare `Voiceover:` (lip-syncs to visible char) |
| `postprod_vo_syntax` | `> POST-PROD VO: "text"` | Backup outside VEO prompt for every B-Roll scene |
| `sfx_syntax` | `SFX: description` | Sound effects |
| `ambient_syntax` | `Ambient: description` | Background atmosphere |
| `dialogue_max_words` | `8-15` per 8s clip | 3-6s sweet spot for lip sync |
| `voiceover_max_words` | `12-15` per 8s clip | Segmented from VO script |
| `dialogue_max_syllables` | `20-25` per 8s clip | |
| `face_min_frame_pct` | `30%` | Minimum for lip sync |
| `always_add` | `no subtitles, no audience sounds, no text overlays` | Every VEO prompt |
| `em_dash_forbidden` | `true` | NEVER use `—` in says:/narrator: text — causes audio artifacts. Use `,` or `. ` |

### VEO Audio Safety Rules

| Rule | Details |
|------|---------|
| **No real names in `says:`** | VEO safety filter rejects real person name + photorealistic face = "prominent people." Use `Host says:`, `Presenter says:`, `Speaker says:`. NB2 can still use real names. |
| **No bare `Voiceover:`** | VEO assigns bare `Voiceover:` speech to any visible on-screen character. Use `Voice-over narrator, [tone]: text` — VEO treats "narrator" as off-screen entity. |
| **No em dash in audio text** | `—` in `says:` or `Voice-over narrator:` text → VEO audio engine mistranslates. Replace with `,` or `. ` |
| **Every B-Roll has VO** | No silent B-Roll in promo videos. Every B-Roll scene needs `Voice-over narrator` line + `> POST-PROD VO:` backup. |
| **No face ref filenames in VEO** | `Maintain exact facial identity from reference image: xxx.png` → ONLY in NB2 prompts. VEO prompts use generic: `Maintain visual continuity with reference frame character appearance.` |
| **Face-dominant = single I2V** | Scene with face >30% frame → single I2V (start frame only). First+Last Frame mode → only for faceless scenes. Safety filter rejects 2 face images. |

---

## 6. Output Defaults

| Setting | Value | Notes |
|---------|-------|-------|
| `output_mode` | `full` | `full` = production plan, `quick` = copy-paste prompts |
| `output_folder` | `{project-folder}/output/` | All output files saved here |
| `asset_output_folder` | `ref/` | All generated assets saved here (flat, no subfolders) |
| `strategic_brief_file` | `strategic-brief.md` | Phase 1 output |
| `script_file` | `av-script.md` | Phase 2 output |
| `scene_plan_file` | `scene-plan.md` | Phase 3 output |
| `nb2_ref_prompts_file` | `nb2-reference-prompts.md` | Phase 4A output — Asset Library (atoms) |
| `image_prompts_file` | `image-prompts.md` | Phase 4B output — Scene Keyframes (molecules FROM assets) |
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
| `config_version` | `1.5.0` |
| `last_updated` | `2026-03-22` |

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

### CRITICAL: NB2 vs VEO — Different Injection Rules

**NB2 prompts:** Reference images MUST be embedded directly in prompt text with explicit filenames. Without injection, NB2 generates from text only — causing identity drift.

**VEO prompts:** Do NOT embed reference filenames. VEO gets identity from the uploaded start frame / ingredient images, NOT from text filenames. Use generic continuity language instead. Face ref filenames in VEO prompts may also trigger "prominent people" safety filter.

### NB2 Injection Syntax (embed in NB2 prompts ONLY)

| Category | Injection Phrase (NB2 prompts only) |
|----------|--------------------------------------|
| Cast face | `maintain exact facial identity from reference image: cast-c{N}-face.png` |
| Cast body | `maintain exact body proportions and build from reference image: cast-c{N}-body.png` |
| Cast costume | `wearing exact uniform/costume as shown in reference image: cast-c{N}-costume.png` |
| Product | `match exact product appearance from reference image: product-{name}.png` |
| Environment | `match environment and architectural style from reference image: env-{location}.png` |
| Brand asset | `use exact brand asset from reference image: brand-{asset}.png` |
| Institution uniform | `match exact institutional uniform from reference image: costume-{institution}.png` |

### VEO Continuity Syntax (embed in VEO prompts — generic, no filenames)

| Context | VEO Phrase |
|---------|-----------|
| Character continuity | `Maintain visual continuity with reference frame character appearance throughout clip.` |
| Multi-character | `Maintain visual continuity with reference frame appearances for all characters.` |
| Environment continuity | `Maintain exact lighting, environment, appearance from reference frame.` |

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
| 11 | `ref/scene-{NN-1}-end.png` | Previous scene end frame — grading & continuity anchor | ⬜ (MANDATORY if scene > 1) |
```

### Ref-to-Prompt Body Binding (MANDATORY)

Every ref in the upload table MUST have a corresponding injection line in the prompt body text. Having a ref in the upload table but NOT in the prompt body = the model won't use it.

```
RULE: For EACH row in the Required Reference Images table:
  → There MUST be a matching line in the prompt text:
    "Using reference image xxx.png for [specific purpose]"

  EXAMPLES:
    Upload table has: ref/cast-c1-face.png
    Prompt body MUST have: "maintain exact facial identity from reference image: cast-c1-face.png"

    Upload table has: ref/env-gate-pelabuhan.png
    Prompt body MUST have: "match environment EXACTLY as shown in reference image: env-gate-pelabuhan.png"

    Upload table has: ref/vehicle-truck-hino.png
    Prompt body MUST have: "match exact vehicle appearance from reference image: vehicle-truck-hino.png"
```

### Output Filename (MANDATORY per prompt)

Every generated NB2 prompt MUST include an explicit `**Output →**` line so the user knows exactly where to save the generated image.

```markdown
**Output →** ref/{filename}.png
```

**Naming for scene keyframes:**
- Start frame: `ref/scene-{NN}-start.png` (e.g., `ref/scene-07-start.png`)
- End frame: `ref/scene-{NN}-end.png` (e.g., `ref/scene-07-end.png`)
- Ingredient: `ref/scene-{NN}-ingredient-{N}.png`

**Naming for assets (Phase 4A):** Follow naming patterns in Section 17 Asset Categories table.

### Why This Matters

- Without explicit reference injection, AI generates from text description only → identity drift
- Face identity is the MOST critical — even slight deviation is immediately noticeable
- The reference image table per prompt prevents users from missing uploads
- Character reference concept = the model actively looks at and matches the ref image
- Without output filename, users don't know where to save → naming chaos → broken references

---

## 17. Asset-First Production Model (CRITICAL ARCHITECTURE)

### The Core Problem

Scene keyframes that describe visual elements from scratch (text only) → AI hallucinates inconsistently. The same truck looks different in every scene. The same driver's face changes. The same gate has barriers in one scene and not in another.

### The Solution: Atoms → Molecules

Image production is split into TWO explicit phases:

```
Phase 4A: ASSET LIBRARY (atoms)         → nb2-reference-prompts.md
  Generate individual reusable building blocks:
  - Characters (face, body, costume per cast member)
  - Vehicles (trucks, cars, boats — each as standalone)
  - Objects (products, equipment, tools, UI screens)
  - Locations (environments, buildings, facilities)
  - Branding (logos, signage — user-provided, not AI-generated)

Phase 4B: SCENE KEYFRAMES (molecules)   → image-prompts.md
  Compose scene images FROM pre-generated assets:
  - Every visual element REFERENCES a Phase 4A asset
  - NEVER describe a visual element from scratch if an asset exists
  - Scene keyframes are COMPOSITIONS, not standalone generations
```

### The Rule

> **Scene keyframes NEVER describe visual elements from text alone — always reference an asset file.**

If a scene shows a truck → the prompt says `match exact truck appearance from reference image: vehicle-truck-{name}.png`
If a scene shows a driver → the prompt says `maintain exact facial identity from reference image: cast-c{N}-face.png`
If a scene shows a gate → the prompt says `match environment from reference image: env-{location}.png`

### Asset Categories (Extended)

| # | Category | Naming Pattern | Example | Typical Dimensions | Notes |
|---|----------|---------------|---------|-------------------|-------|
| 1 | Cast face | `ref/cast-c{N}-face.png` | `ref/cast-c1-face.png` | head-and-shoulders crop | Identity anchor |
| 2 | Cast body | `ref/cast-c{N}-body.png` | `ref/cast-c1-body.png` | full body, ~170cm human | Proportions + wardrobe |
| 3 | Cast costume | `ref/cast-c{N}-costume.png` | `ref/cast-c1-costume.png` | full body, ~170cm human | Institutional uniform |
| 4 | Vehicle | `ref/vehicle-{type}-{name}.png` | `ref/vehicle-truck-hino.png` | real-world vehicle dimensions | NEW: recurring vehicles |
| 5 | Object | `ref/object-{name}.png` | `ref/object-weighbridge.png` | MUST specify exact cm/mm dimensions per item | NEW: recurring objects/equipment |
| 6 | Product | `ref/product-{name}.png` | `ref/product-cpo.png` | MUST specify exact cm/mm dimensions | Product closeup |
| 7 | Product closeup | `ref/product-closeup-{name}.png` | `ref/product-closeup-cangkang.png` | macro scale, specify actual size | MANDATORY detailed texture |
| 8 | Environment | `ref/env-{location}.png` | `ref/env-pelabuhan.png` | wide establishing shot | Location establishing |
| 9 | Brand logo | `ref/brand-{name}.png` | `ref/brand-pelindo.png` | vector/high-res logo | User-provided ONLY |
| 10 | UI/Screen | `ref/ui-{name}.png` | `ref/ui-anpr-screen.png` | screen resolution matching target display | Composite — depends on sub-elements |
| 11 | Institutional uniform | `ref/costume-{institution}.png` | `ref/costume-pelindo.png` | full body, ~170cm human | Master uniform template |

---

## 18. Dependency Graph & Dynamic Tier Assignment

### Recurring Element Auto-Detection Algorithm

BEFORE generating ANY asset or keyframe, engine MUST scan the entire av-script.md for recurring visual elements:

```
ALGORITHM: Build Dependency Graph

INPUT: av-script.md (all scenes)

STEP 1: EXTRACT all visual elements from every scene
  FOR each scene in av-script.md:
    EXTRACT: characters, vehicles, objects, products, locations, branding, UI screens
    STORE: element_name → [list of scene numbers where it appears]

STEP 1.5: CLASSIFY element type using keyword heuristics
  FOR each extracted element:
    SCAN description text for classification keywords:

    CHARACTER keywords → cast asset:
      person name, role title (driver, operator, manager, buyer),
      "karakter", "pemeran", pronouns referring to named character

    VEHICLE keywords → vehicle asset:
      truk, mobil, motor, kapal, forklift, bus, van, pickup,
      brand+model (Hino, Isuzu, Toyota), "kendaraan"

    OBJECT/PROP keywords → object asset:
      helm, clipboard, laptop, smartphone, HP, tablet, radio,
      alat, peralatan, display, timbangan, scanner, printer

    PRODUCT keywords → product asset:
      product name (from strategic-brief.md), "produk", "barang",
      commodity names (CPO, cangkang, kelapa sawit, batu bara)

    ENVIRONMENT keywords → environment asset:
      pelabuhan, kantor, gudang, jalan, gate, gerbang, dermaga,
      pabrik, tambang, lapangan, toko, restoran, location names

    BRAND/LOGO keywords → brand asset (USER-PROVIDED ONLY):
      logo, merk, brand, ikon, "icon aplikasi", "app icon",
      company name, institutional emblem, signage, papan nama

    UI/SCREEN keywords → UI composite asset:
      dashboard, layar, monitor, CCTV, ANPR, display screen,
      "tampilan aplikasi", "UI", notification, alert

  IMPORTANT: One description may contain MULTIPLE elements.
    "Driver membawa truk Hino melewati gate pelabuhan"
    → CHARACTER: driver (c2)
    → VEHICLE: truk Hino
    → ENVIRONMENT: gate pelabuhan
    = 3 separate elements extracted from 1 visual description

STEP 2: IDENTIFY recurring elements (appear 2+ times)
  FOR each element:
    IF appearance_count >= 2:
      → FLAG as "MUST be standalone asset"
      → Add to asset library (Phase 4A)
    IF appearance_count == 1:
      → Can be described inline in scene keyframe (Phase 4B)
      → BUT if user has a reference photo, still use it

STEP 2.5: APPLY standalone vs inline decision framework
  ALWAYS STANDALONE (even if only 1 appearance):
    - Any cast member face (identity anchor — consistency is paramount)
    - Any brand logo / app icon / institutional emblem (user-provided only)
    - Any product that is the VIDEO'S SUBJECT (even if shown once)
    - Any element the user uploaded a photo for in ref/

  STANDALONE (2+ appearances):
    - Vehicles with specific identity (red Hino truck, not "a truck")
    - Props that must look identical across scenes (specific phone, helmet, tool)
    - Environments that appear in multiple scenes (same gate, same office)
    - UI screens / digital displays (composite, needs sub-elements)

  INLINE OK (1 appearance, no identity requirement):
    - Generic background elements (a crowd, generic cars in traffic)
    - One-time props with no specific identity (a glass of water, a pen)
    - Atmospheric elements (rain, fog, dust — unless they must match across scenes)

  WHEN IN DOUBT → make it standalone. Cost of unnecessary asset = low.
  Cost of inconsistent element across scenes = viewer notices immediately.

STEP 3: DETECT sub-element dependencies
  FOR each asset prompt:
    SCAN prompt text for visual elements that match other assets
    IF prompt contains element X AND element X is a standalone asset:
      → This prompt DEPENDS ON element X
      → This prompt's tier = max(dependency tiers) + 1

  EXAMPLE:
    "ANPR screen showing truck and driver face in CCTV feed"
    → Contains "truck" (standalone asset) + "driver face" (standalone asset)
    → ANPR screen tier = max(truck.tier, driver.tier) + 1

STEP 4: ASSIGN tiers automatically
  Tier 0: User-provided (brand logos, cultural research data)
  Tier 1: Assets with NO dependencies on other assets (faces, standalone products, environments)
  Tier 2: Assets that depend on Tier 1 (body depends on face)
  Tier 3: Assets that depend on Tier 1+2 (costume depends on face+body)
  Tier N: Composites that contain lower-tier elements
  Tier LAST: Scene keyframes (reference ALL relevant assets)
```

**Scene-to-Scene Output Dependencies (NEW):**
In addition to asset-tier dependencies, sequential scene keyframes form a linear chain:
- Scene N END frame output → Scene N+1 START frame input
- This dependency is MANDATORY for all sequential scenes in the timeline
- Scene N+1's start frame prompt MUST include `ref/scene-{NN-1}-end.png` as first reference
- Scene N+1's upload table MUST include `ref/scene-{NN-1}-end.png` as row 11
- Generation order: Scene N MUST complete before Scene N+1 can begin (for sequential pairs)
- Non-sequential scenes (e.g., montage scenes in Act 0) can be generated in parallel

### Static Dependency Rules (Always Apply)

| Asset Being Generated | MUST Inject These Upstream Refs |
|--------------------|---------------------------------|
| Cast face | None (foundational) |
| Cast body | Face ref: `maintain exact facial identity from reference image: cast-c{N}-face.png` |
| Cast costume | Face ref + body ref |
| Vehicle | None (foundational — unless variant of base vehicle) |
| Object | None (unless composite containing other assets) |
| Product | None (independent) |
| Product closeup | Product hero ref (if exists) for consistency |
| Environment | None (uses cultural research data, not other refs) |
| UI/Screen composite | ALL sub-elements shown in the screen (vehicles, faces, products) |
| Scene keyframe | ALL relevant assets from every category |

### Dynamic Dependency Rules (Auto-Detected)

Any prompt that visually depicts an element that exists as a standalone asset → MUST reference that asset.

**Example dependency chains:**

```
Simple chain:
  cast-c1-face → cast-c1-body → cast-c1-costume → scene keyframe

Complex chain (ANPR screen):
  cast-c1-face ─┐
  vehicle-truck ─┤→ ui-anpr-screen → scene keyframe
  brand-logo   ─┘

Cross-chain (multi-element scene):
  cast-c1-face ──┐
  cast-c1-body ──┤
  cast-c1-costume┤
  vehicle-truck ─┤→ scene-07-start.png
  env-gate ──────┤
  product-cpo ───┘
```

### Generation Order (MANDATORY)

Within each tier, items can be generated in parallel. NEVER start a tier before ALL items in the previous tier are complete.

| Order | Tier | What to Generate | Dependencies |
|-------|------|-----------------|--------------|
| 0 | Pre-req | User uploads brand logos + cultural research completes | None |
| 1 | Tier 1 | Cast faces, standalone products, product closeups, environments, standalone vehicles, standalone objects | Cultural data for env only |
| 2 | Tier 2 | Cast bodies (inject face), vehicle variants (inject base) | Tier 1 complete |
| 3 | Tier 3 | Cast costumes (inject face+body) | Tier 2 complete |
| N | Tier N | Composites (inject all sub-elements) — e.g., UI screens showing truck+face | All dependency tiers complete |
| LAST | Scene | Scene keyframes (reference ALL relevant assets) | ALL assets complete |

### Validation Gate (Per Tier)

Before advancing to the next tier, verify EACH item in this checklist:

```
VALIDATION CHECKLIST (per tier):

□ COMPLETENESS: ALL assets in current tier are generated or uploaded
  → Count expected assets vs actual files in ref/
  → If any missing: BLOCK advancement, list missing assets

□ IDENTITY CONSISTENCY: Face matches across the identity chain
  → Compare face ref → body ref → costume ref for each cast member
  → Same person? Same features? Same skin tone? Same glasses?
  → If drift detected: regenerate downstream asset (body/costume), NOT face

□ RECURRING ELEMENT MATCH: Same asset looks identical where referenced
  → Vehicle ref matches in ALL scene keyframes that use it
  → Environment ref matches in ALL scene keyframes at that location
  → Product ref matches in ALL scene keyframes showing it

□ REF-TO-PROMPT BINDING: Every ref in upload table has matching injection
  → For each ref listed in "Required Reference Images" table of a prompt:
    SEARCH prompt body for injection phrase containing that ref filename
    If ref is listed but NOT injected in body → FIX prompt body
  → Injection phrase pattern: "from reference image: {filename}"

□ LOGO/BRAND VERIFICATION: Brand assets are user-provided, not AI-generated
  → If ref/brand-*.png exists → verify it appears in ALL prompts showing brand
  → If ref/brand-*.png missing → HARD BLOCK, ask user to provide

□ NO TEXT-ONLY DESCRIPTIONS: If asset ref exists, prompt uses it
  → SEARCH each scene keyframe prompt for text descriptions of elements
    that already have a standalone asset
  → If found: replace text description with ref injection
  → Example: "red Hino dump truck" in scene prompt → WRONG if ref/vehicle-truck-hino.png exists
    → Replace with: "match exact truck from reference image: vehicle-truck-hino.png"
```

- If any ref fails quality check → regenerate THAT ref only (don't cascade)

### Example: Pelindo Port Video (3 Characters, Truck, ANPR)

```
Tier 0 (user-provided):
  ├── ref/brand-pelindo.png (logo — user uploads)
  └── Cultural research: Dumai → plat BM, Melayu, pelabuhan modern, tropis

Tier 1 (parallel, no dependencies):
  ├── ref/cast-c1-face.png (Port Operator)
  ├── ref/cast-c2-face.png (Truck Driver)
  ├── ref/cast-c3-face.png (Japanese Buyer)
  ├── ref/vehicle-truck-hino.png (Hino dump truck, recurring in 4 scenes)
  ├── ref/product-closeup-cangkang.png (CPO shell closeup texture)
  ├── ref/env-gate-pelabuhan.png (actual gate photo or AI gen with cultural context)
  ├── ref/env-weighbridge.png (weighbridge area)
  └── ref/object-weighbridge-display.png (digital display panel)

Tier 2 (parallel, after Tier 1):
  ├── ref/cast-c1-body.png ← injects c1-face
  ├── ref/cast-c2-body.png ← injects c2-face
  └── ref/cast-c3-body.png ← injects c3-face

Tier 3 (parallel, after Tier 2):
  ├── ref/cast-c1-costume.png ← injects c1-face + c1-body (Pelindo uniform)
  └── ref/cast-c2-costume.png ← injects c2-face + c2-body (driver workwear)
  (c3 = Japanese buyer, no institutional costume)

Tier 4 (composite, after Tier 3):
  └── ref/ui-anpr-screen.png ← injects vehicle-truck + cast-c2-face + brand-pelindo
      (ANPR display showing truck plate + driver face in CCTV feed)

Tier LAST: Scene keyframes
  Scene 7 start: ← injects cast-c2-face + cast-c2-body + cast-c2-costume
                    + vehicle-truck + env-gate-pelabuhan + product-cangkang
  Scene 7 end:   ← same assets, different composition/pose
```

### Character Portrait-First Rule (HARD BLOCK)

**Any character in 2+ scenes MUST have standalone portrait generated FIRST in Phase 4A.** Text descriptions alone = different faces every time. This applies to ALL characters — cast members AND named extras/recurring background characters.

```
ENFORCEMENT:

STEP 1: SCAN av-script.md for ALL named or role-identified characters
  → Cast members from cast-profile.md (Pemeran Utama + Pendamping)
  → Named extras ("Budi si tukang parkir", "Pak RT")
  → Role-recurring extras ("supervisor shift malam" appearing in 3 scenes)

STEP 2: For EACH character appearing in 2+ scenes:
  → MUST have ref/cast-c{N}-face.png generated in Phase 4A Tier 1
  → If cast member: also needs body (Tier 2) and costume (Tier 3) per role
  → If recurring extra: face ref MINIMUM — body/costume optional

STEP 3: Scene keyframes (Phase 4B) MUST reference the portrait
  → NB2 prompts: inject "maintain exact facial identity from reference image: cast-c{N}-face.png"
  → VEO prompts: use generic continuity language (face refs are NB2-only)
  → NEVER generate a scene keyframe with a character described only by text if portrait exists

VIOLATION = IDENTITY DRIFT: Viewer sees different face every scene = amateur video.
```

### Scene Logic Realism — 9-Point Validation

Every NB2 and VEO prompt MUST pass the 9-point Scene Logic Realism checklist defined in `script-to-scene-bridge.md` Section 7B. This checklist prevents AI from generating "stock photo generic" scenes by enforcing environment accuracy, human behavior realism, data consistency, uniform rank accuracy, explicit negatives, reference photo enforcement, timeline/shift consistency, prop/object scale accuracy, and domain context population.

See `script-to-scene-bridge.md` Section 7B for the full checklist and per-prompt application algorithm.

### Narrative Arc Consistency — Cross-Scene References

Connected scenes MUST explicitly reference each other in their prompts. Every NB2/VEO prompt includes a `NARRATIVE CONTEXT:` block that names connections, visual breadcrumbs, cause-effect chains, and shared environment references. Without these, AI generates isolated frames with no narrative flow.

See `script-to-scene-bridge.md` Section 7C for the full rules and `NARRATIVE CONTEXT:` template.

---

## 19. Ref Folder Auto-Scan Protocol (MANDATORY)

### CRITICAL: Check ref/ folder BEFORE generating ANY prompt

Before generating ANY NB2 prompt (asset or keyframe), engine MUST:

```
PROTOCOL: Ref Folder Auto-Scan

STEP 1: LIST all files in {project}/ref/
  → Build inventory of available reference images

STEP 2: MAP visual elements to existing refs
  FOR each visual element in the prompt being generated:
    SEARCH ref/ for matching file
    IF match found:
      → MUST include in prompt body as character reference
      → MUST include in Required Reference Images table
      → Prompt text: "Using reference image xxx.png for [specific purpose]"
    IF no match found:
      → FLAG to user: "Apakah ada foto untuk {element}? Jika ada, save ke ref/{suggested-name}.png"

STEP 3: AUTO-DETECT brand/institution assets
  SCAN cast-profile.md for institution keywords
  IF institution detected:
    → CHECK ref/ for ref/brand-{institution}.png and ref/costume-{institution}.png
    → If exists: auto-add to ALL UI/signage/branding prompts
    → If missing: flag as hard-block requirement

STEP 4: NEVER hallucinate what you can reference
  IF ref/env-gate-pelabuhan.png exists:
    → Prompt MUST say "match environment EXACTLY as shown in env-gate-pelabuhan.png"
    → Do NOT describe gate from imagination (wrong barriers, wrong style, wrong era)
  IF ref/product-closeup-cangkang.png exists:
    → Prompt MUST say "match exact product texture and appearance from product-closeup-cangkang.png"
    → Do NOT describe cangkang from text (AI will hallucinate wrong texture — e.g., sawit buah utuh instead of pecahan cangkang)
```

### Why This Matters

Without auto-scan:
- Gate photo shows modern facility → NB2 generates rusty gate with barriers (hallucination)
- User has uniform photo → NB2 generates wrong uniform from text description
- Logo file exists in ref/ → NB2 generates garbled AI logo instead of using real one
- Product closeup exists → NB2 generates wrong product (cangkang → buah sawit)

### Auto-Include Priority

| Priority | Condition | Action |
|----------|-----------|--------|
| 1 | User-provided photo exists in ref/ | ALWAYS use it — it's ground truth |
| 2 | AI-generated asset exists from Phase 4A | Reference it in Phase 4B keyframes |
| 3 | No ref exists, element appears 2+ times | Generate standalone asset in Phase 4A FIRST |
| 4 | No ref exists, element appears 1 time | Can describe inline BUT ask user if they have a photo |

> **Cross-reference:** For visual continuity rules, pre-Phase 4A inventory template, and Continuity Supervisor mindset, see `image-video-gen/06-directing-and-performance.md` Section 7.

---

## 20. Aspect Ratio Triple Enforcement

### Problem

Some NB2 prompts generate wrong aspect ratio (portrait/square) when target is 16:9. NB2 defaults to auto-detect ratio which causes mismatches.

### Solution: Triple Enforcement

EVERY NB2 prompt MUST enforce aspect ratio in THREE locations:

```
[LINE 1 — FIRST LINE OF PROMPT]
IMPORTANT: Generate in LANDSCAPE 16:9 aspect ratio. Do NOT generate portrait or square.

[... rest of prompt ...]

[TECHNICAL SECTION]
TECHNICAL: 16:9 landscape, {resolution}, CFG {cfg}, Denoise {denoise}, Thinking {mode}.

[LAST LINE OF PROMPT]
OUTPUT: 16:9 LANDSCAPE aspect ratio. Width > Height. Do NOT crop or change ratio.
```

Replace `16:9` with target ratio from `video_aspect_ratio` in Section 2 (e.g., `9:16` for TikTok/Reels).

### Why Triple

NB2 has positional attention bias:
- First tokens get strong attention (primacy)
- Last tokens get recency attention
- Middle tokens can be overlooked
- Putting ratio in all 3 positions ensures it's never missed

---

## 21. Language Separation Rules & UI Text Localization

### The Core Rule: Prompt Text vs Content Text

There are TWO types of text in every NB2/VEO prompt, and they follow DIFFERENT language rules:

| Text Type | Language | Examples |
|-----------|----------|---------|
| **Prompt instructions** (what AI model reads) | ALWAYS English | "SUBJECT:", "CAMERA:", "LIGHTING:", "maintain exact facial identity from..." |
| **Narration/dialogue** (what audience hears) | Per `narration_language` | `Host says: Selamat datang di pelabuhan Dumai`, `Voice-over narrator, warm: Inilah solusi kami` |
| **On-screen UI text** (what audience reads in the video) | Per `narration_language` | Dashboard labels, signage, buttons, status messages |
| **Technical abbreviations** | ALWAYS English | ANPR, PLC, NPE, OEE, GPS, RFID, IoT, API |

### Why Prompt Instructions Stay English

NB2 and VEO are trained on English prompts. Using Indonesian for technical prompt instructions (camera, lighting, subject description) → model misinterprets or ignores directives. The AI model needs English to understand what to generate.

### What Gets Localized

Only **content that appears in the final video output** follows the user's language selection:

1. **`Host says:` dialogue text** — what characters speak (lip sync, generic role name)
2. **`Voice-over narrator, [tone]:` text** — off-screen narration track
3. **On-screen text** — UI screens, dashboards, signage, labels, buttons, warnings
4. **Text overlays** — if any text is rendered on screen

### UI Text Localization Config

| Setting | Value | Notes |
|---------|-------|-------|
| `ui_text_language` | Per `narration_language` selection | UI/label/signage text matches target market language |
| `ui_text_exceptions` | Technical abbreviations: ANPR, PLC, NPE, OEE, GPS, RFID, IoT, API | Stay English |

### Localization Pass (MANDATORY for Phase 4A + 4B)

After generating any prompt that contains on-screen text (UI screens, signage, displays, labels):

```
SCAN prompt for on-screen text:
  - Dashboard labels
  - Button text
  - Status messages
  - Measurement units/labels
  - Warning/alert text
  - Signage text

IF narration_language == "Bahasa Indonesia" OR "Bilingual":
  TRANSLATE all on-screen text to Bahasa Indonesia
  EXCEPT technical abbreviations in ui_text_exceptions list

EXAMPLES:
  "GROSS WEIGHT" → "BERAT KOTOR"
  "TARE" → "TARA"
  "NETTO" → "NETTO" (same in Indonesian)
  "GATE EXIT: BLOCKED" → "PINTU KELUAR: DIBLOKIR"
  "STATUS: APPROVED" → "STATUS: DISETUJUI"
  "ANPR" → "ANPR" (exception — technical abbreviation)
```

### Example: Correct Language Separation in a Single Prompt

```
[PROMPT TEXT — ENGLISH (AI model reads this)]
IMPORTANT: Generate in LANDSCAPE 16:9 aspect ratio. Do NOT generate portrait or square.
SUBJECT: Port operator standing next to ANPR monitoring screen.
Maintain exact facial identity from reference image: cast-c1-face.png.
CAMERA: Medium shot, 50mm f/4, eye-level.
LIGHTING: Clean office lighting, 4500K neutral.

[ON-SCREEN UI TEXT — BAHASA INDONESIA (audience reads this in the video)]
UI TEXT (Bahasa Indonesia):
  Header: "SISTEM PEMANTAUAN ANPR"
  Label 1: "BERAT KOTOR: 45.200 kg"
  Label 2: "TARA: 15.800 kg"
  Label 3: "NETTO: 29.400 kg"
  Status: "PINTU KELUAR: DISETUJUI ✓"
  (ANPR stays English — technical abbreviation)

[DIALOGUE — BAHASA INDONESIA (audience hears this)]
Operator says: Sistem ANPR kita sudah terintegrasi penuh dengan timbangan digital.

TECHNICAL: 16:9 landscape, 4K resolution, CFG 6.0, Denoise 0.40, Thinking High.
OUTPUT: 16:9 LANDSCAPE aspect ratio. Width > Height. Do NOT crop or change ratio.
```

### Why This Matters

Target market Indonesia seeing "GROSS WEIGHT" and "GATE EXIT: BLOCKED" on screens → immediately feels foreign/unrelatable. Indonesian audience expects Indonesian UI text. But the prompt instructions MUST stay English for AI model to understand correctly.

---

## 22. Product Closeup & Location Photo Rules

### Product Closeup Reference (MANDATORY)

Every product/commodity shown in the video MUST have a closeup reference image.

```
PROTOCOL: Product Closeup

STEP 1: Ask user
  AskUserQuestion:
  "Ada foto closeup produk/komoditi? Foto asli JAUH lebih baik dari AI-generated
  karena AI sering salah texture/bentuk (contoh: cangkang kelapa sawit di-generate
  jadi buah sawit utuh)."

  Options:
  A) Ya, saya upload ke ref/product-closeup-{name}.png
  B) Tidak ada, generate pakai NB2

STEP 2: If user uploads → use as PRIMARY reference for ALL product prompts
  → "match EXACTLY as shown in product-closeup-{name}.png — texture, color, size, shape"

STEP 3: If AI-generated → generate with EXTREME specificity
  → Include detailed texture description: "broken/cracked pieces, not whole fruit"
  → Include scale reference: "pieces approximately 2-5cm diameter"
  → Include color specifics: "dark brown to black, glossy outer surface, fibrous inner texture"
  → WARN user: "AI-generated product image may not match real product. Verify before using."
```

### Location Photo Reference (MANDATORY per unique location)

Every unique location in the scene plan MUST have a reference image — either user-provided photo or AI-generated with cultural context.

```
PROTOCOL: Location Photo

STEP 1: Auto-derive location list from scene-plan.md
  EXTRACT all unique locations

STEP 2: For each location, ask user
  AskUserQuestion:
  "Video ini ada di {N} lokasi. Ada foto asli untuk lokasi berikut?"

  | # | Location | Foto? |
  |---|----------|-------|
  | 1 | {location_1} | ⬜ |
  | 2 | {location_2} | ⬜ |

  Options:
  A) Ada foto untuk semua/sebagian → upload ke ref/env-{location}.png
  B) Tidak ada foto → generate pakai NB2 (cultural context will be injected)

STEP 3: If user photo → use as ground truth
  → "match environment EXACTLY as shown in env-{location}.png"
  → Do NOT add/remove architectural elements that don't exist in the photo

STEP 4: If AI-generated → inject cultural research HEAVILY
  → Architecture style, plate codes, ethnicity, weather, landmarks
  → WARN: "AI-generated location may not match real facility. Verify before using."
```

### Why Real Photos Are Better

| Element | AI-Generated | User Photo |
|---------|-------------|------------|
| Gate | Adds barriers that don't exist | Shows exact gate design |
| Weighbridge | Analog dial in modern facility | Shows actual digital display |
| Product texture | Wrong species/shape/color | Exact texture and color |
| Facility condition | Defaults to generic (often kumuh) | Shows actual modern facility |
| Signage | Hallucinated text/logos | Real signs and branding |

---

## 23. Climate-Aware Costume Cross-Check

### Problem

Cast costume may be inappropriate for the video's climate/setting. Example: Japanese buyer in formal wool suit in tropical Dumai (33°C) — unrealistic.

### Protocol

```
AFTER cultural research (Step 3.5.2a) completes:

  FOR each cast member in cast-profile.md:
    CROSS-CHECK costume vs climate:

    IF climate == "tropis" (>28°C average) AND costume contains:
      - "wool suit", "heavy blazer", "winter coat", "thick jacket"
      → FLAG: "Kostum {character} terlalu tebal untuk iklim tropis {location} ({temp}°C).
         Suggest: lightweight linen suit / batik shirt / cotton business casual."

    IF climate == "formal indoor" (AC office):
      → Standard formal wear is OK regardless of outdoor temp

    IF character is "foreign visitor" (e.g., Japanese buyer):
      → Suggest: "smart casual appropriate for tropical climate —
         light cotton dress shirt, no tie, lightweight trousers"
      → NOT: full wool suit with tie in 33°C heat

  Present flagged issues via AskUserQuestion:
  "Ada costume yang mungkin tidak cocok dengan iklim/setting:

  {list of flagged issues}

  Mau adjust?"

  Options:
  A) Ya, adjust sesuai saran
  B) Tidak, tetap pakai costume yang sudah dipilih (override)
```

### Climate → Costume Matrix

| Climate | Max Formality | Recommended | Avoid |
|---------|-------------|-------------|-------|
| Tropis outdoor (>28°C) | Smart casual | Linen, cotton, batik, lightweight | Wool, heavy blazer, winter fabrics |
| Tropis indoor (AC) | Business formal | Standard suit OK (AC environment) | Winter coat, heavy layers |
| Humid coastal | Casual-smart | Breathable fabrics, open collar | Tight collar, heavy fabrics |
| Industrial/port | Work appropriate | Safety vest, breathable uniform | Formal suit in dusty environment |

---

## 24. Location & Domain Deep Research (MANDATORY)

### Problem

AI is blind about specific product domains AND domains are location-specific. A hospital in Indonesia looks completely different from one in the US or China. A factory in Cikarang differs from one in Shenzhen. Without **location-aware** domain knowledge, AI generates:
- Wrong machines (US brands instead of locally-used equipment)
- Wrong processes (Western workflow instead of local practice)
- Wrong operator actions (Western PPE norms instead of local standards)
- Wrong architecture (generic Western building instead of local construction style)
- Wrong signage (English instead of Bahasa, wrong safety standard marks)
- Wrong uniforms (Western scrubs instead of local hospital uniforms with jilbab)

### Why Location Changes Everything

| Domain | Generic AI Default | Indonesia Reality | Japan Reality | US Reality |
|--------|-------------------|-------------------|---------------|------------|
| Hospital | US-style ER | Lorong lebar, tile floors, jilbab nurses, Bahasa signage | Minimalis, kanji signs, tatami-influence | Large campus, English, scrubs + sneakers |
| Factory | Clean Western factory | K3 safety signs, batik Fridays, local brands | 5S methodology, Japanese equipment | OSHA signage, American brands |
| Port | Generic container terminal | Pelindo-style, BM plates, Melayu workers | Automated Japanese terminals | Union labor, English signage |

### When to Execute

1. **Step 1.2c: Location** — collect location/setting FIRST
2. **Step 1.2d: Domain Research** — execute location-aware research queries

Both BEFORE target market selection or scripting.

### Research Protocol (6 Mandatory Queries — ALL Location-Qualified)

| # | Query Template | Purpose | Output |
|---|---------------|---------|--------|
| 1 | `{domain} in {country} production process workflow` | Local process flow | How this domain operates IN THIS LOCATION |
| 2 | `{domain} {country} equipment machines brands commonly used` | Local equipment | What brands/models are actually used locally |
| 3 | `{domain} {country} worker roles uniforms PPE requirements` | Local workforce | Local PPE standards, dress norms, cultural dress |
| 4 | `{domain} {location} facility layout photos` | Local facility | Architecture style, building materials, interior norms |
| 5 | `{product_name} product interface dashboard features` | Product visuals | Actual product appearance in use |
| 6 | `{domain} {country} regulations standards signage` | Local regulations | Safety signage language, certification marks, warning colors |

### Domain Knowledge Output Template

Save to `strategic-brief.md` > Domain Knowledge section:

```markdown
### Domain Knowledge — {domain} in {location}, {country}

#### Location Context
| Setting | Detail |
|---------|--------|
| Country | {country} |
| City/Region | {city} |
| Setting type | {factory/hospital/port/office/outdoor} |
| Indoor/Outdoor | {indoor/outdoor/both} |
| Local regulations | {K3, ISO, BPOM, JCI, OSHA, etc.} |

#### Process Flow (as practiced locally)
1. {step_1}: {local_equipment} → {output}
2. {step_2}: {local_equipment} → {output}

#### Key Equipment Visual Reference (Local Brands/Models)
| Equipment | Local Brand/Model | Appearance | Key Visual Feature |
|-----------|------------------|-----------|-------------------|

#### Operator Roles & Actions (Local Workforce)
| Role | Typical Action | Local PPE/Uniform | Tools/Equipment |
|------|---------------|-------------------|-----------------|

#### Workspace Environment (Location-Specific)
| Element | Local Standard | Visual Details |
|---------|---------------|----------------|
| Signage | {Bahasa/English/bilingual} | {K3 signs, safety colors} |
| Architecture | {local style} | {building materials, ceiling, ventilation} |

#### Product Visual Reference
{what the actual product looks like in this local context}

#### Local Differentiators (vs generic AI default)
| Aspect | Generic AI Default | Actual Local Reality |
|--------|-------------------|---------------------|
```

### Injection Points

Domain knowledge feeds into ALL subsequent phases:

| Phase | What Domain Knowledge Affects |
|-------|------------------------------|
| Phase 2 (Script) | Accurate local terminology, plausible actions, correct process descriptions |
| Phase 3 (Scene Plan) | Realistic local scene settings, correct local equipment per scene |
| Phase 3.5 (Cultural Research) | Domain research + cultural research COMBINE for full location accuracy |
| Phase 4A (Asset Library) | Local equipment descriptions in NB2, correct local PPE/uniforms |
| Phase 4B (Scene Keyframes) | NB2 prompts reference domain + location details, local workspace layout |
| Phase 5 (Video Prompts) | VEO prompts with locally-accurate ambient sounds, plausible motion |

### How to Use in Prompts

Every NB2/VEO prompt depicting domain-specific content MUST include `DOMAIN CONTEXT:` line with location-qualified details:

```
DOMAIN CONTEXT: {equipment/process from Domain Knowledge — location-specific description}
```

Examples:
- Indonesia SMT: `DOMAIN CONTEXT: Yamaha YSM20R pick-and-place machine (common in Indonesian SMT lines) — white body, green conveyor belt, Japanese-brand nozzle heads, K3 safety sticker on side panel.`
- Indonesia hospital: `DOMAIN CONTEXT: Ruang IGD RS tipe B Indonesia — lorong ubin putih 3m lebar, AC split wall-mount, papan petunjuk Bahasa Indonesia, perawat berjilbab, bed stainless steel lokal.`
- US warehouse: `DOMAIN CONTEXT: Amazon-style fulfillment center — concrete floors with yellow safety lines, Crown forklifts, OSHA signage in English, workers in high-vis vests + steel-toe boots.`

### Validation

- Location MUST be confirmed before domain research begins (Step 1.2c)
- Location-aware domain research MUST complete before Phase 2 begins (Step 1.2d)
- User MUST validate domain knowledge accuracy (Step 1.2d approval gate)
- If user corrects domain info → update strategic-brief.md immediately
- Every scene depicting domain-specific content → prompt must include `DOMAIN CONTEXT:` line
- Domain research + cultural research (Step 3.5.2a) are COMPLEMENTARY — domain = industry knowledge, cultural = geographic/ethnic/architectural details
