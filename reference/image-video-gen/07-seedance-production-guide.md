---
source: Seedance 2.0 Production Guide — compiled from ByteDance official docs, NotebookLM Deep Research, community guides
curated: 2026-03-29
version: 1.0
tokens: ~7000
platform: claude-projects
---

# Seedance 2.0 — Video Production Reference

## Core Specs

| Param | Value | Notes |
|-------|-------|-------|
| Resolution | Native 2K (2048x1080 landscape / 1080x2048 portrait) | Upscale to 4K available; no upscaling artifacts |
| Aspect Ratios | 16:9, 9:16, 1:1, 3:4, 4:3, 21:9 | 6 options — far more than VEO's 2 |
| Frame Rate | 24, 30, 60 fps | 24fps = cinematic default; 60fps for action; simulated 120fps slow-mo |
| Duration | 4–15 seconds | Per generation. Extension: unlimited chains via @Video (drift ~20th hop) |
| Prompt Length | ~50 words optimal | Longer prompts cause semantic drift. Detail via references, not mega-prompts |
| Reference Assets | 12 total: 9 images + 3 videos + 3 audio | Exceeding limit = API 400 error |
| Audio | Native dual-branch (simultaneous AV generation) | Lip-sync 10+ languages: ZH, EN, JA, KO, ES, FR, PT, ID, DE, RU |
| Pricing | ~$0.022/sec (Atlas Cloud) | ~7-8x cheaper than Sora 2 |
| Success Rate | 90%+ usable on first generation | LLM planning layer eliminates "gacha" workflows |

## Architecture: Dual-Branch DiT

Seedance 2.0 uses a **Dual-Branch Diffusion Transformer**:
- **Visual Branch**: frame synthesis via 3D spatiotemporal tokenization (NOT flat 2D frames)
- **Audio Branch**: waveform generation synchronized via Attention Bridge
- **Seed 2.0 LLM**: planning layer that decomposes prompts into structured scene plans before diffusion
- **ROPE encoding**: maintains semantic coherence across multi-shot sequences
- **RAG-Enhanced Physics Priors**: enforces realistic gravity, momentum, fabric, fluid dynamics

This means Seedance "directs" rather than "generates" — it plans shots (Wide/Medium/CU) before rendering.

## Generation Modes

### Mode 1: Text to Video
Pure text prompt. Model auto-plans camera angles and shot composition via LLM layer.

### Mode 2: Single Image I2V
1 image as start frame + text prompt. Model animates from the image.
- Computationally lighter, faster generation
- Good for: fast-cut montages, environmental shots

### Mode 3: First + Last Frame
2 images define start and end states. Model **interpolates** between them.
- 4-5 min generation time
- Logic is **interpolative** — fills in between based on text prompt
- Best for: low-complexity animations, product transforms, environmental transitions
- For complex choreography or character-heavy scenes, use Omni mode instead

### Mode 4: Omni (Full Multi-Reference)
Up to 12 assets with **@ tagging** system. Director-level control.
- **Mandatory** for recurring brand characters and complex assets
- Separates Identity Vector from Motion Vector in latent space
- See @ Reference System section below

### Mode 5: Video Extension
Uses @Video tag as **state-setter** to continue existing clips.
- Each extension adds **4-15 seconds**
- **No hard limit** on number of extensions — can chain to build multi-minute videos
- Model analyzes uploaded video's style, lighting, camera trajectory, subject appearance
- Can provide **new text prompts** with each extension (evolving narrative)
- Can use externally sourced video OR Seedance-generated video as source
- **Consistency drift** starts around 20th extension — re-upload original @Image reference to reset
- @Video provides exact physical/lighting context for next temporal block

**vs VEO extension:** VEO = 720p only, +7s per hop, max 20 hops (~148s). Seedance = any resolution, 4-15s per hop, unlimited chains but quality drifts. Both support evolving prompts per extension.

## The @ Reference System

### Syntax & Roles

| Tag | Max | Role | Example |
|-----|-----|------|---------|
| @Image1-9 | 9 images | Character identity, environment, style, product | `@Image1` = character front view |
| @Video1-3 | 3 videos | Motion migration, camera trajectory, choreography | `@Video1` = camera orbit reference |
| @Audio1-3 | 3 audio (max 15s each) | Rhythm sync, voice cloning, ambient soundscape | `@Audio1` = background beat track |

### Usage in Prompt
```
The character from @Image1 performs the choreography from @Video1
in the @Image2 setting. Sync all movement transitions to the
bass pulses of @Audio1.
```

### The 3-Angle Rule (CRITICAL for Character Consistency)

To achieve stable identity across 360-degree rotations, provide **3 views**:
1. **Front View** — facial and logo detail
2. **Profile View** — depth and silhouette
3. **3/4 View** — 3D bone structure for head turns

Without 3 angles, face will "melt" or "morph" during camera orbits. This is non-negotiable for recurring characters.

### Identity Lock vs VEO

| Feature | VEO 3.1 | Seedance 2.0 |
|---------|---------|-------------|
| Method | Filename in NB2 prompt (`cast-c1-face.png`) | @ tag to reference images (`@Image1`) |
| Views needed | 1 face image minimum | 3 angles recommended (front/profile/3/4) |
| Real faces | Allowed in some modes | **Complete ban** — use AI-generated faces only |
| Max refs | 3 images | 9 images + 3 videos + 3 audio |

## Prompt Formula

### Five-Segment Structure (Primary)
```
[Subject] + [Scene] + [Action] + [Camera] + [Style]
```

### CRAFT Framework (Multi-Asset Projects)
```
[Context] + [Reference @assets] + [Action] + [Framing] + [Tone]
```

### Optimal Prompt Pattern
```
Subject: [specific product/character from @Image1].
Scene: [environment with atmospheric depth].
Action: [precise performance, physical interaction].
Camera: [professional movement — dolly, orbit, crane].
Style: [lighting, color grading, rendering objective].
```

**Rules:**
- **~50 words max** for reliability. Beyond this, semantic alignment degrades
- Shot type is the **single most impactful** element — always specify
- Lighting description is heavily underused — always include color temperature
- One primary subject per generation. Multiple characters compete for attention
- Use concrete visuals: "small white cylindrical object with glowing blue ring" NOT "futuristic device"
- Add timing anchors: `"at 3-second mark"` to override default interpolation

## Audio-Video Joint Generation (NOT OPTIONAL)

Unlike VEO (text-based audio specs), Seedance generates audio **natively** via the Dual-Branch architecture. The Attention Bridge synchronizes visual events with audio at millisecond precision.

### Lip-Sync
- **10+ languages**: ZH, EN, JA, KO, ES, FR, PT, **ID**, DE, RU
- Phoneme-level accuracy
- Use `@Audio1` with "Reference Real Voice" command for vocal tonality cloning
- **CRITICAL**: Real face upload BANNED. Use AI-generated character faces only

### SFX (Timed Precision)
```
Native SFX: Provide a crisp 'click' sound precisely at the 3-second mark
when the character opens the metallic lid.
```

### Ambient / Background
```
Background: Heavy rain hitting a tin roof, mixed with the low hum of a neon sign.
```

### Beat-Sync (Music-Driven)
```
Sync all movement transitions to the bass pulses of @Audio1.
```

### Audio Components (3 Layers)

| Layer | How to Specify | Example |
|-------|---------------|---------|
| Dialogue/Lip-sync | Describe speech + use @Audio for voice | `Character speaks: "Welcome" using @Audio1 voice profile (Language: ID)` |
| SFX | Timed precision in prompt | `Native SFX: metallic clank at 5s mark` |
| Ambient | "Background:" descriptor | `Background: ocean wind, distant ship horn` |
| Music/Rhythm | @Audio reference + sync directive | `Sync transitions to @Audio1 beat` |

## Lip Sync Mastery

### Supported Languages (10+)
ZH (Chinese), EN (English), JA (Japanese), KO (Korean), ES (Spanish), FR (French), PT (Portuguese), **ID (Indonesian)**, DE (German), RU (Russian)

### Audio Requirements
| Param | Requirement | Notes |
|-------|------------|-------|
| Format | **MP3 only** | WAV/AAC may cause silent lip-sync failure |
| Duration | 3-8s optimal | Per clip. Max 15s per audio file |
| Pauses | 150-400ms between phrases | Seedance uses micro-pauses as alignment anchors |
| Quality | Clean, no background noise | Background noise degrades phoneme detection |

### Optimal Dialogue Length
| Clip Duration | Recommended | Notes |
|---------------|-------------|-------|
| 4-5s | 5-10 words | Short phrases, single sentence |
| 8s | 10-18 words | 1-2 sentences with natural pauses |
| 10-15s | 18-30 words | Multiple sentences, add micro-pauses |

### Face Requirements
- **AI-generated faces ONLY** — real face upload = 0% success (hard ban)
- Face should be clearly visible and well-lit for phoneme tracking
- Front-facing or slight angle preferred for lip sync accuracy
- Use 3-Angle Rule @Image references for identity consistency

### Enhancement Keywords
Add to dialogue prompts:
`"natural speech rhythm"` · `"clearly enunciated dialogue"` · `"visible lip movements"` · `"realistic jaw articulation"` · `"natural micro-expressions during speech"`

### Pronunciation
- For non-English dialogue: specify `(Language: ID)` or `(Language: JA)` in prompt
- Spell complex brand names phonetically: `"kah-ee" not "KAI"`, `"peh-lin-doh" not "Pelindo"`
- Add micro-pauses in long clauses: break into short phrases

### Voice Cloning via @Audio
```
Character speaks dialogue using @Audio1 voice profile (Language: ID).
```
Upload a clean voice sample as @Audio1. Seedance clones tonality and rhythm.

### Troubleshooting (Lip Sync)

| Problem | Cause | Fix |
|---------|-------|-----|
| Silent lip sync / no mouth movement | Audio in WAV/AAC format | Convert to MP3 |
| Lip movement misaligned | Long unbroken clause | Add micro-pauses (150-400ms) between phrases |
| Wrong language pronunciation | Language not specified | Add `(Language: XX)` in prompt |
| Lip sync on wrong character | Multiple faces in frame | Focus on single character per dialogue clip |
| Identity blocked | Real face uploaded | Use AI-generated faces only |
| Garbled audio output | Dialogue too long for clip | Shorten to optimal word count per duration |

## Camera Movement Library (Verified)

### Static
`locked-off static shot` · `fixed camera` · `tripod-mounted static`

### Push/Pull
`slow dolly push-in from MS to ECU` · `gentle dolly push-in` · `dolly pull-back revealing environment` · `dolly zoom creating vertigo effect`

### Lateral
`smooth tracking shot following subject` · `truck left` · `truck right` · `lateral tracking alongside character`

### Rotational
`slow 360-degree orbit around @Image1` · `slow pan left/right` · `whip pan with motion blur` · `tilt up from ground to sky` · `tilt down`

### Vertical
`sweeping crane-up from ground level to high-angle WS` · `descending crane shot settling at eye level` · `crane movement with tilt adjustment`

### Complex
`rack focus from foreground to background` · `Steadicam floating movement` · `POV switch to character perspective` · `gimbal-stabilized walk-and-follow`

### Stylistic
`subtle handheld feel for urgency and realism` · `documentary-style shaky cam` · `smooth cinematic glide`

### Seedance-Specific (Autonomous)
Seedance can autonomously plan camera angles via LLM layer. These keywords trigger intelligent auto-cinematography:
`"cinematic camera work"` · `"director-style shot selection"` · `"automatic storyboarding"`

**Constraint:** Avoid extremely complex simultaneous movements (e.g., "rotate 360 while zooming and subject runs toward camera") — produces inconsistent output. One primary movement at a time.

## I2V Motion Description

**Rule:** Source image anchors identity — describe MOTION only. The model already sees the image.

### Subject Micro-Movements
- Face: `"subtle micro-expressions shifting"`, `"gentle eye blinks"`, `"slight smile forming"`
- Head: `"subtle head tilt"`, `"gentle nod"`, `"slow turn toward camera"`
- Hands: `"fingers gently tapping surface"`, `"hand gesture emphasizing point"`, `"slow reach toward product"`
- Body: `"natural breathing motion"`, `"subtle weight shift"`, `"confident posture adjustment"`

### Product/Object Micro-Movements
- Rotation: `"slow parallax rotation revealing texture"`, `"gentle 15-degree turn"`
- Light: `"light sweep across surface"`, `"breathing highlight pulse"`, `"specular shimmer"`
- Scale: `"subtle float with gentle bobbing"`, `"imperceptible hover drift"`

### Ambient Motion
- Atmospheric: `"floating dust particles drifting through light beam"`, `"subtle haze drift"`
- Environmental: `"curtain edge gentle flutter"`, `"water surface micro-ripples"`, `"foliage sway"`
- Light: `"subtle light flicker from screen"`, `"shadow crawl as clouds pass"`, `"neon pulse"`

### I2V Prompt Template
```
~[duration]s, 2K, [aspect].
Camera: [movement], [speed].
Subject: [micro-movements from source image — describe MOTION only].
Maintain visual continuity with @Image1 character appearance.
Ambient: [atmospheric motion], [environmental motion].
Background: [ambient audio], [SFX if any].
[aspect] output.
```

## Material & Texture Keywords (Physics-Aware)

| Material | Keywords | Director Note |
|----------|----------|---------------|
| Metal | `brushed finish`, `anisotropic highlights`, `metallic inertia`, `matte finish` | "Metallic inertia" solves AI floatiness during camera moves |
| Glass | `Fresnel effect`, `chromatic aberration`, `layered transparency`, `refractive index` | Without these, glass looks flat/"pinned-to-glass" |
| Liquid | `momentum-based collision`, `surface tension`, `micro-droplets`, `fluid dynamics` | Essential for splash shots — controls spray pattern |
| Fabric | `natural weight`, `believable inertia`, `drape simulation` | Physics priors enforce realistic cloth behavior |

## Lighting Recipes

| Recipe | Directive | Result |
|--------|-----------|--------|
| Hero Rim Light | `High-intensity rim lighting, soft edge definition, subject separation from background` | Premium "halo" silhouette effect |
| Softbox Diffuser | `Diffused studio lighting, wrap-around illumination, minimal specular glare, 5500K color temp` | Clean commercial look for glass/metal |
| Volumetric/Tyndall | `Volumetric fog, visible light beams, Tyndall effect, atmospheric depth` | 3D tangibility, premium atmosphere |
| Cinematic Teal-Orange | `Teal-and-Orange spatiotemporal grading, warm skin tones, cool shadows` | Blockbuster commercial look |
| High-Contrast Noir | `High-contrast noir, deep blacks, single dramatic light source` | Dramatic, luxury |

## Multi-Shot Timestamp Prompting

Seedance supports in-prompt multi-shot storyboarding (unlike VEO which does 1 shot per generation):

```
[0-4s]: Wide shot. Product sits on wet cobblestone at night; neon reflections on @Image1.
        Style: @Video1 for camera orbit.
[4-9s]: Medium shot. Rain splashes against surface with momentum-based collision;
        @Audio1 bass pulses sync with water impact.
[9-15s]: Close-up. Whip pan reveals product logo in sharp focus with rim lighting.
```

### Speed Ramping in Timestamps
```
[0-4s]: Character enters at normal speed (24fps).
[4-10s]: Ramp to slow-motion (simulated 120fps) during the leap.
[10-15s]: Whip-pan transition back to 24fps for the landing.
```

## Scene Extension (Detailed)

| Constraint | Detail |
|------------|--------|
| Source | Seedance-generated OR external video |
| Per extension | 4-15 seconds added |
| Max chains | **No hard limit** (quality drifts ~20th extension) |
| Prompt per hop | Can provide new text prompt (evolving narrative) |
| Resolution | Maintains source resolution |
| Context | Model analyzes style, lighting, camera trajectory, subject appearance |

**Best practices:**
- Re-upload original @Image character reference with each extension to prevent identity drift
- Maintain consistent camera movement speed across extensions
- Keep audio style consistent (same ambient, same voice profile)
- For long chains (10+ extensions), periodically re-anchor with strong @Image references
- Hold clear pose / consistent action in final second of each clip

### Extension Prompt Template
```
Continue from @Video1. [New action / narrative development].
Camera continues [same movement] at [same speed].
Maintain character appearance from @Image1.
Background: [same ambient], [new SFX if any].
```

### Multi-Extension Storyboard Example
```
Extension 1 (0-8s): Establishing shot. Character walks into frame.
Extension 2 (8-20s): Camera tracks character. Dialogue begins.
Extension 3 (20-35s): Product reveal. Camera orbits product.
Extension 4 (35-45s): CTA. Character faces camera, speaks closing line.
```

## Transition End Instructions

| Transition | Seedance Instruction | Use |
|-----------|---------------------|-----|
| Hard Cut | `"Hard cut, immediate switch to next scene"` | Standard scene change |
| Camera Switch | `"camera switch"` keyword | Explicit shot change within single generation |
| Whip Pan | `"Fast horizontal whip pan with motion blur"` | Energy, fast transitions |
| Fade to Black | `"Slow fade to black over final 1 second"` | Scene endings, act breaks |
| Dissolve | `"Smooth dissolve transition"` or `"morph dissolve"` | Time passage, dream sequences |
| Match Cut | `"End framing matches opening of next scene"` | Visual continuity between scenes |
| Push-In | `"End with slow dolly push-in to detail"` | Building intensity |
| Pull-Back | `"End with gentle pull-back revealing context"` | Context reveal |

### Advanced: @Video Reference Transitions
Upload a reference video demonstrating the exact transition style:
```
Apply transition style from @Video1. Whip pan from product to character.
```
Seedance extracts the movement pattern and timing, not the content.

### In-Prompt Timestamp Transitions
```
[0-5s]: MS of character working. Steady tracking.
[5-5.5s]: Whip pan transition with motion blur.
[5.5-10s]: CU of product on desk. Static shot with light sweep.
```

## Safety Filters (HARD GATES)

| Rule | Detail | Consequence |
|------|--------|-------------|
| **Real face ban** | Complete ban on real human face inputs (selfies, portraits, celebrities) | **0% success rate** — immediate block |
| Copyrighted IP | Integrated filtering of franchise characters and trademarks | Generation blocked |
| Deepfake | Photorealistic digital cloning attempts blocked | Generation blocked |
| C2PA Watermark | All output embeds cryptographic provenance metadata | Cannot be removed; records model ID + timestamp |

**Workaround for character scenes:** Use **AI-generated faces** or **stylized digital artwork** for @Image references. Never upload real photographs of people.

## No Negative Prompts — Positive Constraint Syntax

Seedance 2.0 does **NOT** have a negative prompt field.

| Instead of (VEO style) | Use (Seedance style) |
|------------------------|---------------------|
| `no blur, no distortion` | `crystal-clear sharp focus, precise geometry` |
| `no cartoon effects` | `photorealistic rendering, natural textures` |
| `no text overlays` | `clean frame, unobstructed composition` |
| `no audience sounds` | `isolated ambient atmosphere, controlled soundscape` |

Embed "do not alter" instructions in the positive prompt for specific elements:
```
Maintain exact product geometry from @Image1 — do not alter proportions,
color, or surface texture.
```

## Master Template

```
[CONTEXT & STYLE]
Style: [e.g., Cyberpunk, Cinematic Realism]
Lighting: [e.g., Tyndall effect, High-contrast neon]
Environment: [Full scene description]

[@REFERENCES]
Character Identity: @Image1 (Front), @Image2 (Profile), @Image3 (3/4 View)
Motion/Camera Ref: @Video1
Audio/Rhythm Ref: @Audio1
(Total Assets: [Count] / 12)

[ACTION SEQUENCE & TIMING]
0-5s: [Segment 1 Action]
5-10s: [Segment 2 Action]
10-15s: [Segment 3 Action]

[CAMERA & MOTION DIRECTION]
Primary Movement: [e.g., Dolly push-in into 360-orbit]
Framing: [e.g., Long shot to Close-up]

[AUDIO & SYNC COMMANDS]
Dialogue/Lip-Sync: [Text] using @Audio1 voice profile (Language: EN).
SFX: [e.g., Sync 'shatter' sound to 8.5s mark]
Rhythm: Sync camera transitions to the beat of @Audio1.
```

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| Identity drift / face morphing | Missing reference angles | Provide 3 views: front + profile + 3/4 (3-Angle Rule) |
| "Prominent people" / generation blocked | Real face uploaded | Use AI-generated faces only. Never real photos |
| Semantic drift / ignored details | Prompt too long | Keep under 50 words. Move detail to @ references |
| Inconsistent motion / jittery output | Complex simultaneous movements | Simplify: one primary camera move at a time |
| Glass looks flat | Missing material keywords | Add `Fresnel effect`, `chromatic aberration`, `layered transparency` |
| Metal looks "floaty" | Missing inertia | Add `metallic inertia`, `anisotropic highlights` |
| Audio out of sync | Dialogue exceeds clip duration | Shorten dialogue to fit 8s/10s window |
| API 400 error | Exceeded 12 reference files | Check: max 9 images + 3 videos + 3 audio |
| Extension quality degrades | Identity drift over long chains | Re-upload original @Image reference every 5-10 extensions. Drift starts ~20th hop |
| Wrong aspect ratio | Mismatch between NB2 and Seedance target | Generate NB2 images natively in target ratio (16:9, 9:16, 1:1, 3:4, 4:3, 21:9) |
| Beat-sync not working | Missing @Audio reference | Add explicit `Sync transitions to @Audio1 beat` directive |
| Speed ramp looks unnatural | Missing physics keyword | Add `Realistic Inertia` for believable weight in speed changes |
| Lighting shifts during orbit | No spatiotemporal anchoring | Specify fixed light source position: `5500K key light fixed at camera-right` |

## Seedance 2.0 vs VEO 3.1 — Quick Reference

| Feature | VEO 3.1 | Seedance 2.0 |
|---------|---------|-------------|
| Resolution | 720p / 1080p | **Native 2K** (upscale 4K) |
| Max duration (single) | 8s | **15s** |
| Max duration (extended) | **148s** (20 hops) | **Unlimited chains** (4-15s/hop, drift ~20th) |
| Aspect ratios | 16:9, 9:16 | **16:9, 9:16, 1:1, 3:4, 4:3, 21:9** |
| Audio generation | Text-based in prompt | **Native dual-branch** (simultaneous) |
| Lip-sync languages | English primary | **10+ languages** incl Indonesian |
| Reference system | Up to 3 ingredient images | **12 assets** (9 img + 3 vid + 3 aud) with @ tags |
| Identity lock | Filename in NB2 prompt | **3-Angle Rule** + @Image tags |
| Real face upload | Allowed (some modes) | **Banned** (AI-generated only) |
| Multi-shot per generation | 1 shot per generation | **Timestamp-based** multi-shot |
| Negative prompts | Supported | **Not supported** (positive framing only) |
| Prompt length | 100-150 words | **~50 words** |
| Extension method | Continue from final 1s context | **@Video state-setter** + re-upload @Image for drift prevention |
| Camera auto-planning | Manual in prompt | **LLM auto-storyboarding** |
| Pricing | $0.20-0.40/sec | **~$0.022/sec** |
