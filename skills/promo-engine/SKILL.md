---
name: promo-engine
description: >
  End-to-end AI video promotional production engine. Generates complete 2-3 minute
  promotional video packages: brainstorm → script → scene breakdown → NB2 image prompts
  → VEO 3.1 video prompts. Supports any brand (generic) or Ali Sadikin preset.
  Triggers on: video promo, promotional video, product video, promo engine, video production,
  bikin video promosi, buat video, video marketing, iklan video, video agency,
  generate video, create promo, video script.
---

# Promo Engine — AI Video Promotional Production Pipeline

## Overview

Full pipeline skill that guides users from initial brainstorm to production-ready NB2 image prompts and VEO 3.1 video prompts for 2-3 minute promotional videos.

## How to Use This Skill

### As Inline Skill (Recommended)
Claude reads this SKILL.md directly and follows the 5-phase workflow interactively.

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
| Creator/brand profile | `reference/creator-profile-system.md` |
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

1. **NEVER skip a phase** — all 5 phases must execute in order
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

---

## Workflow

### Phase 1: BRAINSTORM (Output: strategic-brief.md)

**Read first:** `global-promo-config.md`, `creator-profile-system.md`, `F1_Audience_Psychology_Matrix.md`, `F8_Awareness_Level_Routing.md`

#### Step 1.1: Welcome & Profile Setup

```
AskUserQuestion:
"Selamat datang di Promo Engine! Pertama, siapkan creator/brand profile:"

Options:
A) Start fresh (isi profile baru)
B) Use Ali Sadikin preset
C) Load existing profile (dari creator-profile.md)
```

If "Start fresh" → collect profile fields per `creator-profile-system.md` Section 1.

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

#### Step 1.7: Storyline Discussion

Engage user in free-form discussion about:
- Key pain points of their target audience
- Unique selling proposition
- Competitor landscape
- Success stories / case studies
- Desired CTA (what should viewer DO after watching?)

Use AskUserQuestion to present options and brainstorm ideas together.

#### Step 1.8: Strategic Brief Presentation

Present the Strategic Brief for approval:

```markdown
# Strategic Brief

## Product: {name}
## Target: {market} — {awareness_level}
## Platform: {platform} ({aspect_ratio}, {duration})
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
```

```
AskUserQuestion:
"Strategic brief di atas sudah sesuai?"

Options:
A) Approve — lanjut ke script generation
B) Revise — ada yang perlu diubah (jelaskan)
C) Start over — mulai brainstorm dari awal
```

**Save output:** `{output_folder}/strategic-brief.md`

---

### Phase 2: SCRIPT GENERATION (Output: av-script.md)

**Read:** `project-instruction.md`, `F2`, `F3`, `F5`, `F6`, `F7`, `F9`, `F10`, `F11` (and `F4` if EV product)

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
A) Approve — lanjut ke image prompt generation
B) Adjust scenes — ubah pembagian scene
C) Change VEO modes — ganti mode VEO untuk scene tertentu
D) Adjust durations — ubah durasi scene
```

**Save output:** `{output_folder}/scene-plan.md`

---

### Phase 4: IMAGE PROMPTS — NB2 (Output: image-prompts.md)

**Read:** `01-nb2-image-generation.md`, `04-cinematography-lookup.md`, `05-creator-and-holidays.md`, `creator-profile-system.md`

#### Step 4.1: Reference Image Check

```
AskUserQuestion:
"Pastikan reference images sudah di-upload ke folder {project}/ref/:
- creator-face.png (wajib untuk presenter-style)
- creator-brand.png (logo brand)
- ref-{product}.png (product shots, jika ada)

Status?"

Options:
A) Sudah lengkap, lanjut
B) Sebagian sudah, lanjut dulu
C) Video tanpa presenter (B-Roll only)
```

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
- Creator reference phrase (verbatim from profile)
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
- Files: strategic-brief.md, av-script.md, scene-plan.md, image-prompts.md, video-prompts.md

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

### Image Prompt Quality Gate (Phase 4)
- [ ] NB2 aspect ratio matches VEO target
- [ ] CFG 5-7, Denoise 0.35-0.45
- [ ] Start/End frames share same lighting Kelvin
- [ ] Creator reference phrase verbatim
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
