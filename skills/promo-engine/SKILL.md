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
| Directing, performance, continuity | `reference/image-video-gen/06-directing-and-performance.md` |

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
11. **B-Roll voiceover = Voice-over narrator** — B-Roll uses `Voice-over narrator, [tone]: text` NOT bare `Voiceover:` (which lip-syncs to visible character). Every B-Roll MUST have VO narration + `> POST-PROD VO:` backup.
12. **Face >30% frame for lip sync** — smaller = sync failure
13. **Every feature MUST have human consequence** — no feature listing without "so what?"
14. **All AskUserQuestion interactions** — NEVER ask questions as plain text, ALWAYS use AskUserQuestion tool with selectable options
15. **Max 5 cast members** — 1-3 Pemeran Utama + 0-2 Pemeran Pendamping (NB2 identity lock limit)
16. **Phase 3.5 is HARD BLOCK** — cannot proceed to Phase 4 without ALL reference images validated in ref-manifest.md
17. **Cast ref by role** — Utama: face+body+costume(if institutional) MANDATORY. Pendamping: face MANDATORY, body/costume OPTIONAL.
18. **Narration language from Step 1.0** — script dialogue and VEO `says:` text MUST be in user's chosen language. NB2/VEO prompt structure stays English.
19. **Tone consistency** — `video_tone` from Step 1.7b MUST be applied across ALL phases: script word choice (Phase 2), cinematography (Phase 4), atmosphere (Phase 5). Reference global-promo-config.md Section 13 Tone Impact Matrix.
20. **Cultural accuracy** — when location is specified, web search MUST be performed (Step 3.5.2a) and cultural details MUST be injected into environment NB2 prompts and VEO scene prompts. Wrong license plate / wrong ethnicity / wrong architecture = rejection signal.
21. **Asset-first, scene-second** — Phase 4A generates ASSET LIBRARY (atoms: people, vehicles, objects, locations). Phase 4B generates SCENE KEYFRAMES (molecules FROM assets). Scene keyframes NEVER describe visual elements from scratch — always reference an asset file. See `global-promo-config.md` Section 17.
22. **Recurring element detection** — any visual element appearing in 2+ scenes MUST be generated as standalone asset first. Auto-detect from av-script.md scan. See `global-promo-config.md` Section 18.
23. **Auto-scan ref/ folder** — before generating ANY prompt, list ref/ folder, map every visual element to existing refs. Existing user photos = ground truth, NEVER override with text description. See `global-promo-config.md` Section 19.
24. **Aspect ratio triple enforcement** — every NB2 prompt MUST specify target ratio in FIRST line, TECHNICAL section, and LAST line. See `global-promo-config.md` Section 20.
25. **UI text localization** — on-screen text (dashboards, signage, displays) MUST match `narration_language`. Technical abbreviations stay English. See `global-promo-config.md` Section 21.
26. **Product closeup mandatory** — every product/commodity MUST have closeup reference image. User photo preferred over AI. See `global-promo-config.md` Section 22.
27. **Location photo mandatory** — every unique location MUST have reference image (user photo or AI-generated with cultural context). See `global-promo-config.md` Section 22.
28. **Output filename per prompt** — every NB2 prompt MUST include explicit `**Output →** ref/filename.png` line. See `global-promo-config.md` Section 16.
29. **Ref-to-prompt body binding** — every ref in upload table MUST have matching injection line in prompt body. Having ref in table but NOT in prompt = model won't use it. See `global-promo-config.md` Section 16.
30. **Climate-aware costume** — cross-check cast costume vs location climate after cultural research. Flag inappropriate combinations. See `global-promo-config.md` Section 23.
31. **Dynamic tier assignment** — composite assets (UI screens showing truck+face) auto-assigned to tier = max(sub-element tiers) + 1. Never generate composite before its sub-elements. See `global-promo-config.md` Section 18.
32. **VEO: No real names in `says:`** — VEO safety filter rejects real person name + photorealistic face. Use `Host says:` / `Presenter says:` / `Speaker says:`. NB2 can still use real names.
33. **VEO: No face ref filenames** — `Maintain exact facial identity from reference image: xxx.png` is NB2-only. VEO prompts use generic: `Maintain visual continuity with reference frame character appearance.`
34. **VEO: Face-dominant = single I2V** — Scene with face >30% frame → single I2V (start frame only). First+Last Frame → only for faceless scenes (dashboards, products, environments). Safety filter rejects 2 face images.
35. **VEO: No em dash in audio text** — NEVER use `—` in `says:` or `Voice-over narrator:` text. VEO audio engine mistranslates em dashes. Replace with `,` or `. `
36. **VEO: Every B-Roll has VO** — No silent B-Roll. Every B-Roll VEO prompt MUST have `Voice-over narrator, [tone]: text` + `> POST-PROD VO:` fallback line outside the prompt block.
37. **Scene Logic Realism (9-point)** — Every prompt passes 9 checks: environment accuracy, human behavior realism, data consistency, uniform ranks, explicit negatives, reference photos, timeline/shift consistency, prop/object scale accuracy, domain context populated. See `script-to-scene-bridge.md` Section 7B.
38. **Character portrait-first** — Any character in 2+ scenes MUST have standalone face portrait generated FIRST in Phase 4A. Text descriptions alone = different faces every time. Applies to cast AND recurring extras. See `global-promo-config.md` Section 18.
39. **Narrative arc consistency** — Connected scenes MUST include `NARRATIVE CONTEXT:` block naming connections, visual breadcrumbs, cause-effect chains, shared environment refs. See `script-to-scene-bridge.md` Section 7C.
40. **Location context first** — Video setting/location MUST be confirmed (Step 1.2c) BEFORE domain research. Domain knowledge is location-specific: RS Indonesia ≠ RS USA ≠ RS Japan.
41. **Domain deep research (MANDATORY, location-aware)** — AI MUST WebSearch `{domain} in {location}` BEFORE scripting (Step 1.2d). 6 queries: local process flow, local equipment brands, local workforce/PPE, local facility layout, product interface, local regulations/signage. See `global-promo-config.md` Section 24.
42. **Sequential scene dependency** — Scene N+1 start frame MUST reference Scene N end frame (`ref/scene-{NN-1}-end.png`) as upstream continuity anchor. Upload table MUST include previous scene output. No exceptions for sequential timeline scenes.
43. **Prop/object scale enforcement** — Every handheld prop or object in NB2/VEO prompts MUST include: (a) exact physical dimensions in cm/mm, (b) real-world size analogy, (c) proportion relative to human hand/body, (d) explicit negative for wrong sizes. "Small" alone is NOT sufficient.
44. **Camera angle constraint for Frame mode** — START and END frames within one VEO scene MUST have: max 1-step shot size change (CU↔MCU↔MS↔MWS↔WS) and max 15° camera angle change. Drastic camera jumps break VEO interpolation.
45. **NB2 identity lock: filename only** — `Maintain exact facial identity from reference image:` MUST use bare filename only (e.g., `cast-c1-face.png`). NEVER add folder prefix like `ref/` or `keyframes/` — NB2 matches uploaded images by filename, and `ref/cast-c1-face.png` fails to match the uploaded `cast-c1-face.png`. Same rule applies to all reference image mentions inside NB2 prompt body text.

---

## Workflow

### Phase 1: BRAINSTORM (Output: strategic-brief.md)

### CONTEXT LOADING — Phase 1
READ these files ONLY (do NOT read other reference files):
1. `reference/global-promo-config.md`
2. `reference/creator-profile-system.md`
3. `reference/storytelling_script_gen/F1_Audience_Psychology_Matrix.md`
4. `reference/storytelling_script_gen/F8_Awareness_Level_Routing.md`
Total: 4 files. Do NOT preload Phase 2-5 references.

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

#### Step 1.2c: Location & Setting Context

**Purpose:** Domain knowledge is location-specific. RS di Indonesia ≠ RS di US/China. Factory floor di Jepang ≠ di Cikarang. Location MUST be known before domain research.

```
AskUserQuestion:
"Di mana setting/lokasi video ini?"

Options:
A) Lokasi spesifik (kota/negara tertentu — misal: Surabaya, Jakarta, Shenzhen)
B) Negara saja (Indonesia, Japan, USA, dll)
C) Generic / tidak spesifik lokasi
D) Multiple lokasi (jelaskan)
```

Follow-up if A or D:
```
AskUserQuestion:
"Sebutkan detail lokasi:
- Kota/daerah: {input}
- Jenis tempat: (pabrik, kantor, rumah sakit, pelabuhan, outdoor, dll)
- Indoor/Outdoor/Both: {input}"
```

Save as `video_location`, `video_country`, `video_setting_type` in strategic-brief.md.

**Why this matters:**
- RS Indonesia: bangunan bertingkat, lorong lebar, perawat jilbab, papan nama Bahasa Indonesia, plat kendaraan lokal
- RS Jepang: bersih minimalis, kanji signage, staff berbaju putih rapi, tatami-style patient rooms
- RS Amerika: large campus, English signage, scrubs + sneakers, insurance desk, parking lot
- Same domain, completely different visuals. Location changes EVERYTHING.

#### Step 1.2d: Domain Deep Research (MANDATORY)

**Purpose:** AI is blind about specific product domains. Without domain knowledge, AI generates wrong machines, wrong processes, wrong operator actions. Domain research MUST be **location-aware** — `{domain} in {location}` not just `{domain}`.

**Trigger:** After product (Step 1.2) + institution (1.2b) + location (1.2c) are known.

**Protocol:** Use WebSearch to build location-specific domain knowledge.

```
ALGORITHM: Domain Deep Research (Location-Aware)

INPUT: product_name, product_category, product_description (from Step 1.2)
       video_location, video_country, video_setting_type (from Step 1.2c)

STEP 1: Identify the DOMAIN + LOCATION context
  → Combine industry domain + geographic context
  → Examples:
    "SMT assembly line in Cikarang Indonesia"
    "port container logistics in Dumai Riau Indonesia"
    "hospital emergency room in Jakarta Indonesia"
    "warehouse automation in Shenzhen China"

STEP 2: Execute 6 research queries (WebSearch) — ALL location-qualified

  Query 1: "{domain} in {country} production process workflow"
    → OUTPUT: How this domain operates IN THIS SPECIFIC LOCATION/COUNTRY
    → Local regulations, standards, certifications that affect workflow

  Query 2: "{domain} {country} equipment machines brands commonly used"
    → OUTPUT: What brands/models are actually used locally (not US/EU defaults)
    → CRITICAL: Indonesian factories often use different brands than US ones

  Query 3: "{domain} {country} worker roles uniforms PPE requirements"
    → OUTPUT: Local workforce — what do operators ACTUALLY wear/do here?
    → Local PPE standards, uniform styles, cultural dress norms
    → Example: Indonesian factory workers often wear batik on Fridays

  Query 4: "{domain} {location} facility layout photos"
    → OUTPUT: What do REAL local facilities look like?
    → Architecture style, building materials, interior design norms
    → Example: Indonesian RS = wide open corridors, tile floors, AC units visible

  Query 5: "{product_name} product interface dashboard features"
    → OUTPUT: What the actual product looks like in use
    → If SaaS: screens, UI language, dashboard layout
    → If physical: in-situ appearance at the specific location type

  Query 6: "{domain} {country} regulations standards signage"
    → OUTPUT: Local regulatory context affecting visuals
    → Safety signage language/style, certification marks, warning colors
    → Example: Indonesian factory = K3 safety signs in Bahasa, yellow/black hazard tape

STEP 3: Compile Location-Aware Domain Knowledge Brief

  Save to strategic-brief.md > Domain Knowledge section:

  ### Domain Knowledge — {domain} in {location}, {country}

  #### Location Context
  | Setting | Detail |
  |---------|--------|
  | Country | {country} |
  | City/Region | {city} |
  | Setting type | {factory/hospital/port/office/outdoor} |
  | Indoor/Outdoor | {indoor/outdoor/both} |
  | Local regulations | {relevant standards — K3, ISO, BPOM, etc.} |

  #### Process Flow (as practiced locally)
  {step-by-step process with LOCALLY-USED equipment at each step}

  #### Key Equipment Visual Reference (Local Brands/Models)
  | Equipment | Local Brand/Model | Appearance | Key Visual Feature |
  |-----------|------------------|-----------|-------------------|
  | {machine1} | {local brand} | {description} | {distinguishing feature} |

  #### Operator Roles & Actions (Local Workforce)
  | Role | Typical Action | Local PPE/Uniform | Tools/Equipment |
  |------|---------------|-------------------|-----------------|
  | {role1} | {what they DO locally} | {local dress norms} | {local tools} |

  #### Workspace Environment (Location-Specific)
  | Element | Local Standard | Visual Details |
  |---------|---------------|----------------|
  | Flooring | {local type} | {color, markings} |
  | Signage | {language, style} | {Bahasa/English/bilingual, K3 signs} |
  | Safety markings | {local standard} | {colors, placement per local regs} |
  | Architecture | {local style} | {building materials, ceiling type, ventilation} |

  #### Product Visual Reference
  {what the actual product looks like in this specific local context}

  #### Local Differentiators (vs generic/Western default)
  | Aspect | Generic AI Default | Actual Local Reality |
  |--------|-------------------|---------------------|
  | {aspect1} | {what AI would generate} | {what it actually looks like here} |
  | {aspect2} | {AI default} | {local reality} |
```

**Present domain research summary to user for validation:**

```
AskUserQuestion:
"Saya sudah research domain {domain} di {location}. Berikut ringkasannya:

{domain knowledge summary — location-specific equipment, process, roles, environment}

Apakah informasi ini sudah akurat untuk lokasi {location}?"

Options:
A) Akurat — lanjut
B) Ada yang salah — saya koreksi (jelaskan)
C) Saya punya info tambahan / foto referensi — saya akan paste/upload
D) Lokasi kurang spesifik — saya mau tambah detail lokasi
```

If B, C, or D → user corrects/adds info → update Domain Knowledge section.

**HARD RULE:** Location-aware domain research MUST complete before Phase 2 (Script). Script without domain knowledge = wrong equipment, wrong processes, wrong uniforms, wrong architecture for the location.

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

## Domain Knowledge
{From Step 1.2c — process flow, equipment visuals, operator roles, workspace environment, product appearance}

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

### CONTEXT LOADING — Phase 2
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 13-15 only: tone, cultural, language)
2. `reference/storytelling_script_gen/project-instruction.md`
3. `reference/storytelling_script_gen/F2_Narrative_Arc_and_Video_Typology.md`
4. `reference/storytelling_script_gen/F3_Cinematic_AV_Production_Rules.md`
5. `reference/storytelling_script_gen/F5_Hook_Vault.md`
6. `reference/storytelling_script_gen/F6_CTA_Vault.md`
7. `reference/storytelling_script_gen/F7_Foreshadow_and_Peak_Engineering.md`
8. `reference/storytelling_script_gen/F9_Platform_Adaptation_Matrix.md`
9. `reference/storytelling_script_gen/F10_Modular_Asset_and_AB_Testing.md`
10. `reference/storytelling_script_gen/F11_Pattern_Interrupt_and_Retention.md`
11. IF product is EV-related: `reference/storytelling_script_gen/F4_EV_Persona_Matrix.md`
Total: 10-11 files. This is the heaviest phase — script generation needs most references.
IMPORTANT: Do NOT load image-video-gen/ files in this phase.

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

### CONTEXT LOADING — Phase 3
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 6-10 only: output, resolution, VEO modes)
2. `reference/script-to-scene-bridge.md` (Sections 1-2 only: scene mapping, VEO mode selection)
3. `reference/image-video-gen/03-workflow-pipeline.md`
Total: 3 files. Do NOT load NB2 or storytelling files.

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

### CONTEXT LOADING — Phase 3.5
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 11-12 only: ref naming, categories)
2. `reference/creator-profile-system.md` (cast ref requirements only)
Plus: READ `{output_folder}/cast-profile.md` and `{output_folder}/scene-plan.md` as data inputs.
Total: 2 reference files + 2 output files. Do NOT load storytelling, NB2, or VEO files.

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

### Phase 4A: ASSET LIBRARY — NB2 (Output: nb2-reference-prompts.md)

### CONTEXT LOADING — Phase 4A
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 17-23: asset categories, dependency graph, NB2 defaults)
2. `reference/image-video-gen/01-nb2-image-generation.md`
3. `reference/script-to-scene-bridge.md` (Section 7B ONLY: 9-point realism checklist)
Plus: READ `{output_folder}/cast-profile.md`, `{output_folder}/scene-plan.md`, `{output_folder}/strategic-brief.md` (Domain Knowledge section only).
Total: 3 reference files + 3 output files. Do NOT load storytelling, VEO, or cinematography files.

> **CRITICAL: Assets FIRST, scenes SECOND.** This phase generates individual reusable building blocks (atoms). Phase 4B composes scene keyframes (molecules) FROM these assets. See `global-promo-config.md` Section 17.

#### Step 4A.0: Auto-Scan ref/ Folder

**PRE-CHECK — Domain Research Gate:**
CHECK `strategic-brief.md` > Domain Knowledge section.
- IF empty or contains only template placeholders → **HARD BLOCK**: "Domain research not completed. Run Step 1.2d before generating prompts."
- IF populated → extract key domain terms (equipment names, process steps, local brands) for injection into every prompt's DOMAIN CONTEXT line.

**PRE-CHECK — Phase 3.5 Asset Dedup:**
SCAN `ref/` folder for assets already generated in Phase 3.5.
- IDENTIFY existing assets by filename pattern.
- SKIP re-generation for assets that already exist and meet quality standards.
- Only generate NEW assets (recurring elements from Step 4A.1 not yet in ref/) or UPGRADE assets (Phase 3.5 used generic prompts, Phase 4A can improve with dependency-aware refs).

Before generating anything:

```
1. LIST all files in {project}/ref/
2. MAP each file to its category (cast, product, env, vehicle, object, brand, ui)
3. IDENTIFY which assets already exist (user photos = ground truth)
4. IDENTIFY which assets need AI generation
5. Present to user: "Ini asset yang sudah ada vs yang perlu di-generate"
```

#### Step 4A.1: Recurring Element Detection

Scan av-script.md for recurring visual elements:

```
FOR each visual element across ALL scenes:
  COUNT appearances
  IF count >= 2 AND no asset exists in ref/:
    → ADD to asset generation queue
    → ASSIGN to appropriate tier

PRESENT detected recurring elements:
"Detected {N} recurring visual elements that need standalone assets:
| # | Element | Appears in Scenes | Asset Needed |
|---|---------|-------------------|-------------|
| 1 | Hino dump truck | 7, 12, 13, 14 | ref/vehicle-truck-hino.png |
| 2 | Driver face | 4, 7, 12, 14 | ref/cast-c2-face.png |
| ... | ... | ... | ... |"
```

#### Step 4A.2: Build Dependency Graph

Auto-assign tiers per `global-promo-config.md` Section 18 algorithm:

```
Tier 0: User-provided assets (brand logos, user photos already in ref/)
Tier 1: Faces, standalone products, product closeups, environments, vehicles, objects
Tier 2: Bodies (inject face ref)
Tier 3: Costumes (inject face + body ref)
Tier N: Composites (inject all sub-elements — e.g., UI screens showing truck+face)
```

Present dependency graph to user for approval.

#### Step 4A.3: Generate Asset Prompts (Tier by Tier)

Follow templates from `script-to-scene-bridge.md` Section 11.

**For each tier (in order):**
1. Generate all prompts for current tier (parallel within tier)
2. Include aspect ratio triple enforcement (first line, TECHNICAL, last line)
3. Include `**Output →** ref/{filename}.png` per prompt
4. Include Required Reference Images table (upstream refs from previous tiers)
5. Include ref-to-prompt body binding (every ref in table → matching injection line in prompt)
6. Apply UI text localization if prompt contains on-screen text
7. **Wait for user to generate/upload all current tier assets**
8. Validate all current tier assets exist before advancing to next tier

#### Step 4A.4: Climate-Aware Costume Check

After cultural research and before generating costume prompts:

```
Cross-check cast costume vs location climate.
FLAG inappropriate combinations (e.g., wool suit in 33°C tropical climate).
See global-promo-config.md Section 23.
```

#### Step 4A.5: Asset Library Approval

```
AskUserQuestion:
"Asset library ({N} assets across {M} tiers) sudah lengkap. Review?"

Options:
A) Approve — lanjut ke scene keyframes (Phase 4B)
B) Regenerate specific assets
C) Add more assets
```

**Save output:** `{output_folder}/nb2-reference-prompts.md`

---

### Phase 4B: SCENE KEYFRAMES — NB2 (Output: image-prompts.md)

### CONTEXT LOADING — Phase 4B (per batch)
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 16-20: upload table, asset categories, NB2 defaults, aspect ratio)
2. `reference/image-video-gen/01-nb2-image-generation.md`
3. `reference/script-to-scene-bridge.md` (Sections 3-7 only: templates, transitions, checklists)
4. `reference/image-video-gen/04-cinematography-lookup.md`
Plus PER-BATCH context (NOT full files):
- `{output_folder}/cast-profile.md`: ONLY entries for characters appearing in this batch's scenes
- `{output_folder}/scene-plan.md`: ONLY entries for this batch's scenes
- `{output_folder}/strategic-brief.md`: Domain Knowledge section only
- Previous batch's last scene END frame filename (for dependency chain)
Total: 4 reference files + filtered output data. NEVER load storytelling or VEO files.

> **CRITICAL: Scene keyframes are MOLECULES composed FROM Phase 4A ATOMS.**
> NEVER describe a visual element from text alone if an asset exists in ref/.
> Every character, vehicle, object, product, environment MUST reference its asset file.

#### Step 4B.1: Load All Assets

Load all assets from ref/ (Phase 4A output + user photos + user-provided files).
Build scene-to-asset mapping from scene-plan.md.

#### Step 4B.2: Batch-by-ACT Generation

**BATCH EXECUTION — max 5 scenes per batch.**

Group scenes by ACT from scene-plan.md. Each ACT = 1 batch. If an ACT has >5 scenes, split into sub-batches of max 5.

```
FOR each batch (ACT or sub-batch):

  1. CONTEXT RELOAD (fresh per batch):
     → Re-read Phase 4B CONTEXT LOADING files
     → Load ONLY this batch's cast entries + scene entries
     → Load previous batch's LAST scene END frame filename as dependency anchor

  2. GENERATE prompts for this batch's scenes:
     FOR each scene in this batch:

       **If Frame mode:**
       - Generate START frame prompt (per `script-to-scene-bridge.md` Section 3)
       - Generate END frame prompt (maintain consistency checklist)
       - **Every visual element MUST reference its asset file** — no text-only descriptions

       **If Ingredients mode:**
       - Generate 1-3 character reference prompts
       - Front, three-quarter, profile angles

       **Apply:**
       - Cinematography lookup (emotion → lighting/lens/film stock)
       - Apply creator reference phrase **per character** from `cast-profile.md` (verbatim)
       - For multi-character scenes, use Cast Interaction Templates from `creator-profile-system.md` Section 8
       - NB2 technical parameters (CFG 5-7, denoise 0.35-0.45)
       - **Aspect ratio triple enforcement** (first line, TECHNICAL, last line)
       - Central 60% rule
       - **`Output →` filename** per prompt (ref/scene-{NN}-start.png, ref/scene-{NN}-end.png)
       - **Ref-to-prompt body binding** — every ref in upload table MUST have matching line in prompt
       - **UI text localization** — on-screen text in narration language
       - **Scale/dimension specification** — every visible prop and object MUST have real-world dimensions in the prompt (cm/mm + visual analogy + proportion to hand + negative for wrong size)
       - **Wardrobe verbatim consistency** — pull EXACT costume text from cast-profile.md or Character Costume Tracking Table (Section 7D of script-to-scene-bridge.md). NEVER paraphrase. If character appears in 3+ scenes, the costume text string MUST be identical across all prompts.
       - **Previous scene continuity injection** — for scenes 2+ in timeline, inject `scene-{NN-1}-end.png` as first reference image in prompt body text (filename only, NO `ref/` prefix) and include in upload table

     END FOR

  3. VALIDATE — spawn prompt-reviewer agent:
     → Agent tool: subagent_type="ai-video-promo-engine:prompt-reviewer"
     → Pass: this batch's generated prompts + cast-profile.md + scene-plan.md
     → Agent returns: PASS / FAIL with per-prompt feedback

  4. IF validator returns FAIL:
     → Read validator feedback (specific prompts + specific issues)
     → Re-generate ONLY the failing prompts (not entire batch)
     → Re-validate (max 2 retry cycles per batch)

  5. APPROVE — AskUserQuestion:
     "Batch {N} ({ACT name}, Scenes {X}-{Y}) ready for review."
     A) Approve batch — proceed to next batch
     B) Revise specific scenes — list scene numbers
     C) Regenerate entire batch — start fresh

  6. APPEND approved batch to {output_folder}/image-prompts.md

END FOR
```

Write the Generation Checklist and Dependency Chain table AFTER all batches complete.

#### Step 4B.3: Final Review

After ALL batches are generated and approved:
1. Read the complete `{output_folder}/image-prompts.md`
2. Verify cross-batch dependency chain integrity (Scene N→N+1 references correct across batch boundaries)
3. Present summary:
   - Total batches: {N}
   - Total scenes: {M}
   - Validator pass rate: {X}% first-pass, {Y}% after retry
4. AskUserQuestion: final approval or revision

**Save output:** `{output_folder}/image-prompts.md`

---

### Phase 5: VIDEO PROMPTS — VEO 3.1 (Output: video-prompts.md)

### CONTEXT LOADING — Phase 5 (per batch)
READ these files ONLY:
1. `reference/global-promo-config.md` (Sections 6-10, 13: output, resolution, VEO modes, tone)
2. `reference/image-video-gen/02-veo-production-guide.md`
3. `reference/image-video-gen/03-workflow-pipeline.md`
4. `reference/image-video-gen/04-cinematography-lookup.md`
Plus PER-BATCH context:
- `{output_folder}/cast-profile.md`: ONLY entries for characters in this batch
- `{output_folder}/scene-plan.md`: ONLY entries for this batch's scenes
- `{output_folder}/av-script.md`: ONLY the AV rows for this batch's scenes
- `{output_folder}/image-prompts.md`: ONLY the prompts for this batch's scenes (as NB2→VEO reference)
Total: 4 reference files + filtered output data. NEVER load storytelling or NB2-specific files.

#### Step 5.1: Batch-by-ACT VEO Generation

**BATCH EXECUTION — max 5 scenes per batch.**

Same ACT grouping as Phase 4B.

```
FOR each batch (ACT or sub-batch):

  1. CONTEXT RELOAD (fresh per batch):
     → Re-read Phase 5 CONTEXT LOADING files
     → Load ONLY this batch's scene entries + cast entries + AV script rows
     → Load this batch's NB2 keyframes from image-prompts.md (as NB2→VEO reference)

  2. GENERATE VEO prompts for this batch's scenes:
     FOR each scene in this batch:

       **Presenter scenes (lip sync):**
       - Use presenter template from `script-to-scene-bridge.md` Section 4
       - VEO mode: Single I2V (start frame only) — NOT First+Last Frame (safety filter)
       - Dialogue: `Host says: {text}` — NEVER real person names (safety filter)
       - NO em dash `—` in dialogue — replace with `,` or `. `
       - NO face ref filenames in VEO prompt — use generic continuity language
       - Face >30% frame
       - All 3 audio layers specified

       **B-Roll scenes (voiceover):**
       - Use B-Roll template from `script-to-scene-bridge.md` Section 4
       - Voiceover: `Voice-over narrator, {tone}: {text}` — NOT bare `Voiceover:` (lip-syncs to visible char)
       - NO em dash `—` in voiceover text
       - EVERY B-Roll MUST have voiceover narration (no silent B-Roll)
       - Add `> POST-PROD VO:` backup line outside prompt block for every B-Roll
       - SFX + music + ambient all specified

       **Extension scenes:**
       - Use extension template
       - Reference previous clip context
       - 720p locked, same camera speed

       **Transitions:**
       - Add transition end instruction per `script-to-scene-bridge.md` Section 5
       - Apply "Last Frame Secret" for cross-scene continuity

     END FOR

  3. VALIDATE — spawn prompt-reviewer agent:
     → Agent tool: subagent_type="ai-video-promo-engine:prompt-reviewer"
     → Pass: this batch's VEO prompts + scene-plan.md + image-prompts.md (this batch only)
     → Agent returns: PASS / FAIL with per-prompt feedback

  4. IF FAIL → re-generate failing prompts only (max 2 retries)

  5. APPROVE — AskUserQuestion:
     "Batch {N} ({ACT name}, Scenes {X}-{Y}) VEO prompts ready for review."
     A) Approve batch — proceed to next batch
     B) Revise specific scenes — list scene numbers
     C) Regenerate entire batch — start fresh

  6. APPEND to {output_folder}/video-prompts.md

END FOR
```

#### Step 5.2: Output Mode

Check `global-promo-config.md` `output_mode`:

**--full mode:** Complete production plan per `script-to-scene-bridge.md` Section 8
**--quick mode:** Copy-paste ready prompts only (NB2 + VEO per scene)

#### Step 5.3: Final Review

After ALL batches are generated and approved:
1. Read the complete `{output_folder}/video-prompts.md`
2. Verify cross-batch continuity (transition instructions link correctly across batch boundaries)
3. Verify NB2→VEO consistency (each VEO prompt references correct NB2 keyframe)
4. Present summary:
   - Total batches: {N}
   - Total scenes: {M}
   - Total VEO clips: {P} (generations + extensions)
   - Total estimated duration: {X}s
   - Validator pass rate: {Y}% first-pass, {Z}% after retry
5. AskUserQuestion: final approval or revision

**Save output:** `{output_folder}/video-prompts.md`

#### Step 5.4: Production Summary

Present final production package summary:
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

### Asset Library Quality Gate (Phase 4A)
- [ ] Auto-scan ref/ folder completed before generating any prompt
- [ ] Recurring elements (2+ scenes) detected and queued as standalone assets
- [ ] Dependency graph built with correct tier assignments
- [ ] Composites (UI screens, etc.) assigned tier = max(sub-element tiers) + 1
- [ ] Each tier fully validated before advancing to next tier
- [ ] Product closeup reference exists for every product/commodity
- [ ] Location reference exists for every unique location
- [ ] User photos used as ground truth (not overridden by AI generation)
- [ ] Climate-aware costume check completed
- [ ] Brand logos are user-provided (not AI-generated)
- [ ] Domain Knowledge section in strategic-brief.md populated with real research (not template placeholders)
- [ ] Phase 3.5 assets audited — no duplicate generation

### Scene Keyframe Quality Gate (Phase 4B)
- [ ] NB2 aspect ratio triple enforcement (first line, TECHNICAL, last line)
- [ ] CFG 5-7, Denoise 0.35-0.45
- [ ] Start/End frames share same lighting Kelvin
- [ ] Cast reference phrase verbatim per character from cast-profile.md
- [ ] Central 60% rule applied
- [ ] Thinking mode specified (minimal for draft, high for final)
- [ ] EVERY visual element references its asset file (no text-only descriptions for recurring elements)
- [ ] Output filename specified per prompt (`ref/scene-{NN}-start.png`)
- [ ] Every ref in upload table has matching injection line in prompt body
- [ ] UI text localized per narration_language (except technical abbreviations)
- [ ] DOMAIN CONTEXT line in every prompt contains specific local equipment/process details (not generic)
- [ ] Every prop/object has explicit scale specification (dimensions + analogy + negative)
- [ ] Previous scene end frame referenced in upload table and prompt body (for scenes 2+)
- [ ] Camera angle between start/end max 15° change, shot size max 1 step
- [ ] Aspect ratio specified in ALL prompts (NB2: triple enforcement; VEO: first + last line)
- [ ] NB2 identity lock uses filename only — NO `ref/` or other folder prefix in `Maintain exact facial identity from reference image:` lines or any reference image mention inside prompt body text

### Video Prompt Quality Gate (Phase 5)
- [ ] VEO mode correct per scene (no Ingredients + Frame mix)
- [ ] Face-dominant scenes use single I2V (NOT First+Last Frame)
- [ ] All 3 audio layers specified per scene
- [ ] Dialogue uses generic role: `Host says:` — no real person names
- [ ] Voiceover uses `Voice-over narrator, [tone]: text` — no bare `Voiceover:`
- [ ] Every B-Roll scene has voiceover narration + `> POST-PROD VO:` backup
- [ ] No em dash `—` in any `says:` or `Voice-over narrator:` text
- [ ] No face ref filenames (`ref/cast-c{N}-face.png`) in VEO prompts
- [ ] Face >30% for lip sync scenes
- [ ] 720p for extendable clips
- [ ] Extension prompts reference previous clip
- [ ] Transition instructions on scene-ending clips
- [ ] Negative prompt block included
- [ ] Total duration within target range

### Cross-Cutting Quality Gate (All Phases 4-5)
- [ ] **Scene Logic Realism 9-point** — each prompt passes: environment accuracy, behavior realism, data consistency, uniform ranks, explicit negatives, ref photos, timeline/shift, prop/object scale accuracy, domain context populated
- [ ] **Character portrait-first** — every character in 2+ scenes has standalone face ref in Phase 4A
- [ ] **Narrative arc consistency** — every prompt has `NARRATIVE CONTEXT:` block with connections, breadcrumbs, cause-effect
- [ ] **Visual breadcrumbs** — at least 1 shared visual element between adjacent scenes
- [ ] **Data pinning** — dashboard names/numbers consistent across all scenes showing same data
- [ ] **Timeline consistency** — time-of-day/lighting matches across connected scenes
- [ ] **Wardrobe tracking** — Character Costume Tracking Table built, each character's costume text verbatim identical across all scenes (unless script-directed change with justification)
- [ ] **Sequential dependency chain** — every scene N+1 references scene N end frame output in both upload table and prompt body
