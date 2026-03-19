---
source: VEO 3.1 Complete Production Guide, PROD_STEP2, PROD_STEP3 (Docs 8-10)
curated: 2026-03-19
version: 2.0
tokens: ~3500
platform: claude-projects
---

# VEO 3.1 — Video Production Reference

## Core Specs

| Param | Value | Notes |
|-------|-------|-------|
| Resolution | 720p (default), 1080p | 1080p = 8s clips only, cannot extend |
| Aspect | 16:9, 9:16 | No 1:1 support |
| Frame rate | 24fps | Fixed |
| Duration | 4, 6, 8 seconds | 8s required for extensions |
| Max tokens | 1,024 | Optimal: 100-150 words |
| Extensions | +7s per hop, max 20 | ~148s total possible |
| Reference images | Up to 3 | Asset or style type |
| Pricing | $0.40/s (audio) / $0.20/s (no audio) | Fast: $0.15/$0.10 |

## Prompt Formula

```
[Cinematography] + [Subject] + [Action] + [Context] + [Style & Ambiance]
```

**8-part pro version:**
```
[Subject] + [Context] + [Action] + [Style] + [Camera] + [Composition] + [Ambiance] + [Audio]
```

## Audio (NOT OPTIONAL)

Unspecified audio = model guesses (random laughter, wrong sounds).

**3 layers — specify all:**

| Layer | Syntax | Example |
|-------|--------|---------|
| Dialogue | `[Character] says: "text"` | The coach says: Two hard steps, plant, explode. |
| SFX | `SFX: description` | SFX: metallic clank, thunder cracks |
| Ambient | `Ambient: description` | Ambient: distant waterfall roar |

**Constraints:** 12-15 words max per 8s, 20-25 syllables max.
**Always add:** `no subtitles, no audience sounds, no text overlays`

## Camera Movement Library (VEO-Verified)

### Static
`static shot` · `locked-off shot` · `fixed camera`

### Push/Pull
`smooth dolly push-in` · `gentle dolly push-in` · `slow dolly-in` · `dolly-out` · `gentle dolly pull-back`

### Lateral
`tracking shot following subject` · `smooth tracking shot` · `truck left` · `truck right`

### Rotational
`slow pan left/right` · `whip pan` · `tilt up` · `tilt down`

### Complex
`crane shot rising/descending` · `orbit shot circling subject` · `180-degree arc shot` · `Steadicam floating movement`

### Stylistic
`handheld camera` · `documentary-style` · `shaky cam`

## I2V Motion Description

**Rule:** Describe MOTION only — model already sees the image.

### Subject Micro-Movements
- Face: `"subtle eye blinks every 2-3 seconds"`, `"gentle micro-expressions shifting"`
- Head: `"subtle head tilt suggesting thought"`, `"gentle nod of understanding"`
- Hands: `"subtle hand gesture emphasizing point"`, `"fingers gently tapping surface"`

### Ambient Motion
- Atmospheric: `"floating dust particles drifting through light beam"`, `"subtle haze drift"`
- Environmental: `"monitor screen content subtly shifting"`, `"curtain edge gentle flutter"`
- Light: `"subtle light flicker from screen"`, `"gentle shadow shift as clouds pass"`

### I2V Prompt Template
```
"~8s, 1080p, [aspect].
Camera: [movement], [speed].
Subject: [micro-movements — blinks, breathing, gestures].
Expression shift: [if any].
Ambient: [particles, environmental].
Audio: [ambient], [music/no music], no subtitles, no audience sounds.
Maintain exact lighting, environment, appearance from reference image."
```

## Lip Sync Mastery

### Colon Syntax (CRITICAL)
✅ `A woman says: Welcome to my channel!`
❌ `A woman says "Welcome to my channel"` → causes subtitles/sync failure

### 3-6 Second Rule
| Duration | Words | Result |
|----------|-------|--------|
| 3-6s | 8-15 | ✅ Optimal sync |
| <2s | <5 | ❌ AI gibberish |
| >8s | >20 | ❌ Robotic, fast |

### Face Requirements
| Face Size (% of frame) | Quality |
|------------------------|---------|
| 30%+ | ✅ Excellent |
| 20-30% | ✅ Good |
| 15-20% | ⚠️ Marginal |
| <15% | ❌ Fails |

### Enhancement Keywords
Add to dialogue prompts: `"clearly enunciates"` · `"visible mouth openings"` · `"jaw moves realistically with dialogue"` · `"no background music"` · `"(no subtitles!)"`

### Pronunciation
Spell phonetically: "foh-fur" not "fofr", "eye-oh-tee" not "IoT"

### Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| Frozen mouth | Camera too far | MCU/CU, add "visible mouth openings" |
| Off-beat sync | Dialogue too long | Shorten to 3-6s, add "no background music" |
| No audio generated | Wrong mode or 1080p bug | Use Text-to-Video, generate 720p |
| Unwanted subtitles | Wrong syntax | Use colon syntax, add "(no subtitles!)" multiple times |
| Identity drift | Multi-variable change | Same description verbatim across all prompts |

## Scene Extension

| Constraint | Detail |
|------------|--------|
| Resolution | 720p only (1080p cannot extend) |
| Source | Must be VEO-generated video |
| Per hop | +7 seconds |
| Max | 20 extensions (~148s) |
| Context | Uses final 24 frames (1 second) |

**Best practices:**
- Hold pose for final 0.5s
- Maintain consistent camera movement speed
- Avoid new characters entering in final second
- Keep audio element present in final second

**Continuation prompt template:**
```
"Continue from previous clip. [New action].
Camera continues [same movement] at [same speed].
Maintain lighting, environment, character appearance.
Audio continues: [same ambient], [new dialogue if any].
No subtitles, no audience sounds."
```

## Timestamp Prompting (Multi-Shot)

```
[00:00-00:02] Shot 1: CU of hands typing rapidly
[00:02-00:04] Shot 2: MS reaction — subject leans back, eyes widen
[00:04-00:06] Shot 3: Over-shoulder revealing monitor
[00:06-00:08] Shot 4: CU face, dawning realization. Audio: quiet office, no dialogue.
```

Audio spec in final timestamp applies to whole clip.

## Transition End Instructions

| Transition | VEO Instruction | Use |
|-----------|-----------------|-----|
| Cut | "Hard cut, immediate switch" | Standard scene change |
| Push-In | "End with slow dolly push-in" | Building intensity |
| Pull-Back | "End with gentle pull-back" | Context reveal |
| Whip-Pan | "Fast horizontal pan with motion blur" | Energy |
| Fade to Black | "Slow opacity fade to black over 12 frames" | Scene end |
| Dissolve | "Cross-dissolve preparation, hold final pose" | Time passage |
| Match Cut | "End framing matches first frame of next shot" | Visual continuity |

## Negative Prompts (Standard Block)

```
No subtitles, no text overlays, no watermarks, no blurry faces,
no distorted hands, no cartoon effects, no audience sounds, no laugh track.
```

Prefer positive framing: "crystal-clear sharp focus" over "no blur".
