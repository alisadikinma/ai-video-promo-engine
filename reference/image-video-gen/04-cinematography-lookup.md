---
source: AI Video Production Technical Reference, Creator Cinematography Guide (Docs 5-6)
curated: 2026-03-19
version: 2.0
tokens: ~3200
platform: claude-projects
---

# Cinematography Lookup Tables

## Emotion → Complete Setup

| Mood | Lighting | Ratio | Kelvin | Film Stock | Atmosphere | Lens |
|------|----------|-------|--------|------------|------------|------|
| Dramatic authority | Rembrandt | 4:1 | 3200K | Vision3 500T | Light haze | 85mm |
| Tense thriller | Split | 8:1 | 5600K | Bleach bypass | Heavy haze | 35mm Dutch |
| Warm inspiring | Loop | 2:1 | 3500K | Portra 400 | Clean | 50mm slight low |
| Mystery intrigue | Low-key | 8:1 | Cool | Desaturated | Fog | 35mm |
| Epic reveal | Rim + volumetric | — | — | Teal orange | Dust, god rays | 24mm crane |
| Intimate dialogue | Soft | 4:1 | Warm practical | Portra | Clean | 85mm eye-level |
| Urban noir | Hard | 8:1 | Mixed temp | CineStill 800T | Rain, wet streets | 35mm low |
| Tech/modern | Clean | 2:1 | 5600K | Neutral teal | Screen glow | 50mm straight |

## Emotion → Facial Expression + Body Language

| Emotion | Face | Body | Lighting |
|---------|------|------|----------|
| Shock | Wide eyes, raised brows, open mouth | Frozen, pulled back | High contrast 8:1 |
| Intrigue | Narrowed eyes, head tilt, focused | Lean forward | Low-key shadows |
| Curiosity | Bright eyes, raised brows | Open posture, lean in | Soft 4:1 |
| Tension | Furrowed brow, tight lips, fixed gaze | Rigid shoulders, clenched | Chiaroscuro 8:1+ |
| Awe | Softened eyes, open mouth | Relaxed, chin up | Rim + volumetric |
| Authority | Steady gaze, knowing smile | Arms crossed/steepled | Rembrandt 4:1 |
| Excitement | Bright eyes, genuine smile | Animated, forward lean | High-key warm |
| Contemplation | Downcast eyes, neutral mouth | Hand near chin | Soft side 4:1 |

## Emotion → VEO Camera Motion

| Emotion | Camera | Subject Motion |
|---------|--------|---------------|
| Authority | Static / very slow push-in | Minimal, deliberate |
| Curiosity | Gentle tracking / subtle orbit | Head tilts, forward lean |
| Tension | Slow push-in / handheld | Rigid stillness, tense micro-moves |
| Revelation | Quick push-in / sudden stop | Frozen → reactive |
| Warmth | Gentle approach / soft orbit | Relaxed natural movement |
| Contemplation | Static / very slow drift | Weight shifts, gaze movement |

## Shot Size → Lens → Purpose

| Shot | Frame | Lens | Purpose | Prompt |
|------|-------|------|---------|--------|
| ECU | Eyes/detail | 100mm macro | Intense emotion | "ECU 100mm macro" |
| CU | Face fills | 85mm f/1.8 | Strong emotion | "close-up 85mm f/1.8" |
| MCU | Head+shoulders | 50-85mm | Dialogue | "medium close-up 50mm" |
| MS | Waist up | 50mm | Standard | "medium shot 50mm" |
| MWS | Knees up | 35mm | Action | "cowboy shot 35mm" |
| WS | Full body+env | 24-35mm | Context | "wide shot 35mm" |
| EWS | Landscape | 14-18mm | Epic scale | "extreme wide 18mm" |

## Camera Angles

| Angle | Psychology | Prompt |
|-------|------------|--------|
| Eye-level | Neutral, equal | "eye-level neutral" |
| Low angle | Powerful, heroic | "low angle heroic" |
| High angle | Vulnerable | "high angle vulnerable" |
| Dutch | Unease, tension | "Dutch angle 25° tension" |
| Bird's eye | Omniscient | "bird's eye overhead" |
| Worm's eye | Maximum power | "worm's eye towering" |

## Aperture & Depth of Field

| Aperture | DOF | Use |
|----------|-----|-----|
| f/1.4-1.8 | Extremely shallow | Subject isolation, heavy bokeh |
| f/2.8 | Shallow | Portraits, cinematic |
| f/4 | Moderate | General (Deakins preference) |
| f/5.6-8 | Deep | Groups, environment |
| f/11-16 | Very deep | Landscapes, all sharp |

## Lighting Patterns

| Pattern | Key Position | Shadow | Mood | Prompt |
|---------|-------------|--------|------|--------|
| Rembrandt | 45° side, above | Triangle under eye | Dramatic | "Rembrandt lighting, triangle shadow" |
| Butterfly | Directly above | Butterfly under nose | Glamorous | "Butterfly lighting, glamorous" |
| Split | 90° side | Half face | Intense, duality | "Split lighting, half-face shadow" |
| Loop | 30-45° | Small nose loop | Natural | "Soft loop lighting" |
| Rim/Edge | Behind subject | Glowing outline | Separation | "Strong rim light, edge separation" |

## Lighting Ratios

| Ratio | Contrast | Use | Prompt |
|-------|----------|-----|--------|
| 2:1 | Low | Beauty, commercial | "soft 2:1 lighting ratio" |
| 4:1 | Moderate | Drama, dialogue | "cinematic 4:1 contrast" |
| 8:1 | High | Thriller, noir | "dramatic 8:1 deep shadows" |
| 16:1 | Extreme | Horror | "chiaroscuro extreme contrast" |

## Color Temperature (Kelvin)

| Source | Kelvin | Character | Prompt |
|--------|--------|-----------|--------|
| Candlelight | 1900K | Deep warm | "candlelit 1900K" |
| Tungsten | 2700-3200K | Warm amber | "tungsten 3200K warm" |
| Golden hour | 3500K | Magic gold | "golden hour 3500K" |
| Midday sun | 5600K | Neutral | "daylight 5600K neutral" |
| Overcast | 6500K | Cool soft | "overcast 6500K diffused" |
| Blue hour | 9000-12000K | Twilight blue | "blue hour 9000K" |

## Film Stock Emulation

| Stock | ISO | Character | Prompt |
|-------|-----|-----------|--------|
| Vision3 500T | 500 | Hollywood standard, tungsten | "Kodak Vision3 500T tungsten" |
| Vision3 250D | 250 | Crisp daylight | "Kodak 250D daylight" |
| Portra 400 | 400 | Warm skin, portrait | "Portra 400 warm skin tones" |
| Portra 800 | 800 | Versatile warm | "Portra 800 natural warmth" |
| CineStill 800T | 800 | Halation, neon | "CineStill 800T halation neon" |
| Tri-X 400 | 400 | B&W high contrast | "Tri-X black and white" |
| Ektar 100 | 100 | Saturated vivid | "Ektar saturated vivid" |
| Velvia | 50 | Extreme saturation | "Velvia hyper-saturated" |

## Color Grading Styles

| Style | Mood | Prompt |
|-------|------|--------|
| Teal & Orange | Blockbuster | "teal and orange Hollywood grade" |
| Bleach Bypass | Gritty desaturated | "bleach bypass silver retention" |
| Golden Hour | Romantic | "golden hour warmth amber" |
| Blue Hour | Mysterious | "blue hour cool twilight" |
| Muted | Somber, realistic | "muted desaturated palette" |
| Cross-Process | Retro | "cross-processed retro" |
| Day for Night | Faux night | "day for night blue moonlit" |

## Atmosphere Types

| Type | Effect | Prompt |
|------|--------|--------|
| Haze | Light rays, depth | "atmospheric haze volumetric rays" |
| Fog | Thick, mysterious | "thick fog mysterious" |
| Ground fog | Floor mist | "ground fog low mist" |
| Dust | Golden particles | "dust particles in sunbeams" |
| Smoke | Noir, dramatic | "wispy smoke noir" |
| Rain | Wet, moody | "rain backlit streaking" |
| Snow | Cold, soft | "falling snow soft diffused" |

## Volumetric Effects

| Effect | Prompt |
|--------|--------|
| God rays | "volumetric god rays through haze" |
| Window blinds | "venetian blind shadows volumetric" |
| Backlit particles | "backlit floating particles glowing" |
| Smoke shafts | "light shafts through smoke" |
| Wet streets | "rain-slicked wet pavement reflections" |
| Steam | "steam rising backlit" |

## DP Signatures (Reference)

| DP | Style | Prompt |
|----|-------|--------|
| Roger Deakins | Motivated practical, atmospheric haze | "Deakins motivated naturalistic lighting" |
| Greig Fraser | Desaturated, wet surfaces | "Fraser muted tones, wet reflections" |
| Hoyte van Hoytema | Shallow DOF, organic grain | "Van Hoytema shallow focus, organic grain" |
| Bradford Young | Subtractive "black first", soft | "Bradford Young soft practical sources" |
| Emmanuel Lubezki | Natural/magic hour, long takes | "Lubezki natural light magic hour" |

## Content Type → Default Setup

| Content | Shot | Lens | Lighting | Ratio | Atmosphere |
|---------|------|------|----------|-------|------------|
| Hook | CU/MCU | 85mm | Rembrandt 4:1 | 4:1 | Light haze |
| Explanation | MCU/MS | 50mm | Loop 2:1 | 2:1 | Clean |
| Demo | MS/MWS | 35mm | Soft 2:1 | 2:1 | Clean |
| Testimonial | MCU | 85mm | Butterfly 2:1 | 2:1 | Clean |
| CTA | CU | 85mm | Rembrandt 4:1 | 4:1 | Light haze |
| B-roll product | Various | 50-100mm | Soft commercial | — | Minimal |
| B-roll environment | WS/EWS | 24-35mm | Natural | — | Atmospheric |
