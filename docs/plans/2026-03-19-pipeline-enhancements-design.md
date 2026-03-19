# Design: 5 Pipeline Enhancements — Language, Storyline, Ref Prompt Gen, Cultural Search, Tone

**Date:** 2026-03-19
**Status:** Approved

---

## Problem Statement

The current pipeline has 5 gaps:
1. Never asks user their preferred narration language (defaults to Bahasa Indonesia)
2. Storyline development is entirely AI-driven — user can't input their own story ideas
3. Phase 3.5 hard blocks without ref images but offers NO help generating them
4. Zero cultural/location research — leads to errors like wrong license plate codes, wrong ethnicity, wrong architecture
5. No tone/mood selection — video style is not explicitly chosen

---

## Design Decisions (from Brainstorm)

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Language scope | Narration/VO only, prompts stay English | AI models need English prompts for best results |
| Storyline input | Phase 1 freeform text, AI maps to 7-beat arc | User creativity first, AI refines structure |
| Ref prompt generation | Batch after manifest (Phase 3.5.2b) | Generate all missing ref prompts at once for efficiency |
| Cultural search depth | Essential facts only (3-5 per location) | Practical — plate numbers, ethnicity, landmarks, architecture, weather |
| Cultural search timing | Phase 3.5 during ref generation | Cultural context needed for accurate NB2 environment prompts |
| Tone selection | Phase 1 after storyline input (Step 1.7b) | Tone depends on audience + storyline context |

---

## Enhancement #1: Language Selection

**Where:** Phase 1 Step 1.0 (new, before everything else)

```
AskUserQuestion:
"Bahasa apa yang mau digunakan untuk narasi/voiceover video?"

Options:
A) Bahasa Indonesia
B) English
C) Bilingual (Indonesia primary, English terms for tech)
```

**Impact:**
- `narration_language` saved to `strategic-brief.md`
- Phase 2 (Script): narasi/dialogue written in chosen language
- Phase 5 (VEO): `says:` dialogue in chosen language
- NB2/VEO prompt structure stays English (technical requirement)

---

## Enhancement #2: User Storyline Input

**Where:** Phase 1 Step 1.7 (rewrite current AI-driven discussion)

```
AskUserQuestion:
"Apakah kamu punya ide storyline/cerita untuk video ini?"

Options:
A) Ya, saya mau ketik/paste storyline saya
B) Tidak, bantu saya brainstorm dari nol
C) Saya punya referensi video yang mirip (share link/desc)
```

**If A (user has storyline):**
- User pastes freeform text
- AI parses and maps to 7-beat arc
- AI shows: "Storyline kamu sudah cover beat: X, Y, Z. Yang belum: A, B, C."
- AI suggests additions for missing beats
- User approve/revise

**If B:** Current brainstorm flow (AI-driven)
**If C:** User describes reference, AI extracts structure

---

## Enhancement #3: Ref Image Prompt Generation (NB2)

**Where:** Phase 3.5 Step 3.5.2b (new, batch after manifest)

**Flow:**
```
Phase 3.5.1: Auto-derive manifest
Phase 3.5.2: Present manifest, user checks what they have
Phase 3.5.2a: Cultural Web Search (Enhancement #4)
Phase 3.5.2b: Batch NB2 Prompt Gen for Missing Refs ← THIS
Phase 3.5.3: User generates images, uploads to ref/
Phase 3.5.4: Validate 100%
```

```
AskUserQuestion:
"Ada {M} reference image yang belum tersedia.
Mau saya buatkan NB2 prompt supaya kamu bisa generate sendiri?"

Options:
A) Ya, generate semua prompt sekaligus
B) Ya, tapi pilih mana yang perlu prompt
C) Tidak, saya akan cari/foto sendiri
```

**NB2 Ref Prompt Templates per Category:**

| Category | Prompt Strategy |
|----------|----------------|
| Cast face | Portrait: front view, neutral lighting, studio white bg, specific ethnicity/age/features from cast-profile |
| Cast body | Full body: standing pose, wardrobe from cast-profile, neutral bg |
| Cast costume | Uniform detail: front view, institution-specific, emblem/badge visible, clean bg |
| Product | Product photography: hero angle, clean bg, commercial lighting |
| Environment | Establishing shot: architectural style, cultural details from web search, time of day |
| Brand logo | Instruct user to provide actual file (cannot generate logos reliably) |

**Output format per missing ref:**
```markdown
### ref/env-pelabuhan-dumai.png — Pelabuhan Dumai Environment
**NB2 Prompt:**
Wide establishing shot of a modern Indonesian port facility in Dumai, Riau.
Industrial cranes, container stacks, tropical sky with cumulus clouds.
Warm humid atmosphere, equatorial lighting. Malay-style port architecture.
Vehicles with BM-series license plates visible in background.
CAMERA: Wide shot, 24mm f/8, eye-level.
LIGHTING: Natural tropical sun, 5600K, high ambient.
TECHNICAL: 16:9, 4K, CFG 6.0, Denoise 0.40, Thinking High.
```

---

## Enhancement #4: Cultural Location Research (Web Search)

**Where:** Phase 3.5 Step 3.5.2a (new, before ref prompt generation)

```
FOR each unique location in scene-plan.md:
    WebSearch: "{location} Indonesia cultural characteristics"
    EXTRACT essential facts:
      1. Plat kendaraan kota (e.g., BM for Dumai/Riau)
      2. Etnis dominan & ciri fisik umum (e.g., Melayu Riau)
      3. Landmark ikonik (e.g., Pelabuhan Dumai, Tugu Ikan Terubuk)
      4. Arsitektur lokal (e.g., rumah Melayu, atap lipat kajang)
      5. Cuaca/musim khas (e.g., tropis lembab, musim kabut asap)

    SAVE to: strategic-brief.md > Cultural Context section
    INJECT into: NB2 environment prompts (Phase 3.5.2b)
    INJECT into: VEO scene prompts (Phase 5)
```

**Cultural Context output (saved to strategic-brief.md):**

```markdown
## Cultural Context — {Location}

| Fact | Detail | Source |
|------|--------|--------|
| Plat Kendaraan | {code} ({region}) | Web search |
| Etnis Dominan | {ethnicity} — {physical features} | Web search |
| Landmark | {list of landmarks} | Web search |
| Arsitektur | {local architectural style} | Web search |
| Cuaca | {climate details} | Web search |
```

**Injection points:**
- NB2 environment prompts: architecture, weather, landmarks, license plates
- NB2 character prompts: local ethnicity for extras/background characters
- VEO scene prompts: ambient atmosphere
- Script narasi: local terms, pronunciations

---

## Enhancement #5: Tone/Mood Selection

**Where:** Phase 1 Step 1.7b (after storyline input)

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

**Impact across pipeline:**

| Phase | Tone Impact |
|---|---|
| Script (Phase 2) | Word choice, joke placement, pacing, dialogue style |
| Hook (F5) | Humorous = unexpected twist. Serious = shocking stat. Professional = authority |
| Cinematography | Humorous = brighter 2:1, wider. Serious = dramatic 4:1+, tight CU. Professional = clean 2:1 |
| Audio/Music | Humorous = upbeat, quirky SFX. Serious = orchestral. Professional = corporate ambient |
| VEO prompts | Tone keywords: "lighthearted atmosphere" vs "tense dramatic atmosphere" |
| NB2 prompts | Expression guidance: "warm smile, playful" vs "stern, determined" |

**Saved to:** `strategic-brief.md` → `video_tone` field

---

## Updated Phase 1 Flow

```
Step 1.0:  Language Selection ← NEW (#1)
Step 1.1:  Cast Setup (existing)
Step 1.2:  Product Discovery (existing)
Step 1.2b: Institution Detection (existing)
Step 1.3:  Target Market (existing)
Step 1.4:  Awareness Level (existing)
Step 1.5:  Platform Selection (existing)
Step 1.6:  Emotional Core (existing)
Step 1.7:  Storyline Input ← REWRITTEN (#2)
Step 1.7b: Tone/Mood Selection ← NEW (#5)
Step 1.8:  Strategic Brief (existing, expanded with tone + cultural context)
```

## Updated Phase 3.5 Flow

```
Step 3.5.1:  Auto-derive manifest (existing)
Step 3.5.2:  Present manifest (existing)
Step 3.5.2a: Cultural Web Search ← NEW (#4)
Step 3.5.2b: Batch NB2 Prompt Gen for Missing Refs ← NEW (#3)
Step 3.5.3:  User generates/uploads, validate (existing)
Step 3.5.4:  Save manifest (existing)
```

---

## Files to Modify

| File | Change |
|---|---|
| `reference/global-promo-config.md` | Add `narration_language`, `video_tone`, cultural search config, ref prompt gen config |
| `skills/promo-engine/SKILL.md` | Add Step 1.0 (language), rewrite Step 1.7 (storyline), add Step 1.7b (tone), add Steps 3.5.2a + 3.5.2b |
| `reference/creator-profile-system.md` | Add cultural context guidance for local ethnicity in cast builder |
| `reference/script-to-scene-bridge.md` | Add cultural injection in NB2/VEO templates, add ref prompt generation templates per category, add tone-to-cinematography mapping |
| `agents/promo-engine-agent.md` | Add web search capability, language/tone awareness, ref prompt generation |
| `skills/promo-validate/SKILL.md` | Add check 12 (language consistency), check 13 (tone consistency) |
| `CLAUDE.md` | Document all 5 enhancements, update pipeline flow, add cultural research + tone sections |
