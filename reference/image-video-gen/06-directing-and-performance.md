---
source: Film Directing & Performance Grammar for AI Video Production
curated: 2026-03-21
version: 1.0
tokens: ~5500
platform: claude-projects
---

# Film Directing & Performance Guide

This file covers what a film director controls: where actors look, how they move, how they speak, and how the camera maintains spatial continuity. It also covers the **Continuity Supervisor** mindset for visual consistency across scenes.

> **Relationship to other files:**
> - Cinematography SETUP (lighting, lens, film stock) → `04-cinematography-lookup.md`
> - VEO SPECS (resolution, duration, extensions) → `02-veo-production-guide.md`
> - Tone ATMOSPHERE (music, SFX, ambient) → `script-to-scene-bridge.md` Section 10
> - Cast IDENTITY (reference phrases, costume) → `creator-profile-system.md`
> - This file covers DIRECTING PERFORMANCE and VISUAL CONTINUITY — the missing layer between setup and execution.

---

## 1. The 180° Rule (Screen Direction)

### The Rule

Draw an imaginary line (the **action line**) between two characters or along a character's movement direction. The camera MUST stay on ONE SIDE of that line throughout the scene.

```
Correct (camera stays on same side):
                    Action Line
  Character A  ←─────────────────→  Character B
         ○                                ○
         │                                │
    ┌────┴─────┐                   ┌──────┴────┐
    │  Cam 1   │  ←── same side   │  Cam 2    │
    └──────────┘   of action line  └───────────┘

Crossing the line → characters suddenly swap screen positions
→ viewer disorientation → amateur look
```

### Application to VEO Prompts

| Scene Type | Action Line Rule | NB2/VEO Direction |
|-----------|-----------------|-------------------|
| Two-person dialogue | Line between speakers | Character A ALWAYS screen-left, B ALWAYS screen-right across all cuts |
| Character walking | Along movement direction | If walking LEFT-to-RIGHT in Shot 1, keep LEFT-to-RIGHT in Shot 2 |
| Product demo | Between presenter and product | Presenter consistently on ONE side, product on other |
| Presenter to camera | Between presenter and lens | Keep presenter on same side of frame across cuts |

### When to Break It

- **Deliberate disorientation** (edgy tone, thriller moment)
- **Neutral reset shot** — insert a shot ON the line (straight-on) before switching sides
- Always annotate in VEO prompt: `"Camera crosses action line — intentional disorientation"`

---

## 2. Gaze Direction & Eye Line

### The Core Principle

Where the actor LOOKS determines where the viewer FEELS the action is happening.

### Gaze Direction Lookup

| Scene Type | Actor Looks At | Why | NB2/VEO Prompt Phrase |
|-----------|---------------|-----|-----------------------|
| Presenter monologue | Camera lens (direct) | Builds trust, breaks 4th wall | `"looking directly into camera lens, eye contact with viewer"` |
| Dialogue (speaker) | Other character (off-camera) | Natural conversation | `"looking screen-right at conversation partner, eye line at eye-level"` |
| Dialogue (listener) | Speaker (off-camera) | Shows attention | `"attentive gaze toward screen-left, listening intently"` |
| Product demo — presenting | Product → Camera → Product | Triangle attention | `"glances down at product in hands, then looks up at camera"` |
| Product demo — close-up | N/A (no person) | Product is subject | `"product fills frame, no person visible"` |
| Reacting to reveal | Product/screen → Camera | Shares excitement with viewer | `"eyes widen looking at screen, then turns to camera with smile"` |
| B-Roll walking | Forward path / horizon | Natural movement | `"looking ahead at walking direction, natural gaze"` |
| B-Roll working | Task at hand | Authenticity | `"eyes focused on hands performing task, concentrated"` |
| CTA closing | Camera lens (direct) | Call-to-action demands eye contact | `"direct confident gaze into camera, slight forward lean"` |
| Group scene (main) | Camera or action point | Leadership | `"Pemeran Utama looks directly at camera while others look at them"` |
| Group scene (support) | Main character | Hierarchy | `"Pemeran Pendamping looks attentively at Pemeran Utama"` |

### Eye Line Height

The HEIGHT of the actor's gaze creates emotional subtext:

| Eye Line | Emotion | When to Use |
|----------|---------|-------------|
| Eye-level (horizontal) | Equality, neutrality | Standard dialogue, presenter |
| Slightly upward | Hope, aspiration, awe | Inspirational moments, reveal |
| Slightly downward | Contemplation, sadness, reading | Studying product, checking data |
| Sharp upward | Overwhelm, vulnerability | Looking up at large structure |
| Sharp downward | Authority (from high angle), defeat | Power dynamics |

### Cross-Cut Eye Line Continuity

When cutting between two characters in dialogue:

```
Shot A (Character A speaking):      Shot B (Character B listening):
  A looks SCREEN-RIGHT ─────────→   B looks SCREEN-LEFT
  (toward B off-camera)              (toward A off-camera)

RULE: Their eye lines must MIRROR — if A looks right, B looks left.
       Same height. This creates the illusion they're looking at each other.
```

**NB2 implementation:** When generating start frames for dialogue scenes, explicitly state gaze direction in EVERY prompt:
- Character A prompt: `"looking screen-right at eye level toward conversation partner"`
- Character B prompt: `"looking screen-left at eye level toward conversation partner"`

---

## 3. Actor Blocking & Staging

### Frame Position Notation

```
Screen layout (viewer's perspective):

  ┌─────────┬─────────┬─────────┐
  │         │         │         │
  │  LEFT   │ CENTER  │  RIGHT  │
  │  THIRD  │  THIRD  │  THIRD  │
  │         │         │         │
  └─────────┴─────────┴─────────┘

  Rule of thirds: place subject at intersection points.
  "Screen-left" = viewer's left.
  "Screen-right" = viewer's right.
```

### Blocking Templates by Scene Type

| Scene Type | Character Position | Prompt Direction |
|-----------|-------------------|------------------|
| Solo presenter | Center or center-left third | `"subject positioned center-left of frame, rule of thirds"` |
| Two-person dialogue — A | Left third | `"subject positioned screen-left, facing screen-right"` |
| Two-person dialogue — B | Right third | `"subject positioned screen-right, facing screen-left"` |
| Over-the-shoulder (OTS) A→B | A's shoulder fills left foreground (soft focus), B center-right (sharp) | `"over-the-shoulder from Character A (left foreground, blurred shoulder) looking at Character B (center-right, sharp focus)"` |
| Product demo | Presenter left third, product center-right | `"presenter screen-left holding product at center-right of frame"` |
| Group (3 people) | Triangular: tallest slightly back-center, others front-left and front-right | `"triangular composition, [main] center-back, [support A] front-left, [support B] front-right"` |
| Walking shot | Subject at leading-side third, space ahead for movement | `"subject screen-left with walking room to the right"` |
| CTA | Center, slightly closer than standard framing | `"subject dead center, leaning slightly forward toward camera"` |

### Shot-Reverse-Shot Protocol (Dialogue Scenes)

For multi-character dialogue, generate shots in PAIRS:

```
1. OTS from A → B (A's shoulder foreground-left, B sharp center-right)
2. OTS from B → A (B's shoulder foreground-right, A sharp center-left)
3. Both share: same lens, same lighting, same aperture, same eye-level height
4. Eye lines MIRROR each other (see Section 2)
```

**VEO implementation:** Use Ingredients mode for character consistency within the pair. Each shot = separate VEO generation with same character reference images.

### Entry & Exit Frame

| Direction | Emotional Signal | Prompt Phrase |
|-----------|-----------------|---------------|
| Enter from screen-left | Arrival, positive, natural flow | `"character enters frame from left, walking right"` |
| Enter from screen-right | Opposition, unexpected, disruption | `"character enters frame from right, walking left"` |
| Enter from background (toward camera) | Approach, growing importance | `"character walks toward camera from background, growing larger in frame"` |
| Exit screen-right | Moving forward, continuation | `"character exits frame to the right, continuing journey"` |
| Exit to background (away from camera) | Departure, diminishing | `"character walks away from camera toward background"` |
| Already in frame (no entry) | Stability, established presence | `"character already positioned in frame, static"` |

**VEO Rule:** Never introduce new characters in the FINAL 1 second of a clip that will be extended — extension context anchors on the last second.

---

## 4. Vocal Performance Direction

### The Problem

Current pipeline only specifies `says:` text with no performance direction. Result: VEO generates flat, monotone delivery. Natural human speech has rhythm, pace variation, pauses, and emotional modulation.

### Vocal Direction Syntax for VEO Prompts

Embed vocal cues INSIDE the dialogue line using parenthetical directions:

```
Format:
  [Character] says: (vocal direction) dialogue text (mid-line direction) more text.

Examples:
  Host says: (soft, conspiratorial whisper) Bayangkan... (beat 0.5s, then building to normal volume) kalau semua ini bisa otomatis.

  Driver says: (tired, relieved sigh) Akhirnya sampai juga. (slight laugh) Tiga hari di jalan.

  CEO says: (measured, authoritative, slow pace) Ini bukan soal teknologi. (pause 1s, leans forward) Ini soal masa depan perusahaan kita.
```

### Vocal Direction Vocabulary

| Direction | Meaning | When to Use |
|-----------|---------|-------------|
| `whisper` | Quiet, intimate, conspiratorial | Hook, secret, foreshadow |
| `measured pace` | Deliberate, each word carries weight | Authority, serious moment |
| `building energy` | Volume and pace increase gradually | Toward peak, excitement |
| `trailing off...` | Volume decreases, thought unfinished | Contemplation, doubt |
| `sharp, clipped` | Short words, no filler | Urgency, command, tension |
| `warm, conversational` | Natural rhythm, relaxed | Casual presenter, testimonial |
| `rising intonation` | Pitch rises at end of phrase | Question, uncertainty, teasing |
| `falling intonation` | Pitch drops at end of phrase | Statement, finality, confidence |
| `beat Xs` | Silence for X seconds | Let moment land, reaction time |
| `slight laugh` | Brief natural laugh (not forced) | Casual warmth, humility |
| `sigh` | Exhale before/after speaking | Relief, exhaustion, frustration |
| `emphasis on [word]` | Stress specific word | Key term, contrast, surprise |

### Vocal Direction by Tone

| Tone | Default Vocal Style | Pace | Volume Dynamic | Pauses |
|------|-------------------|------|----------------|--------|
| Humorous | Light, playful, varied pitch | Fast-medium, comedic timing | Normal, burst louder for punchline | Beat after joke, let audience react |
| Serious | Low register, deliberate | Slow-measured | Controlled, quiet force | Long pauses for weight |
| Professional | Clear, precise enunciation | Medium-steady | Even, confident | Short functional pauses |
| Inspirational | Warm, building crescendo | Starts slow → builds | Quiet → powerful | Strategic pauses before key phrases |
| Casual | Natural, conversational flow | Medium, varied | Moderate, friendly | Natural breathing pauses |
| Edgy | Intense, punchy, staccato | Fast, aggressive | Loud, confrontational | Abrupt silences for impact |

### Voiceover vs Lip-Sync Performance

| Mode | Syntax | Vocal Direction |
|------|--------|-----------------|
| Lip-sync (presenter) | `Host says: (direction) text` | Full vocal performance — tone, pace, pauses, emotion. Use generic role, NEVER real names. |
| Voiceover (B-Roll) | `Voice-over narrator, (direction): text` | Off-screen narration — smoother, more polished, less conversational. NEVER bare `Voiceover:` |
| Inner monologue | `Voice-over narrator, (internal, reflective): text` | Quiet, contemplative, as if thinking |

---

## 5. Natural Acting Direction

### The "Don't Act — React" Principle

AI-generated video looks most natural when characters REACT to stimuli rather than PERFORM emotions. Direct the cause, not just the effect.

| Instead of This | Write This |
|----------------|-----------|
| `"character looks happy"` | `"character sees product working, eyes widen, breaks into genuine smile"` |
| `"character looks worried"` | `"character reads notification on phone, brow furrows, glances up from screen"` |
| `"character looks impressed"` | `"character watches dashboard numbers climb, leans back, slowly nods"` |
| `"character looks professional"` | `"character adjusts collar, squares shoulders, takes breath before speaking"` |

### Micro-Movement Checklist (per 8s VEO clip)

Natural human behavior includes involuntary micro-movements. Include 2-3 per clip:

| Micro-Movement | Frequency | NB2/VEO Phrase |
|---------------|-----------|----------------|
| Eye blinks | Every 2-4s | `"natural eye blinks every 3 seconds"` |
| Weight shift | Every 5-8s | `"subtle weight shift from left to right foot"` |
| Breathing | Continuous | `"visible natural breathing rhythm, chest rises and falls"` |
| Head micro-tilt | Contextual | `"slight head tilt while listening"` |
| Hand adjustment | Contextual | `"adjusts grip on product, fingers reposition naturally"` |
| Swallow | Every 10-15s | `"natural swallowing motion"` (only for CU/MCU) |
| Lip lick/press | Before speaking | `"presses lips briefly before responding"` |

### Transitional Behavior (Between Lines)

What does the character do BETWEEN dialogue lines? This is what separates amateur from cinematic:

| Transition | Direction | Prompt |
|-----------|-----------|--------|
| Thinking before responding | Processing what was said | `"pauses, looks slightly down-left (processing), then looks up to respond"` |
| Agreeing while listening | Active listening | `"subtle nodding while other character speaks, slight smile forming"` |
| Disagreeing while listening | Suppressed reaction | `"jaw tightens slightly, gaze becomes more fixed, stops nodding"` |
| About to reveal something | Building to a point | `"takes breath, straightens posture, eye contact intensifies"` |
| Finishing a thought | Releasing tension | `"exhales, shoulders relax, gaze softens"` |

---

## 6. Multi-Character Scene Choreography

### Power Dynamics Through Blocking

| Who Has Power | Camera Treatment | Position | Gaze |
|--------------|-----------------|----------|------|
| Character A dominant | Lower angle on A, higher on B | A center or elevated, B peripheral | A looks down/across, B looks up |
| Equal power | Eye-level, matched framing | Both at same height, equal thirds | Horizontal eye lines, matching |
| Power shifting | Camera slowly adjusts angle during scene | Characters physically shift positions | Eye lines cross and re-establish |

### Sequential Dialogue (VEO Lip-Sync Constraint)

VEO can only lip-sync ONE speaker at a time. For multi-character dialogue:

```
WRONG: Both characters speaking simultaneously
RIGHT: Sequential delivery with reaction shots

Structure per dialogue exchange:
1. Character A speaks (MCU, lip sync ON)
   → B visible in background or OTS (listening reaction, no dialogue)
2. [0.3-0.5s pause — reaction beat]
3. Character B responds (MCU, lip sync ON)
   → A visible in background or OTS (listening reaction, no dialogue)
```

### Character Differentiation

When multiple characters share screen time, they MUST be visually distinguishable:

| Differentiator | Implementation |
|---------------|----------------|
| Wardrobe color contrast | A in dark tones, B in light (or branded colors) |
| Screen position consistency | A ALWAYS screen-left, B ALWAYS screen-right throughout video |
| Gesture style | A uses open palms (honesty), B uses pointed gestures (precision) |
| Posture | A leans forward (engaged), B stands straight (authoritative) |
| Accessories | A wears glasses, B does not — or different hat/helmet/badge |

---

## 7. Visual Continuity Supervision

### The Continuity Supervisor Mindset

Before generating ANY image or video prompt, think like a **Continuity Supervisor** on a film set. Their job: NOTHING changes between shots unless the story demands it.

### Continuity Checklist (Per Scene)

Before writing each NB2/VEO prompt, verify against previous scenes:

| Element | Check | If Broken |
|---------|-------|-----------|
| Wardrobe | Same clothes as previous scene (unless time/location change) | Re-check cast-profile.md wardrobe for this scene context |
| Props in hand | If character held phone in Scene 5 mid-action, still holding it in Scene 6 continuation | Add prop to prompt |
| Hair/appearance | Same hairstyle, same glasses, same facial hair | Copy verbatim from cast reference phrase |
| Background continuity | Same location = same background elements | Reference same `ref/env-{location}.png` |
| Lighting continuity | Same Kelvin, same direction, same ratio across scene cuts | Match values from previous scene prompt |
| Weather | If it was raining in Scene 4, still raining in Scene 5 (same location) | Add weather to prompt |
| Time of day | If Scene 7 is sunset, Scene 8 (same location) can't be midday | Match lighting Kelvin and sky |
| Vehicle state | Same color, same damage, same plate number across scenes | Reference same `ref/vehicle-{name}.png` |
| Screen direction | Character was walking left-to-right, still walking left-to-right | Maintain movement direction |
| Product state | Product was opened in Scene 6, stays open in Scene 7 | Describe current state |

### Asset-First Continuity Rules

These rules ensure the Continuity Supervisor mindset feeds into the asset-first pipeline:

1. **Same visual = same reference.** If a truck appears in Scene 2 and Scene 8, BOTH prompts reference the EXACT same `ref/vehicle-truck-{name}.png`. No re-describing from text.

2. **Logo = ALWAYS user file.** Brand logos, app icons, institutional emblems are NEVER AI-generated. If `ref/brand-{name}.png` exists, inject it. If not, hard-block until user provides it.

3. **Character = ALWAYS cast ref.** No matter how minor the appearance (background, reflection, photo on screen), if the character has a cast slot → inject `cast-c{N}-face.png`.

4. **Location = ALWAYS env ref.** If the location has a ref photo, EVERY scene at that location must reference it. The gate doesn't change between Scene 3 and Scene 11.

5. **Verbal description NEVER overrides photo.** If user uploaded a photo of their actual truck/gate/product, the photo is ground truth. Don't add details the photo doesn't show.

### Pre-Phase 4A: Visual Element Inventory

Before starting Phase 4A, the Continuity Supervisor builds a complete inventory from the approved av-script.md:

```
INVENTORY TEMPLATE:

CHARACTERS (who appears, which scenes):
  c1 - [Name/Role] → Scenes: 1, 2, 3, 5, 7, 8, 10, 12  (Pemeran Utama)
  c2 - [Name/Role] → Scenes: 3, 6, 7, 9               (Pemeran Pendamping)

VEHICLES (what type, which scenes):
  Hino dump truck (red) → Scenes: 2, 5, 7, 11           → STANDALONE ASSET (4 scenes)
  Forklift             → Scene: 6                        → Inline (1 scene only)

OBJECTS/PROPS (what item, which scenes):
  Smartphone           → Scenes: 1, 3, 8, 10            → STANDALONE ASSET (4 scenes)
  Clipboard            → Scene: 4                        → Inline (1 scene only)
  Safety helmet        → Scenes: 2, 5, 6, 7, 11         → STANDALONE ASSET (5 scenes)

PRODUCTS (what product, which scenes):
  CPO cangkang         → Scenes: 4, 6, 9                → STANDALONE ASSET (3 scenes)
  Mobile app UI        → Scenes: 3, 5, 8, 10            → STANDALONE ASSET (UI composite)

BRAND ELEMENTS (what logo/signage, which scenes):
  Company logo         → Scenes: 1, 3, 8, 10, 12        → USER-PROVIDED (never AI-gen)
  App icon             → Scenes: 3, 5, 8                 → USER-PROVIDED (never AI-gen)
  Institutional badge  → Scenes: 2, 5, 7                 → USER-PROVIDED + costume ref

ENVIRONMENTS (what location, which scenes):
  Port gate            → Scenes: 2, 7, 11               → STANDALONE ASSET (3 scenes)
  Office interior      → Scenes: 1, 3, 10               → STANDALONE ASSET (3 scenes)
  Weighbridge          → Scenes: 5, 6                    → STANDALONE ASSET (2 scenes)

DECISION:
  appearance_count >= 2 → Phase 4A standalone asset (MANDATORY)
  appearance_count == 1 → Inline in Phase 4B (can describe in scene)
  Logo/brand/icon      → User-provided ONLY (hard-block if missing)
```

This inventory feeds directly into the dependency graph (global-promo-config.md Section 18) and determines asset generation order.

---

## 8. Indonesian Cultural Gesture & Performance Notes

### Gesture Sensitivity

| Gesture | Indonesian Context | Direction for NB2/VEO |
|---------|-------------------|----------------------|
| Pointing with index finger | Can be considered rude in formal settings | Use open palm or thumb to indicate direction |
| Left hand for giving/receiving | Considered impolite | Characters give/receive with RIGHT hand |
| Crossed arms | Less common as casual stance | Reserve for deliberate "defensive" body language |
| Head nod | Universal agreement, very common | Use freely for listening/agreement reactions |
| Slight bow | Shows respect, common with elders/officials | Use when character meets senior figure |
| Both hands receiving | Shows respect when receiving something | `"receives document with both hands, slight bow"` |

### Vocal Performance — Indonesian Context

| Context | Vocal Direction |
|---------|----------------|
| Speaking to superior/elder | `"respectful tone, slightly softer, measured pace"` |
| Speaking to colleague | `"natural conversational, relaxed pace"` |
| Presenting to audience | `"clear enunciation, confident projection, professional"` |
| Excited about result | `"genuine enthusiasm, rising pitch, faster pace — but not shouting"` |
| Formal institutional | `"formal register, precise diction, no slang"` |

---

## Cross-Reference Summary

| What You Need | Where to Find It |
|--------------|-----------------|
| Lighting/lens/film stock SETUP | `04-cinematography-lookup.md` |
| VEO technical specs/extensions | `02-veo-production-guide.md` |
| Tone → cinematography mapping | `script-to-scene-bridge.md` Section 10 |
| Cast identity/reference phrases | `creator-profile-system.md` |
| Recurring element detection algorithm | `global-promo-config.md` Section 18 |
| Asset categories & naming | `global-promo-config.md` Section 17 |
| Ref folder auto-scan protocol | `global-promo-config.md` Section 19 |
| **Gaze, blocking, vocal, continuity** | **This file (06-directing-and-performance.md)** |
