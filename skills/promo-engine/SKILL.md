---
name: promo-engine
description: >
  End-to-end AI video promotional production engine. 6-phase pipeline that generates complete
  2-3 minute promotional video packages: brainstorm → script → scene breakdown → reference
  collection → NB2 image prompts → VEO 3.1 video prompts. Supports multi-character cast
  (max 5), any brand (generic) or Ali Sadikin preset.
  Triggers on: video promo, promotional video, product video, promo engine, video production,
  bikin video promosi, buat video, video marketing, iklan video, video agency,
  generate video, create promo, video script, cast, pemeran, karakter video.
---

# Promo Engine — AI Video Promotional Production Pipeline

## Overview

Full 6-phase pipeline skill that guides users from initial brainstorm to production-ready NB2 image prompts and VEO 3.1 video prompts for 2-3 minute promotional videos. Includes multi-character cast builder and mandatory reference collection gate.

## How to Use This Skill

### As Inline Skill (Recommended)
Claude reads this SKILL.md directly and follows the 6-phase workflow interactively.

### As Subagent (For batch work)
Copy `agents/promo-engine-agent.md` to your project's `.claude/agents/` directory.

## Reference Files (Read On-Demand)

### Always Read First
| Task | Read |
|------|------|
| ANY generation | `reference/global-promo-config.md` (ALWAYS FIRST) |

### Phase 1: Brainstorm
| Task | Read |
|------|------|
| Cast profile system | `reference/creator-profile-system.md` |
| Target market psychology | `reference/storytelling_script_gen/F1_Audience_Psychology_Matrix.md` |
| Awareness level routing | `reference/storytelling_script_gen/F8_Awareness_Level_Routing.md` |

### Phase 2: Script Generation
| Task | Read |
|------|------|
| Master script engine | `reference/storytelling_script_gen/project-instruction.md` |
| Narrative arc selection | `reference/storytelling_script_gen/F2_Narrative_Arc_and_Video_Typology.md` |
| Cinematic AV rules | `reference/storytelling_script_gen/F3_Cinematic_AV_Production_Rules.md` |
| Hook selection | `reference/storytelling_script_gen/F5_Hook_Vault.md` |
| CTA frameworks | `reference/storytelling_script_gen/F6_CTA_Vault.md` |
| Foreshadow & peak | `reference/storytelling_script_gen/F7_Foreshadow_and_Peak_Engineering.md` |
| Platform adaptation | `reference/storytelling_script_gen/F9_Platform_Adaptation_Matrix.md` |
| Modular assets | `reference/storytelling_script_gen/F10_Modular_Asset_and_AB_Testing.md` |
| Pattern interrupts | `reference/storytelling_script_gen/F11_Pattern_Interrupt_and_Retention.md` |
| EV products ONLY | `reference/storytelling_script_gen/F4_EV_Persona_Matrix.md` |

### Phase 3: Scene Breakdown
| Task | Read |
|------|------|
| Script → scene bridge | `reference/script-to-scene-bridge.md` |
| NB2 → VEO pipeline | `reference/image-video-gen/03-workflow-pipeline.md` |
| Production stack | `reference/image-video-gen/00-index.md` |

### Phase 3.5: Reference Collection
| Task | Read |
|------|------|
| Cast profile & refs | `reference/creator-profile-system.md` |
| Naming conventions | `reference/global-promo-config.md` (Section 11) |
| Institution detection | `reference/global-promo-config.md` (Section 12) |

### Phase 4: Image Prompts
| Task | Read |
|------|------|
| NB2 image specs | `reference/image-video-gen/01-nb2-image-generation.md` |
| Cinematography lookup | `reference/image-video-gen/04-cinematography-lookup.md` |
| Creator profile/preset | `reference/image-video-gen/05-creator-and-holidays.md` |

### Phase 5: Video Prompts
| Task | Read |
|------|------|
| VEO 3.1 production | `reference/image-video-gen/02-veo-production-guide.md` |
| Image-video pipeline | `reference/image-video-gen/project-instruction.md` |
| Cinematography lookup | `reference/image-video-gen/04-cinematography-lookup.md` |

---

## Hard Rules (NON-NEGOTIABLE)

1. **NEVER skip a phase** — all 6 phases must execute in order (including Phase 3.5)
2. **NEVER proceed without user approval** — every phase ends with approval gate
3. **Ingredients ≠ First+Last Frame** — mutually exclusive VEO modes, NEVER combine
4. **Audio is NEVER optional** — unspecified = VEO guesses random sounds
5. **Dialogue uses colon syntax** — `says:` NEVER quotation marks
6. **720p for extendable clips** — 1080p clips CANNOT extend
7. **NB2 aspect ratio MUST match VEO target** — mismatch = edge hallucination
8. **Product is NEVER the hero** — customer is hero, product is bridge
9. **First 3 seconds determine everything** — hook must stop the scroll
10. **Forbidden words** — synergy, leverage, robust, revolutionary, cutting-edge, seamlessly, innovative solution, state-of-the-art
11. **B-Roll voiceover ≠ lip sync** — B-Roll uses `Voiceover:` NOT `says:`
12. **Face >30% frame for lip sync** — smaller = sync failure
13. **Every feature MUST have human consequence** — no feature listing without "so what?"
14. **All AskUserQuestion interactions** — NEVER ask questions as plain text, ALWAYS use AskUserQuestion tool with selectable options
15. **Max 5 cast members** — 1-3 Pemeran Utama + 0-2 Pemeran Pendamping (NB2 identity lock limit)
16. **Phase 3.5 is HARD BLOCK** — cannot proceed to Phase 4 without ALL reference images validated in ref-manifest.md
17. **Cast ref by role** — Utama: face+body+costume(if institutional) MANDATORY. Pendamping: face MANDATORY, body/costume OPTIONAL.
18. **Narration language from Step 1.0** — script dialogue and VEO `says:` text MUST be in user's chosen language. NB2/VEO prompt structure stays English.
19. **Tone consistency** — `video_tone` from Step 1.7b MUST be applied across ALL phases: script word choice (Phase 2), cinematography (Phase 4), atmosphere (Phase 5). Reference global-promo-config.md Section 13 Tone Impact Matrix.
20. **Cultural accuracy** — when location is specified, web search MUST be performed (Step 3.5.2a) and cultural details MUST be injected into environment NB2 prompts and VEO scene prompts. Wrong license plate / wrong ethnicity / wrong architecture = rejection signal.

---

## Workflow

### Phase 1: BRAINSTORM (Output: strategic-brief.md)

**Read first:** `global-promo-config.md`, `creator-profile-system.md`, `F1_Audience_Psychology_Matrix.md`, `F8_Awareness_Level_Routing.md`

#### Step 1.0: Language Selection

```
AskUserQuestion:
"Bahasa apa yang mau digunakan untuk narasi/voiceover video?"

Options:
A) Bahasa Indonesia
B) English
C) Bilingual (Indonesia primary, English for tech terms)
```

Save selection as `narration_language` in strategic-brief.md.
This affects: script dialogue (Phase 2), VEO `says:` text (Phase 5), strategic brief language.
NB2/VEO prompt structure always stays English (per `global-promo-config.md` `prompt_language`).

#### Step 1.1: Welcome & Cast Setup

**Read:** `creator-profile-system.md` (Cast Profile System)

```
AskUserQuestion:
"Selamat datang di Promo Engine! Pertama, siapkan cast (pemeran) untuk video ini."

Options:
A) Build cast baru (isi profile per karakter)
B) Use Ali Sadikin preset (fills 1 Pemeran Utama slot)
C) Load existing cast (dari cast-profile.md)
```

If "Build cast baru" or "Ali Sadikin preset" → follow Cast Builder Flow in `creator-profile-system.md` Section 1:
1. Cast size selection (1-5 characters)
2. Per-character role assignment (Utama/Pendamping)
3. Per-character profile collection (name, gender, age, ethnicity, features)
4. Ali Sadikin preset assignment (if selected)
5. Institution detection (auto-scan brand + confirm)

Save output: `{project}/cast-profile.md`

#### Step 1.2: Product/Service Discovery

```
AskUserQuestion:
"Produk atau layanan apa yang akan dipromosikan di video ini?"

Options:
A) SaaS / Software product
B) Physical product
C) Professional service
D) Other (jelaskan)
```

Follow-up:
```
AskUserQuestion:
"Apakah kamu punya technical document atau product brief yang bisa di-upload?
(PDF, doc, atau paste text langsung)"

Options:
A) Ya, saya akan upload/paste
B) Tidak, kita diskusi langsung
```

If user uploads/pastes → silently ingest 6 elements per `project-instruction.md` Phase 1:
1. Product category
2. Core value proposition
3. Target audience
4. Shame layer (pain they want to escape)
5. Pride layer (identity they want to claim)
6. Awareness level

#### Step 1.2b: Institution Detection

After product/service is identified, auto-scan for institutional keywords per `global-promo-config.md` Section 12.

If institution detected:

```
AskUserQuestion:
"Terdeteksi produk ini terkait dengan {institution}. Apakah karakter di video perlu pakai seragam {institution}?"

Options:
A) Ya, semua pemeran pakai seragam
B) Ya, tapi hanya pemeran tertentu
C) Tidak, pakai outfit generic
```

If A → update cast-profile.md with `costume_type = "institutional"` for ALL cast members.
If B → follow per-character costume assignment per `creator-profile-system.md` Section 7.
If C → no costume refs required (unless user manually adds later).

If no institution keyword detected → skip this step automatically.

#### Step 1.3: Target Market Selection

```
AskUserQuestion:
"Siapa target audience utama video ini?"

Options:
A) C-Level (CEO, CTO, CFO) — strategic, ROI-focused
B) VP / Director — operational efficiency
C) Manager — practical workflow improvement
D) Individual Contributor — technical, hands-on
E) Social Media audience — emotional, punchy, Gen-Z
```

#### Step 1.4: Awareness Level

```
AskUserQuestion:
"Seberapa aware target audience terhadap masalah dan solusi kamu?"

Options:
A) Unaware — belum tahu ada masalah
B) Problem-Aware — tahu masalahnya, belum tahu solusi
C) Solution-Aware — tahu ada solusi, belum tahu produk kamu
D) Product-Aware — tahu produk kamu, belum yakin
E) Most-Aware — sudah yakin, butuh push terakhir
```

#### Step 1.5: Platform Selection

```
AskUserQuestion:
"Platform utama untuk video ini?"

Options:
A) YouTube (16:9, 2-3 min)
B) LinkedIn (16:9, 1-2 min)
C) Instagram Reels (9:16, 60-90s)
D) TikTok (9:16, 60-90s)
```

#### Step 1.6: Emotional Core Discovery

```
AskUserQuestion:
"Apa transformasi emosional yang kamu inginkan dari viewer?
(Dari state A → state B setelah nonton video)"

Options:
A) Frustrated → Relieved (problem-solution)
B) Skeptical → Convinced (proof-driven)
C) Unaware → Curious (discovery)
D) Interested → Urgent (FOMO/scarcity)
E) Custom (jelaskan sendiri)
```

#### Step 1.7: Storyline Input

```
AskUserQuestion:
"Apakah kamu punya ide storyline/cerita untuk video ini?"

Options:
A) Ya, saya mau ketik/paste storyline saya
B) Tidak, bantu saya brainstorm dari nol
C) Saya punya referensi video yang mirip (share link/description)
```

**If A (user has storyline):**

User pastes freeform text in the next message. AI then:

1. Parse storyline against the 7-beat arc (per `storytelling_script_gen/project-instruction.md`):
   - Pattern Interrupt, Hook, Foreshadow, Agitate, Guide+Plan, Peak, CTA, Won Day
2. Present beat mapping:

```markdown
## Storyline → 7-Beat Arc Mapping

| Beat | Status | Your Storyline Element |
|------|--------|----------------------|
| Pattern Interrupt | ✅ Covered | "{extracted element}" |
| Hook | ✅ Covered | "{extracted element}" |
| Foreshadow | ❌ Missing | — |
| Agitate | ✅ Covered | "{extracted element}" |
| Guide + Plan | ✅ Covered | "{extracted element}" |
| Peak | ❌ Missing | — |
| CTA | ✅ Covered | "{extracted element}" |
| Won Day | ❌ Missing | — |
```

3. For missing beats, suggest additions:

```
AskUserQuestion:
"Storyline kamu sudah cover {X}/8 beats. Saya suggest tambahan untuk beat yang missing:

- Foreshadow: {suggestion based on storyline context}
- Peak: {suggestion for emotional climax}
- Won Day: {suggestion for future-state visualization}

Approve suggestions?"

Options:
A) Approve semua suggestions
B) Approve sebagian (saya pilih mana)
C) Saya mau revise storyline sendiri
D) Skip — biarkan AI lengkapi di Phase 2
```

**If B (brainstorm from scratch):**

Engage user in guided discussion via AskUserQuestion:
- Key pain points of target audience
- Unique selling proposition
- Competitor landscape
- Success stories / case studies
- Desired CTA (what should viewer DO after watching?)

Use AskUserQuestion to present options and brainstorm ideas together.

**If C (reference video):**

User describes or shares reference. AI:
1. Extract narrative structure from description
2. Map to 7-beat arc
3. Adapt to user's product/context
4. Present adapted storyline for approval

#### Step 1.7b: Tone/Mood Selection

```
AskUserQuestion:
"Apa tone/mood yang kamu inginkan untuk video ini?"

Options:
A) Humorous / Playful — ringan, ada jokes, approachable
B) Serious / Dramatic — berat, impactful, emosional
C) Professional / Corporate — formal, data-driven, polished
D) Inspirational / Motivational — uplifting, empowering
E) Casual / Friendly — santai, conversational, relatable
F) Edgy / Bold — provocative, disruptive, berani
```

Save as `video_tone` in strategic-brief.md.

Tone affects ALL subsequent phases — reference `global-promo-config.md` Section 13 (Tone Impact Matrix) for per-phase adjustments to:
- Script word choice and pacing (Phase 2)
- Hook style selection from F5 Hook Vault (Phase 2)
- Lighting ratio and camera style (Phase 4 NB2)
- Music and SFX direction (Phase 5 VEO)
- Character expression guidance (Phase 4 NB2)
- Atmosphere keywords (Phase 5 VEO)

#### Step 1.8: Strategic Brief Presentation

Present the Strategic Brief for approval:

```markdown
# Strategic Brief

## Product: {name}
## Target: {market} — {awareness_level}
## Platform: {platform} ({aspect_ratio}, {duration})
## Language: {narration_language}
## Tone: {video_tone}
## Emotional Arc: {from_state} → {to_state}

## Core Value Proposition
{1-2 sentences}

## Shame Layer (pain to escape)
{1-2 sentences}

## Pride Layer (identity to claim)
{1-2 sentences}

## Key Messages
1. {message_1}
2. {message_2}
3. {message_3}

## CTA
{specific action}

## Storyline (User Input)
{user's original storyline or "AI-generated from brainstorm"}

## Cultural Context
(Populated in Phase 3.5 via web search — see Step 3.5.2a)
```

```
AskUserQuestion:
"Strategic brief di atas sudah sesuai?"

Options:
A) Approve — lanjut ke script generation
B) Revise — ada yang perlu diubah (jelaskan)
C) Start over — mulai brainstorm dari awal
```

**Save output:** `{output_folder}/strategic-brief.md`, `{project}/cast-profile.md`

---

### Phase 2: SCRIPT GENERATION (Output: av-script.md)

**Read:** `project-instruction.md`, `F2`, `F3`, `F5`, `F6`, `F7`, `F9`, `F10`, `F11` (and `F4` if EV product)

**Language:** Write all narration/dialogue in `narration_language` from strategic-brief.md. NB2/VEO prompt structure stays English.
**Tone:** Apply `video_tone` from strategic-brief.md — reference `global-promo-config.md` Section 13 (Tone Impact Matrix) for word choice, pacing, hook style, and audio direction adjustments.

#### Step 2.1: Execute Script Engine

Follow the Phase 2 Execution Protocol from `project-instruction.md`:

1. **Awareness Level Routing** (F8) → select narrative strategy
2. **Tech-to-Value Translation** → convert features to human consequences
3. **Narrative Arc Selection** (F2) → pick from 12 video types
4. **Hook Gate Validation** (F5) → select hook, must pass "So What?" in 3s
5. **Foreshadow Design** (F7) → build anticipation
6. **Peak Design** (F7) → emotional climax placement at 60-75%
7. **Lighting Grammar** (F3) → cinematic direction per beat
8. **Audio Rules** (F3) → SFX, music, ambient direction
9. **Platform Adaptation** (F9) → adjust for selected platform

#### Step 2.2: Generate A/V Script

Output format: 3-column A/V table with beat labels

```markdown
# A/V Script — {Video Title}

## Duration: {X}s ({Y} minutes)
## Platform: {platform}
## Target: {market} — {awareness_level}

| Timecode | Video (Visual Direction) | Audio (Narration + SFX + Music) | Beat |
|----------|------------------------|--------------------------------|------|
| 0:00-0:01.7 | {visual} | {audio} | Pattern Interrupt |
| 0:01.7-0:05 | {visual} | {audio} | Hook |
| 0:05-0:08 | {visual} | {audio} | Foreshadow |
| ... | ... | ... | ... |

## CTA Execution
{specific CTA details}

## Production Notes
{key creative decisions, reference shots, mood board direction}
```

#### Step 2.3: Script Approval

```
AskUserQuestion:
"Script A/V di atas sudah sesuai?"

Options:
A) Approve — lanjut ke scene breakdown
B) Revise — ada yang perlu diubah (jelaskan bagian mana)
C) Regenerate — buat ulang dengan pendekatan berbeda
```

**Save output:** `{output_folder}/av-script.md`

---

### Phase 3: SCENE BREAKDOWN (Output: scene-plan.md)

**Read:** `script-to-scene-bridge.md`, `03-workflow-pipeline.md`, `00-index.md`

#### Step 3.1: Auto-Calculate Scene Decomposition

Follow `script-to-scene-bridge.md` Section 1:

1. Map each beat to scenes
2. Calculate VEO clip duration per scene
3. Determine VEO mode per scene (Frame / Ingredients / Extend)
4. Plan extension chains
5. Assign resolution (720p for extendable, 1080p for final-only)

#### Step 3.2: Present Scene Plan

Output the scene plan table per `script-to-scene-bridge.md` Section 2.

#### Step 3.3: Scene Plan Approval

```
AskUserQuestion:
"Scene plan di atas sudah sesuai?"

Options:
A) Approve — lanjut ke reference collection (Phase 3.5)
B) Adjust scenes — ubah pembagian scene
C) Change VEO modes — ganti mode VEO untuk scene tertentu
D) Adjust durations — ubah durasi scene
```

**Save output:** `{output_folder}/scene-plan.md`

---

### Phase 3.5: REFERENCE IMAGE COLLECTION (Output: ref-manifest.md)

**Read:** `creator-profile-system.md` (cast refs), `global-promo-config.md` (Section 11: naming, Section 12: institution)

**HARD BLOCK: Cannot proceed to Phase 4 until ALL required references are uploaded and validated.**

#### Step 3.5.1: Auto-Derive Reference Requirements

Scan `scene-plan.md` + `cast-profile.md` to build reference manifest:

```
FOR each character in cast-profile.md:
    IF role == "Pemeran Utama":
        → REQUIRE ref/cast-c{N}-face.png
        → REQUIRE ref/cast-c{N}-body.png
        → IF institution_detected: REQUIRE ref/cast-c{N}-costume.png
    IF role == "Pemeran Pendamping":
        → REQUIRE ref/cast-c{N}-face.png

FOR each scene in scene-plan.md:
    → EXTRACT unique locations → REQUIRE ref/env-{location}.png per unique location
    → IF product mentioned → REQUIRE ref/product-{name}.png (deduplicated)
    → IF brand/logo/UI visible → REQUIRE ref/brand-{asset}.png (deduplicated)

IF institution_detected:
    → REQUIRE ref/costume-{institution}.png (shared reference)
```

#### Step 3.5.2: Present Reference Manifest

Present auto-derived manifest:

```markdown
# Reference Manifest — {Video Title}

## Cast References
### Character 1: {Name} (Pemeran Utama) — FULL REF REQUIRED
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/cast-c1-face.png | Face front view | 1,2,3,5 | ⬜ |
| ref/cast-c1-body.png | Full body standing | 1,2,3,5 | ⬜ |
| ref/cast-c1-costume.png | Seragam {institution} | 1,2,3,5 | ⬜ |

### Character 2: {Name} (Pemeran Utama) — FULL REF REQUIRED
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/cast-c2-face.png | Face front view | 2,4,6 | ⬜ |
| ref/cast-c2-body.png | Full body standing | 2,4,6 | ⬜ |
| ref/cast-c2-costume.png | Seragam {institution} | 2,4,6 | ⬜ |

### Character 3: {Name} (Pemeran Pendamping) — FACE REF REQUIRED
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/cast-c3-face.png | Face front view | 4,7 | ⬜ |

## Product References — MANDATORY
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/product-{name}.png | Product hero shot | 3,5,8 | ⬜ |

## Environment References — MANDATORY
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/env-{location-1}.png | {location description} | 1,2,3 | ⬜ |
| ref/env-{location-2}.png | {location description} | 5,6,7 | ⬜ |

## Brand Assets — MANDATORY
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/brand-logo.png | Brand logo (transparent BG) | 8,9 | ⬜ |

## Costume/Uniform — MANDATORY (if institutional)
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/costume-{institution}.png | Master uniform reference | 1-7 | ⬜ |

## Validation: 0/{N} uploaded — BLOCKED
```

```
AskUserQuestion:
"Berdasarkan scene plan, kamu butuh {N} reference images. Upload semua ke folder {project}/ref/ sesuai naming di atas. Status?"

Options:
A) Sudah semua di-upload, validate
B) Mau adjust manifest (tambah/hapus item)
```

**NOTE: No skip option. No "lanjut dulu". This is a hard block.**

#### Step 3.5.2a: Cultural Location Research

For each unique location identified in scene-plan.md, perform web search per `global-promo-config.md` Section 14:

```
FOR each unique location:
    WebSearch: "{location} Indonesia kota karakteristik budaya"
    WebSearch: "{location} plat nomor kendaraan kode"
    WebSearch: "{location} arsitektur tradisional landmark"

    EXTRACT 5 essential facts:
    1. Plat kendaraan kota (e.g., BM for Dumai/Riau)
    2. Etnis dominan & ciri fisik umum
    3. Landmark ikonik
    4. Arsitektur lokal
    5. Cuaca/musim khas
```

Present findings:

```
AskUserQuestion:
"Saya sudah research cultural context untuk lokasi di video:

## Cultural Context — {Location}
| Fact | Detail |
|------|--------|
| Plat Kendaraan | {code} ({region}) |
| Etnis Dominan | {ethnicity} — {features} |
| Landmark | {landmarks} |
| Arsitektur | {style} |
| Cuaca | {climate} |

Apakah informasi ini sudah akurat?"

Options:
A) Akurat, lanjut
B) Ada yang perlu dikoreksi (jelaskan)
C) Tambah lokasi lain
```

Save to `strategic-brief.md` > Cultural Context section (replacing the placeholder from Phase 1).
Cultural details will be injected into:
- NB2 environment prompts (Step 3.5.2b and Phase 4)
- VEO scene prompts (Phase 5)

#### Step 3.5.2b: Generate NB2 Prompts for Missing References

After manifest is presented and cultural research is done, check for missing refs:

```
AskUserQuestion:
"Ada {M} reference image yang belum tersedia. Mau saya buatkan NB2 prompt supaya kamu bisa generate sendiri?"

Options:
A) Ya, generate semua prompt sekaligus
B) Ya, tapi pilih mana yang perlu prompt
C) Tidak, saya akan cari/foto sendiri
```

**If A or B → Generate batch NB2 prompts:**

Reference `global-promo-config.md` Section 15 for ref image NB2 defaults.
Reference `script-to-scene-bridge.md` Section 11 for per-category templates.

Generate prompts per category:

**Cast face:** Portrait, front view, neutral diffused lighting, studio white bg. Use ethnicity/age/features from cast-profile.md. Neutral expression. 4K, CFG 6.0, Denoise 0.40, Thinking High.

**Cast body:** Full body standing pose, wardrobe from cast-profile.md visible, neutral bg. Same technical specs as face.

**Cast costume:** Institution uniform front view, emblem/badge clearly visible. Describe emblem position and colors (don't generate actual logo). Clean bg.

**Product:** Commercial photography, hero angle, clean bg, soft commercial lighting. Describe product from strategic-brief.md.

**Environment:** Wide establishing shot. **INJECT cultural context from Step 3.5.2a:** local architecture, landmarks, license plate codes in background, weather/atmosphere. 16:9, 4K.

**Brand logo:** ⚠️ CANNOT generate. Output warning:
"Brand logo tidak bisa di-generate oleh AI dengan reliabel. Silakan provide file logo asli ke ref/brand-{name}.png"

Output all prompts in a single block:

```markdown
# NB2 Prompts untuk Missing Reference Images

## 1. ref/cast-c1-face.png — {Character Name} Face
**NB2 Prompt:**
{full prompt}

---

## 2. ref/env-{location}.png — {Location} Environment
**NB2 Prompt:**
{full prompt with cultural context injected}

---

## ⚠️ Cannot Generate (Provide Manually):
- ref/brand-logo.png — Upload actual brand logo file
```

```
AskUserQuestion:
"NB2 prompts di atas sudah siap. Copy-paste ke NB2 untuk generate, lalu save hasilnya ke folder ref/. Sudah selesai generate semua?"

Options:
A) Sudah semua, validate refs
B) Ada prompt yang perlu direvisi
C) Saya generate sebagian dulu, validate nanti
```

After user confirms → proceed to Step 3.5.3 (Validate File Existence).

#### Step 3.5.3: Validate File Existence

Check every file in manifest exists in `{project}/ref/`:

- ALL exist → Proceed to Step 3.5.4
- ANY missing → Show missing list:

```
AskUserQuestion:
"Masih ada {M} reference image yang belum di-upload:
- ref/cast-c1-body.png
- ref/env-pelabuhan.png
- ref/product-hero.png

Upload dulu ke folder {project}/ref/, lalu confirm."

Options:
A) Sudah di-upload, validate ulang
B) Mau adjust manifest
```

Repeat until 100% complete.

#### Step 3.5.4: Save & Approve Manifest

Save validated manifest to `{output_folder}/ref-manifest.md`

```
AskUserQuestion:
"Reference manifest validated ({N}/{N} complete). Lanjut ke Phase 4 (Image Prompts)?"

Options:
A) Approve — lanjut ke image prompt generation
B) Mau review manifest lagi
```

**Save output:** `{output_folder}/ref-manifest.md`

---

### Phase 4: IMAGE PROMPTS — NB2 (Output: image-prompts.md)

**Read:** `01-nb2-image-generation.md`, `04-cinematography-lookup.md`, `05-creator-and-holidays.md`, `creator-profile-system.md`

#### Step 4.1: Load Validated References

Load `ref-manifest.md` from Phase 3.5 (all references already validated — no re-check needed).

For each scene, map reference images from manifest:
- Character refs → NB2 identity lock per cast member
- Product refs → scene context
- Environment refs → First+Last Frame backgrounds
- Brand refs → logo/UI placement
- Costume refs → wardrobe direction

#### Step 4.2: Generate NB2 Prompts per Scene

For each scene in scene-plan.md:

**If Frame mode:**
- Generate START frame prompt (per `script-to-scene-bridge.md` Section 3)
- Generate END frame prompt (maintain consistency checklist)

**If Ingredients mode:**
- Generate 1-3 character reference prompts
- Front, three-quarter, profile angles

**Apply:**
- Cinematography lookup (emotion → lighting/lens/film stock)
- Apply creator reference phrase **per character** from `cast-profile.md` (verbatim)
- For multi-character scenes, use Cast Interaction Templates from `creator-profile-system.md` Section 8
- NB2 technical parameters (CFG 5-7, denoise 0.35-0.45)
- Aspect ratio matching VEO target
- Central 60% rule

#### Step 4.3: Image Prompts Approval

```
AskUserQuestion:
"Image prompts untuk semua scene sudah sesuai?"

Options:
A) Approve all — lanjut ke video prompts
B) Revise specific scenes — sebutkan nomor scene
C) Adjust cinematography — ubah mood/lighting
```

**Save output:** `{output_folder}/image-prompts.md`

---

### Phase 5: VIDEO PROMPTS — VEO 3.1 (Output: video-prompts.md)

**Read:** `02-veo-production-guide.md`, `project-instruction.md` (image-video-gen), `04-cinematography-lookup.md`

#### Step 5.1: Generate VEO Prompts per Scene

For each scene in scene-plan.md:

**Presenter scenes (lip sync):**
- Use presenter template from `script-to-scene-bridge.md` Section 4
- Dialogue with colon syntax: `Host says: {text}`
- Face >30% frame
- All 3 audio layers specified

**B-Roll scenes (voiceover):**
- Use B-Roll template from `script-to-scene-bridge.md` Section 4
- Voiceover: `Voiceover: {text}` (NOT lip sync)
- SFX + music + ambient all specified

**Extension scenes:**
- Use extension template
- Reference previous clip context
- 720p locked, same camera speed

**Transitions:**
- Add transition end instruction per `script-to-scene-bridge.md` Section 5
- Apply "Last Frame Secret" for cross-scene continuity

#### Step 5.2: Output Mode

Check `global-promo-config.md` `output_mode`:

**--full mode:** Complete production plan per `script-to-scene-bridge.md` Section 8
**--quick mode:** Copy-paste ready prompts only (NB2 + VEO per scene)

#### Step 5.3: Final Approval

```
AskUserQuestion:
"Production package sudah complete! Review final output?"

Options:
A) Approve — save semua output files
B) Revise video prompts — sebutkan scene yang perlu diubah
C) Revise audio specs — ubah dialogue/SFX/music
D) Back to scene plan — ubah pembagian scene
```

**Save output:** `{output_folder}/video-prompts.md`

#### Step 5.4: Summary

Present final summary:
- Total scenes: {N}
- Total VEO clips: {M} (generations + extensions)
- Total estimated duration: {X}s
- Output files saved to: `{output_folder}/`
- Files: strategic-brief.md, cast-profile.md, av-script.md, scene-plan.md, ref-manifest.md, image-prompts.md, video-prompts.md

---

## Quality Gates

### Script Quality Gate (Phase 2)
- [ ] All 7 beats present in arc
- [ ] No forbidden words
- [ ] Every feature has human consequence
- [ ] Hook passes "So What?" in 3 seconds
- [ ] CTA is specific, time-bound, low-friction
- [ ] Opening does NOT start with company name/logo
- [ ] No jargon without translation

### Reference Collection Quality Gate (Phase 3.5)
- [ ] All cast face refs uploaded (per role requirements)
- [ ] All cast body refs uploaded (Pemeran Utama only)
- [ ] All costume refs uploaded (if institutional)
- [ ] All product refs uploaded
- [ ] All environment refs uploaded (per unique location)
- [ ] All brand asset refs uploaded
- [ ] ref-manifest.md shows 100% validation
- [ ] Naming convention matches global-promo-config.md Section 11

### Image Prompt Quality Gate (Phase 4)
- [ ] NB2 aspect ratio matches VEO target
- [ ] CFG 5-7, Denoise 0.35-0.45
- [ ] Start/End frames share same lighting Kelvin
- [ ] Cast reference phrase verbatim per character from cast-profile.md
- [ ] Central 60% rule applied
- [ ] Thinking mode specified (minimal for draft, high for final)

### Video Prompt Quality Gate (Phase 5)
- [ ] VEO mode correct per scene (no Ingredients + Frame mix)
- [ ] All 3 audio layers specified per scene
- [ ] Dialogue uses colon syntax
- [ ] Face >30% for lip sync scenes
- [ ] 720p for extendable clips
- [ ] Extension prompts reference previous clip
- [ ] Transition instructions on scene-ending clips
- [ ] Negative prompt block included
- [ ] Total duration within target range
