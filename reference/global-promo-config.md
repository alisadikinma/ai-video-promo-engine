# Global Promo Config — Single Source of Truth

All configurable values for the AI Video Promo Engine. Edit THIS file to change defaults — all skills and agents reference this file.

---

## 1. Language

| Setting | Value |
|---------|-------|
| `default_language` | `Bahasa Indonesia` |
| `technical_terms` | `English` (keep technical terms in English) |
| `script_language` | `Bilingual` (Bahasa Indonesia primary, English for tech terms) |
| `narration_language` | Per user preference (asked during brainstorm) |

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
| `config_version` | `1.1.0` |
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
