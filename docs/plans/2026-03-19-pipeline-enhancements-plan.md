> **For Claude:** REQUIRED SKILL: Use gaspol-execute to implement this plan.
> **CRITICAL:** This plan modifies reference documents that form the RAG knowledge base.
> Every edit must preserve existing functionality while adding new capabilities.
> If a section's intent is unclear, STOP and ask — never guess.

## Goal

Add 5 pipeline enhancements to the promo-engine: (1) Language Selection for narration/VO, (2) User Storyline Input with 7-beat arc mapping, (3) Batch NB2 Prompt Generation for missing reference images, (4) Cultural Location Web Search for accuracy (license plates, ethnicity, landmarks, architecture, weather), (5) Tone/Mood Selection affecting cinematography, audio, and expression across all phases.

## Architecture Context

From CLAUDE.md v1.1.0:
- **Pipeline:** 6-phase (1 → 2 → 3 → 3.5 → 4 → 5) with cast system + Phase 3.5 ref gate
- **Phase 1 current flow:** Steps 1.1 (Cast) → 1.2 (Product) → 1.2b (Institution) → 1.3 (Market) → 1.4 (Awareness) → 1.5 (Platform) → 1.6 (Emotional Core) → 1.7 (Storyline Discussion) → 1.8 (Strategic Brief)
- **Phase 3.5 current flow:** Steps 3.5.1 (Auto-derive) → 3.5.2 (Present manifest) → 3.5.3 (Validate) → 3.5.4 (Save)
- **Config:** `global-promo-config.md` — Section 1 already has `narration_language: Per user preference` but no mechanism to ask
- **Tools available:** `AskUserQuestion`, `WebSearch` — both available to the skill at runtime
- **Ref prompt generation:** NB2 templates exist in `script-to-scene-bridge.md` Sections 3/9 but only for scene images, not for ref images

## Tech Stack

Pure markdown reference documents. No code. "Tests" = `/promo-validate` consistency checks.

## Data Integration Map

| Feature | Data Source | File | Exists? | Action |
|---------|-----------|------|---------|--------|
| Language selection UI | `AskUserQuestion` Step 1.0 | `skills/promo-engine/SKILL.md` | NO | **Create** new Step 1.0 |
| Language config | `global-promo-config.md` Section 1 | `reference/global-promo-config.md` | PARTIAL (`narration_language` exists but says "Per user preference") | **Update** with concrete options + add to strategic-brief template |
| Storyline input flow | `AskUserQuestion` Step 1.7 | `skills/promo-engine/SKILL.md` | YES (AI-driven only) | **Rewrite** to accept user freeform + 7-beat mapping |
| 7-beat arc mapping | `storytelling_script_gen/project-instruction.md` | `reference/storytelling_script_gen/project-instruction.md` | YES | Reference only — no modification needed |
| Tone selection UI | `AskUserQuestion` Step 1.7b | `skills/promo-engine/SKILL.md` | NO | **Create** new Step 1.7b |
| Tone config | `global-promo-config.md` | `reference/global-promo-config.md` | NO | **Add** new Section 13: Tone/Mood System |
| Tone → cinematography mapping | `script-to-scene-bridge.md` | `reference/script-to-scene-bridge.md` | NO | **Add** new Section 10: Tone Mapping |
| Cultural web search | `WebSearch` tool at Phase 3.5 | `skills/promo-engine/SKILL.md` | NO | **Add** Step 3.5.2a |
| Cultural context storage | `strategic-brief.md` template | `skills/promo-engine/SKILL.md` | PARTIAL (template exists) | **Expand** brief template with Cultural Context section |
| Cultural → NB2 injection | `script-to-scene-bridge.md` NB2 templates | `reference/script-to-scene-bridge.md` | PARTIAL (env template exists) | **Add** cultural detail fields |
| Ref prompt generation (batch) | NB2 prompt templates per ref category | `skills/promo-engine/SKILL.md` | NO | **Add** Step 3.5.2b with 6 category templates |
| Ref prompt templates | Simplified NB2 templates for refs | `reference/script-to-scene-bridge.md` | NO | **Add** Section 11: Ref Image Prompt Templates |
| Agent awareness | `agents/promo-engine-agent.md` | `agents/promo-engine-agent.md` | NO | **Add** capabilities + web search |
| Validation checks | `promo-validate/SKILL.md` | `skills/promo-validate/SKILL.md` | YES (11 checks) | **Add** checks 12-13 |

## Phase Structure

---

### Phase A: Global Config — Language, Tone, Cultural Search Settings

**Estimated time:** 5 minutes

**Files:**
- Modify: `reference/global-promo-config.md`

**Steps:**
1. Read `reference/global-promo-config.md` (in context)
2. Update Section 1 (Language): change `narration_language` from "Per user preference (asked during brainstorm)" to concrete options table, add `prompt_language` setting
3. Add Section 13: Tone/Mood System — 6 tone options with per-phase impact mapping
4. Add Section 14: Cultural Location Research — search config, essential facts checklist, injection points
5. Add Section 15: Ref Image Prompt Generation — NB2 defaults for ref images (vs scene images)
6. Bump `config_version` to `1.2.0`

**Section 1 update:**

```markdown
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
```

**Section 13 content:**

```markdown
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
```

**Section 14 content:**

```markdown
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

```
FOR each unique location:
    WebSearch query 1: "{location} Indonesia kota karakteristik budaya"
    WebSearch query 2: "{location} plat nomor kendaraan kode"
    WebSearch query 3: "{location} arsitektur tradisional landmark"
    EXTRACT 5 essential facts
    SAVE to strategic-brief.md > Cultural Context section
```

### Cultural Context Output Template

```markdown
## Cultural Context — {Location}

| Fact | Detail | Source |
|------|--------|--------|
| Plat Kendaraan | {code} ({region}) | Web search |
| Etnis Dominan | {ethnicity} — {physical features} | Web search |
| Landmark | {list} | Web search |
| Arsitektur | {style} | Web search |
| Cuaca | {climate} | Web search |
```
```

**Section 15 content:**

```markdown
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
| Cast face | Front view, ethnicity, age, features, neutral expression | — (AI can generate) |
| Cast body | Standing pose, full wardrobe visible, neutral bg | — (AI can generate) |
| Cast costume | Front view, institution-specific, emblem/badge detail | Actual institution logo/badge (describe instead) |
| Product | Hero angle, commercial lighting, clean bg | Real product photo if physical product |
| Environment | Wide establishing shot, cultural details, time of day | — (AI can generate with cultural context) |
| Brand logo | N/A | MUST be provided by user (AI cannot reliably generate logos) |
```

**Verification:**
- [ ] Section 1 has Language Options table with 3 options + impact per output type
- [ ] Section 1 has `prompt_language = English` (fixed, not selectable)
- [ ] Section 13 has 6 tone options with Tone Impact Matrix
- [ ] Section 14 has 5-fact checklist, search strategy, output template
- [ ] Section 15 has ref vs scene NB2 defaults table + 6 category strategies
- [ ] `config_version` updated to `1.2.0`
- [ ] No placeholders, TODOs, or TBDs

---

### Phase B: SKILL.md — Language, Storyline, Tone Steps + Phase 3.5 Enhancements

**Estimated time:** 10 minutes

**Files:**
- Modify: `skills/promo-engine/SKILL.md`

**Steps:**

1. **Add Step 1.0: Language Selection** — insert BEFORE current Step 1.1 (Cast Setup):

```markdown
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
```

2. **Rewrite Step 1.7: Storyline Input** — replace current AI-driven discussion with:

```markdown
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

1. Parse storyline against the 7-beat arc (per `project-instruction.md`):
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

3. For missing beats, AI suggests additions:

```
AskUserQuestion:
"Storyline kamu sudah cover {X}/8 beats. Saya suggest tambahan untuk beat yang missing:

- Foreshadow: {suggestion based on storyline context}
- Peak: {suggestion for emotional climax}
- Won Day: {suggestion for future-state visualization}

Approve suggestions?"

Options:
A) Approve semua suggestions
B) Approve sebagian (pilih mana)
C) Saya mau revise storyline sendiri
D) Skip — biarkan AI lengkapi nanti di Phase 2
```

**If B (brainstorm from scratch):**

Engage user in guided discussion via AskUserQuestion:
- Key pain points of target audience
- Unique selling proposition
- Competitor landscape
- Success stories / case studies
- Desired CTA (what should viewer DO?)

**If C (reference video):**

User describes or shares reference. AI:
1. Extract narrative structure from description
2. Map to 7-beat arc
3. Adapt to user's product/context
4. Present adapted storyline for approval
```

3. **Add Step 1.7b: Tone/Mood Selection** — insert after Step 1.7:

```markdown
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
```

4. **Update Step 1.8: Strategic Brief template** — add `narration_language`, `video_tone`, and `Cultural Context` placeholder section:

```markdown
## Language: {narration_language}
## Tone: {video_tone}
```

Add to brief template. Also add section for cultural context (populated later in Phase 3.5):

```markdown
## Cultural Context
(Populated in Phase 3.5 via web search — see Step 3.5.2a)
```

5. **Add Step 3.5.2a: Cultural Web Search** — insert after Step 3.5.2 (Present manifest), before 3.5.3:

```markdown
#### Step 3.5.2a: Cultural Location Research

For each unique location identified in scene-plan.md, perform web search per `global-promo-config.md` Section 14:

```
FOR each unique location:
    WebSearch: "{location} Indonesia kota karakteristik budaya"
    WebSearch: "{location} plat nomor kendaraan kode"
    WebSearch: "{location} arsitektur tradisional landmark"

    EXTRACT 5 essential facts:
    1. Plat kendaraan kota
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
| Plat Kendaraan | {code} |
| Etnis Dominan | {ethnicity} |
| Landmark | {landmarks} |
| Arsitektur | {style} |
| Cuaca | {climate} |

Apakah informasi ini sudah akurat?"

Options:
A) Akurat, lanjut
B) Ada yang perlu dikoreksi (jelaskan)
C) Tambah lokasi lain
```

Save to `strategic-brief.md` > Cultural Context section.
Cultural context will be injected into NB2 environment prompts (Step 3.5.2b) and VEO scene prompts (Phase 5).
```

6. **Add Step 3.5.2b: Batch NB2 Ref Prompt Generation** — insert after 3.5.2a, before 3.5.3:

```markdown
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

**If A or B → Generate batch NB2 prompts per category:**

Reference `global-promo-config.md` Section 15 for ref image NB2 defaults.
Reference `script-to-scene-bridge.md` Section 11 for per-category templates.

For each missing ref, generate appropriate prompt:

**Cast face/body:** Use cast-profile.md character description. Neutral bg, diffused lighting, 4K.
**Cast costume:** Use institution from cast-profile.md. Front view, emblem visible. If brand logo needed on costume, describe position/color (don't generate logo).
**Product:** Commercial photography style. If user has no photo of physical product, describe product from strategic-brief.md.
**Environment:** Use cultural context from Step 3.5.2a. Include local architecture, weather, landmarks, license plate codes in background.
**Brand logo:** CANNOT generate — instruct user: "Brand logo tidak bisa di-generate oleh AI. Silakan provide file logo asli ke ref/brand-logo.png"

Output all prompts in a single block:

```markdown
# NB2 Prompts untuk Missing Reference Images

## 1. ref/cast-c1-face.png — {Character Name} Face
**NB2 Prompt:**
{full prompt}

## 2. ref/env-{location}.png — {Location} Environment
**NB2 Prompt:**
{full prompt with cultural context injected}

## 3. ref/product-hero.png — {Product Name}
**NB2 Prompt:**
{full prompt}

...

## ⚠️ Cannot Generate (Provide Manually):
- ref/brand-logo.png — Upload actual brand logo file
```

```
AskUserQuestion:
"NB2 prompts di atas sudah siap. Copy-paste ke NB2 untuk generate, lalu save hasilnya ke folder ref/. Sudah selesai generate?"

Options:
A) Sudah, validate semua refs
B) Ada prompt yang perlu direvisi
C) Saya generate sebagian dulu
```

Proceed to Step 3.5.3 (Validate) after user confirms.
```

7. **Update Phase 2 intro** — add note that script language follows `narration_language` and tone follows `video_tone`:

After "#### Step 2.1: Execute Script Engine", add:
```
**Language:** Write narration/dialogue in `narration_language` from strategic-brief.md.
**Tone:** Apply `video_tone` from strategic-brief.md — reference `global-promo-config.md` Section 13 for word choice, pacing, hook style adjustments.
```

8. **Add Hard Rule 18:**

```
18. **Narration language from Step 1.0** — script dialogue and VEO `says:` text MUST be in user's chosen language. NB2/VEO prompt structure stays English.
```

9. **Add Hard Rule 19:**

```
19. **Tone consistency** — `video_tone` from Step 1.7b MUST be applied across ALL phases: script word choice (Phase 2), cinematography (Phase 4), atmosphere (Phase 5). Reference global-promo-config.md Section 13 Tone Impact Matrix.
```

10. **Add Hard Rule 20:**

```
20. **Cultural accuracy** — when location is specified, web search MUST be performed (Step 3.5.2a) and cultural details MUST be injected into environment NB2 prompts and VEO scene prompts. Wrong license plate / ethnicity / architecture = rejection.
```

**Verification:**
- [ ] Step 1.0 exists before Step 1.1 with 3 language options
- [ ] Step 1.7 rewritten with 3 storyline input modes (freeform, brainstorm, reference)
- [ ] Step 1.7 Option A has 7-beat arc mapping + missing beat suggestions
- [ ] Step 1.7b exists with 6 tone options
- [ ] Step 1.8 strategic brief template has `Language:` and `Tone:` fields + Cultural Context placeholder
- [ ] Step 3.5.2a exists with web search + 5-fact extraction + AskUserQuestion confirmation
- [ ] Step 3.5.2b exists with batch NB2 prompt gen + 6 category handling + brand logo warning
- [ ] Phase 2 intro mentions narration_language and video_tone
- [ ] Hard Rules 18, 19, 20 present
- [ ] All AskUserQuestion blocks have selectable options

---

### Phase C: Script-to-Scene Bridge — Tone Mapping + Ref Prompt Templates + Cultural Injection

**Estimated time:** 10 minutes

**Files:**
- Modify: `reference/script-to-scene-bridge.md`

**Steps:**

1. **Add Section 10: Tone-to-Cinematography Mapping** — after existing Section 9 (Ref Manifest):

Full tone → cinematography lookup table per `global-promo-config.md` Section 13. This is the operational reference for Phase 4 (NB2) and Phase 5 (VEO) to adjust visuals per selected tone.

2. **Add Section 11: Ref Image NB2 Prompt Templates** — after Section 10:

6 prompt templates (cast face, cast body, cast costume, product, environment, brand logo warning). Each template includes:
- Subject line with category-specific details
- Camera/lens/lighting (neutral for refs, not dramatic)
- Technical params from `global-promo-config.md` Section 15
- Cultural injection point (for environment only)

Example environment ref template:
```
SUBJECT: Wide establishing shot of {location}, {region}, Indonesia.
{cultural_architecture from strategic-brief.md Cultural Context}.
{cultural_landmarks visible in background}.
Vehicles with {cultural_plate_code}-series license plates in background.
{cultural_weather — e.g., "tropical humid atmosphere, equatorial sun"}.
CAMERA: Wide shot, 24mm f/8, eye-level.
LIGHTING: Natural {time_of_day} light, {kelvin}K.
ATMOSPHERE: {cultural_climate_atmosphere}.
TECHNICAL: {aspect_ratio}, 4K, CFG 6.0, Denoise 0.40, Thinking High.
```

3. **Update Section 3 NB2 templates** — add cultural context injection field to environment frame templates:

In the "Start Frame Template" for B-Roll environments, add:
```
CULTURAL CONTEXT: {from strategic-brief.md — architecture, landmarks, plate codes}
```

4. **Update Section 4 VEO templates** — add tone atmosphere and cultural context:

In B-Roll VEO template, add:
```
Tone atmosphere: {from global-promo-config.md Section 13 per video_tone}.
Cultural context: {from strategic-brief.md — local ambient sounds, weather}.
```

**Verification:**
- [ ] Section 10 exists with tone → cinematography mapping for all 6 tones
- [ ] Section 11 exists with 6 ref image prompt templates
- [ ] Section 11 environment template has cultural injection points
- [ ] Section 11 brand logo entry says "CANNOT generate, user must provide"
- [ ] Section 3 NB2 frame templates have CULTURAL CONTEXT field
- [ ] Section 4 VEO templates have tone atmosphere + cultural context fields
- [ ] All templates use consistent naming (`ref/cast-c{N}`, `ref/env-{location}`, etc.)

---

### Phase D: Agent — Language, Tone, Web Search, Ref Prompt Capabilities

**Estimated time:** 5 minutes

**Files:**
- Modify: `agents/promo-engine-agent.md`

**Steps:**
1. Add capabilities 11-13:
```
11. Language selection for narration/VO (Bahasa Indonesia, English, Bilingual)
12. Tone/mood selection affecting cinematography, audio, and expression across all phases
13. Cultural location web search for accuracy (license plates, ethnicity, landmarks, architecture, weather)
14. Batch NB2 prompt generation for missing reference images
```

2. Add hard rules 15-17:
```
15. **Narration language** — dialogue/VO in user's chosen language, NB2/VEO prompts stay English
16. **Tone consistency** — video_tone applied across ALL phases per global-promo-config.md Section 13
17. **Cultural accuracy** — web search required for locations, cultural details injected into prompts
```

3. Update workflow notes:
- Phase 1 now starts with Step 1.0 (Language Selection)
- Phase 1 includes Step 1.7 (Storyline Input) and Step 1.7b (Tone Selection)
- Phase 3.5 includes Steps 3.5.2a (Cultural Search) and 3.5.2b (Ref Prompt Gen)

**Verification:**
- [ ] Capabilities 11-14 present
- [ ] Hard Rules 15-17 present
- [ ] Workflow mentions language, tone, cultural search, ref prompt gen

---

### Phase E: Validator — Add Checks 12-13

**Estimated time:** 5 minutes

**Files:**
- Modify: `skills/promo-validate/SKILL.md`

**Steps:**
1. Update frontmatter: "11 checks" → "13 checks"
2. Add Check 12: Language Consistency
3. Add Check 13: Tone System Consistency
4. Update output format: 13/13

**Check 12:**
```markdown
### Check 12: Language Selection Consistency
**Pattern:** Language handling across pipeline files
**Expected:** SKILL.md has Step 1.0 Language Selection. global-promo-config.md Section 1 has language options table. Agent.md mentions language capability. Strategic brief template has `Language:` field. Phase 2 references narration_language for script writing.
**How to verify:**
1. Search SKILL.md for "Step 1.0" and "Language Selection"
2. Search global-promo-config.md for "Language Options"
3. Search agent.md for "language" capability
4. Verify SKILL.md Phase 2 mentions narration_language
```

**Check 13:**
```markdown
### Check 13: Tone System Consistency
**Pattern:** Tone handling across pipeline files
**Expected:** SKILL.md has Step 1.7b Tone Selection with 6 options. global-promo-config.md Section 13 has Tone Impact Matrix. script-to-scene-bridge.md has tone-to-cinematography mapping. Agent.md mentions tone capability. Strategic brief template has `Tone:` field.
**How to verify:**
1. Search SKILL.md for "Step 1.7b" and "Tone"
2. Search global-promo-config.md for "Tone Impact Matrix"
3. Search script-to-scene-bridge.md for "Tone" mapping section
4. Verify same 6 tone options in SKILL.md and global-promo-config.md
```

**Verification:**
- [ ] Frontmatter says "13 checks"
- [ ] Check 12 and 13 exist with Pattern/Expected/How to verify
- [ ] Output format shows 13/13

---

### Phase F: CLAUDE.md — Full Documentation Sync

**Estimated time:** 10 minutes

**Files:**
- Modify: `CLAUDE.md`

**Steps:**
1. Update Phase 1 pipeline diagram: add Step 1.0 (Language), rewritten Step 1.7 (Storyline Input), Step 1.7b (Tone)
2. Update Phase 3.5 pipeline diagram: add Steps 3.5.2a (Cultural Search) and 3.5.2b (Ref Prompt Gen)
3. Add new section: "Language Selection" — narration language affects dialogue, VO stays English
4. Add new section: "Tone/Mood System" — 6 options, impact matrix summary, references to config Section 13
5. Add new section: "Cultural Location Research" — web search behavior, 5-fact checklist, injection points
6. Add new section: "Ref Image Prompt Generation" — batch NB2 prompts for missing refs, category strategies, brand logo exception
7. Update Interactive Flow section: add Step 1.0, 1.7 rewritten, 1.7b, 3.5.2a, 3.5.2b
8. Update Capabilities list: add items 11-14
9. Update Technical Defaults table: add language, tone, cultural search, ref prompt gen settings
10. Update Debugging table: add language/tone/cultural error entries
11. Update version to 1.2.0

**New debugging entries:**
```
| Wrong language in dialogue | narration_language not applied | Check strategic-brief.md Language field, ensure Phase 2 uses it |
| Tone inconsistent across scenes | video_tone not applied | Reference global-promo-config.md Section 13 Tone Impact Matrix |
| Wrong license plate in scene | Missing cultural research | Run Step 3.5.2a web search for location |
| Wrong ethnicity for extras | No cultural context | Check strategic-brief.md Cultural Context, inject into NB2 prompts |
| AI can't generate brand logo | Logo generation unreliable | Brand logo MUST be provided by user, not AI-generated |
| Missing beats in storyline | User storyline incomplete | Step 1.7 maps to 7-beat arc, AI suggests missing beats |
```

**Verification:**
- [ ] Phase 1 diagram shows Steps 1.0, 1.7 (rewritten), 1.7b
- [ ] Phase 3.5 diagram shows Steps 3.5.2a, 3.5.2b
- [ ] Language Selection section exists
- [ ] Tone/Mood System section exists with 6 options
- [ ] Cultural Location Research section exists with 5-fact list
- [ ] Ref Image Prompt Generation section exists with category strategies
- [ ] Capabilities 11-14 present
- [ ] Debugging table has 6 new entries
- [ ] Version 1.2.0

---

## Execution Dependencies

```
Phase A (global config) ──────┐
                               ├──→ Phase B (SKILL.md)
                               ├──→ Phase C (bridge)
                               └──→ Phase D (agent)

All A-D complete ──→ Phase E (validator)
All A-E complete ──→ Phase F (CLAUDE.md)
```

**Parallelizable:** Phase B + Phase C + Phase D (after A, all independent files)

## Final Verification (After All Phases)

- [ ] Run `/promo-validate` — all 13 checks pass
- [ ] Step 1.0 Language Selection in SKILL.md
- [ ] Step 1.7 Storyline Input rewritten with freeform + 7-beat mapping
- [ ] Step 1.7b Tone Selection in SKILL.md
- [ ] Step 3.5.2a Cultural Web Search in SKILL.md
- [ ] Step 3.5.2b Ref Prompt Generation in SKILL.md
- [ ] Tone Impact Matrix in global-promo-config.md Section 13
- [ ] Cultural search config in global-promo-config.md Section 14
- [ ] Ref prompt templates in script-to-scene-bridge.md Section 11
- [ ] All cross-file references consistent
