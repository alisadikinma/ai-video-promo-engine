# Script-to-Scene Bridge

Converts a finished A/V script into a scene-by-scene production plan with NB2 image prompts and VEO 3.1 video prompts. This is the critical bridge between Phase 2 (Script) and Phase 4-5 (Image/Video Prompts).

---

## 1. Script → Scene Decomposition Algorithm

### Input: A/V Script (from Phase 2)

The script from Phase 2 contains:
- Beat labels (Pattern Interrupt, Hook, Foreshadow, Agitate, Guide, Peak, CTA, Won Day)
- Timing per beat
- Narration/dialogue text
- Visual descriptions
- Audio direction

### Step 1: Beat → Scene Mapping

Each beat in the 7-beat arc maps to 1 or more scenes:

| Beat | Typical Duration | Scenes | VEO Clips Needed |
|------|-----------------|--------|-------------------|
| Pattern Interrupt | 0–1.7s | 1 | 1 clip (4s) |
| Hook | 1.7–5s | 1 | 1 clip (4-6s) |
| Foreshadow | 5–8s | 1 | 1 clip (8s) |
| Agitate | 8–15s | 1-2 | 1-2 clips |
| Guide + Plan | 15–40s | 3-5 | 3-5 clips + extends |
| Peak | 60-75% mark | 1-2 | 1-2 clips |
| CTA | Post-peak | 1 | 1 clip (8s) |
| Won Day | Final frame | 1 | 1 clip (4-8s) |
| **Total** | **120-180s** | **10-15** | **10-18 clips** |

### Step 2: Scene Duration Allocation

For each scene, calculate optimal VEO clip strategy:

```
IF scene_duration <= 8s:
    → 1 VEO generation (4/6/8s)
    → Resolution: 1080p OK (no extend needed)

IF 8s < scene_duration <= 15s:
    → 1 VEO generation (8s) + 1 extend (+7s)
    → Resolution: MUST be 720p (extend requirement)

IF 15s < scene_duration <= 22s:
    → 1 VEO generation (8s) + 2 extends (+14s)
    → Resolution: MUST be 720p

IF scene_duration > 22s:
    → Consider splitting into 2 separate scenes
    → Or: 1 gen (8s) + 3+ extends (diminishing quality)
```

### Step 3: VEO Mode Selection per Scene

```
FOR each scene:
    IF scene has SAME CHARACTER talking (lip sync):
        IF same character continues from previous scene:
            → Ingredients mode (character consistency)
            → Use same ref images
        ELSE:
            → Ingredients mode (new ref images)

    IF scene shows STATE CHANGE (before→after, open→close):
        → First+Last Frame mode
        → Generate START image (NB2) + END image (NB2)

    IF scene is B-ROLL (no character, product/environment):
        → First+Last Frame mode
        → Generate START image (NB2) + END image (NB2)

    IF scene CONTINUES previous scene (same location, same action):
        → Extend mode
        → Source: previous VEO clip (720p)
        → Max: +7s per hop

    NEVER combine Ingredients + First+Last Frame in same generation
```

---

## 2. Scene Plan Output Format

### Scene Plan Table (scene-plan.md)

```markdown
# Scene Plan — {Video Title}

## Overview
| Total Duration | {X}s |
| Total Scenes | {N} |
| Total VEO Clips | {M} (generations + extensions) |
| Resolution Strategy | 720p for extendable, 1080p for final-only |
| Aspect Ratio | {16:9 / 9:16} |

## Scene Breakdown

| # | Beat | Duration | VEO Mode | Extend? | Resolution | Scene Type | Dialogue? |
|---|------|----------|----------|---------|------------|------------|-----------|
| 1 | Pattern Interrupt | 4s | Frame | No | 1080p | B-Roll | No |
| 2 | Hook | 6s | Frame | No | 1080p | Presenter | Yes (lip sync) |
| 3 | Foreshadow | 8s | Frame | No | 720p | Presenter | Yes (lip sync) |
| 4 | Agitate | 15s | Ingredients+Ext | 1x | 720p | Presenter | Yes (lip sync) |
| 5 | Guide 1 | 8s | Frame | No | 720p | B-Roll | VO only |
| 6 | Guide 2 | 15s | Ingredients+Ext | 1x | 720p | Presenter | Yes (lip sync) |
| ... | ... | ... | ... | ... | ... | ... | ... |

## Extension Chain Map

Scene 4: Clip 4a (8s, 720p) → Extend → Clip 4b (+7s) = 15s total
Scene 6: Clip 6a (8s, 720p) → Extend → Clip 6b (+7s) = 15s total
```

---

## 3. Scene → NB2 Image Prompts

### For First+Last Frame Mode

Generate TWO NB2 images per scene:

**Start Frame Template:**
```
SUBJECT: {character/product description from script}.
{Creator reference phrase from creator-profile.md}
SCENE: {environment from script A/V direction}.
EXPRESSION: {emotion from beat — see 04-cinematography-lookup.md}.
CAMERA: {shot size} {lens} {aperture}, {angle}.
LIGHTING: {pattern} {ratio}, {kelvin}K {film stock}.
ATMOSPHERE: {atmosphere type}.
TECHNICAL: {aspect_ratio}, {resolution}, high thinking mode.
WARDROBE: {wardrobe from creator profile}.
```

**End Frame Template:**
```
SUBJECT: {SAME character, NEW pose/position reflecting end-of-scene state}.
{SAME creator reference phrase — verbatim}
SCENE: {SAME environment — verbatim}.
EXPRESSION: {evolved emotion — e.g., concern → realization}.
CAMERA: {SAME lens}, {potentially different shot size or angle}.
LIGHTING: {SAME pattern, SAME ratio, SAME kelvin — critical for consistency}.
ATMOSPHERE: {SAME atmosphere}.
TECHNICAL: {SAME aspect ratio}, {SAME resolution}.
WARDROBE: {SAME wardrobe — verbatim}.
```

**Consistency Checklist (Start ↔ End):**
- [ ] Same aspect ratio
- [ ] Same lighting temperature (Kelvin)
- [ ] Same color palette / grading style
- [ ] Character wardrobe identical
- [ ] Same lens focal length
- [ ] End frame = plausible physical destination from start
- [ ] Central 60% rule maintained

### For Ingredients Mode

Generate 1-3 reference images:

**Character Reference Template:**
```
SUBJECT: {character full description — SAME text verbatim across ALL refs}.
{Creator reference phrase from creator-profile.md}
ANGLE: {front / three-quarter / profile} — generate all 3 for best consistency.
LIGHTING: Neutral diffused (clean identity data — NOT dramatic).
BACKGROUND: Clean, simple (studio white or neutral).
EXPRESSION: Neutral, natural.
TECHNICAL: {aspect_ratio}, 4K resolution, high thinking mode.
WARDROBE: {wardrobe from creator profile}.
```

---

## 4. Scene → VEO 3.1 Video Prompts

### Presenter Scene (Lip Sync) Template

```
~{duration}s, {resolution}, {aspect_ratio}.
Camera: {camera_movement from 04-cinematography-lookup.md}, {speed}.
Subject: {micro-movements — subtle eye blinks every 2-3 seconds, gentle breathing motion}.
{Character} says: {narration text from script — max 8-15 words per 8s}.
Expression shift: {start_emotion} to {end_emotion} over {duration}s.
SFX: {sound effects from script}.
Ambient: {background atmosphere + music direction}.
{veo_negative_prompt from global-promo-config.md}
Maintain exact lighting, environment, appearance from reference image.
```

### B-Roll Scene (Voiceover, No Lip Sync) Template

```
~{duration}s, {resolution}, {aspect_ratio}.
Camera: {camera_movement}, {speed}.
Subject: {product/environment action from script}.
{ambient_motion — floating particles, screen content shifting, etc.}
Voiceover: {narration text from script}.
SFX: {sound effects}.
Ambient: {background music + atmosphere}.
{veo_negative_prompt}
No character lip sync. Voiceover is background narration track only.
```

### Extension Prompt Template

```
Continue from previous clip. {new_action from next script beat}.
Camera continues {same_movement} at {same_speed}.
Maintain lighting, environment, character appearance.
{Character} says: {next_dialogue — max 8-15 words}.
Audio continues: {same_ambient}, {new_sfx if any}.
{veo_negative_prompt}
```

---

## 5. Scene Transition Handling

### Between Different Scenes (Cut/Dissolve/etc.)

1. Check transition type from script A/V direction
2. Add transition end instruction to PREVIOUS scene's VEO prompt:

| Transition | VEO Instruction |
|-----------|-----------------|
| Cut | `Hard cut, immediate switch` |
| Push-In | `End with slow dolly push-in` |
| Pull-Back | `End with gentle pull-back` |
| Whip-Pan | `Fast horizontal pan with motion blur` |
| Fade to Black | `Slow opacity fade to black over 12 frames` |
| Dissolve | `Cross-dissolve preparation, hold final pose` |
| Match Cut | `End framing matches first frame of next shot` |

3. **"Last Frame Secret"** for visual continuity across cuts:
   - Export final frame of Scene A
   - Feed into NB2 as reference for Scene B's start frame
   - Preserves grading, character position, lighting across the cut

### Within Same Scene (Extension)

1. Hold pose for final 0.5s of current clip
2. Maintain consistent camera movement speed
3. Avoid new characters entering in final second
4. Keep audio element present in final second
5. Resolution lock: 720p across ALL segments in chain

---

## 6. Audio Layer Planning

For each scene, explicitly plan all 3 audio layers:

| Scene Type | Layer 1: Dialogue | Layer 2: SFX | Layer 3: Ambient |
|------------|-------------------|--------------|------------------|
| Presenter (lip sync) | `Host says: {text}` | `SFX: {effect}` | `Ambient: {atmosphere}` |
| B-Roll (voiceover) | `Voiceover: {text}` | `SFX: {effect}` | `Ambient: {music + atmosphere}` |
| B-Roll (no narration) | — | `SFX: {effect}` | `Ambient: {music + atmosphere}` |
| Product demo | `Host says: {text}` or VO | `SFX: UI clicks, tech sounds` | `Ambient: subtle music` |
| Testimonial | `Speaker says: {text}` | — | `Ambient: soft room tone` |

**Critical Rules:**
- ALL 3 layers must be specified (or explicitly marked as silent)
- Unspecified audio = VEO guesses random sounds
- Pronunciation: spell phonetically for non-English words
- Always add: `no subtitles, no audience sounds`
- Dialogue uses colon syntax (NEVER quotation marks)

---

## 7. Quality Audit Checklist (Per Scene)

Before finalizing each scene's prompts:

- [ ] NB2 aspect ratio matches VEO target ratio
- [ ] VEO mode is correct (Ingredients ≠ First+Last Frame)
- [ ] Audio all 3 layers specified
- [ ] Dialogue uses colon syntax (not quotes)
- [ ] Resolution = 720p if extending, 1080p if final-only
- [ ] Creator reference phrase verbatim (if presenter scene)
- [ ] Wardrobe consistent across all clips in scene
- [ ] Lighting Kelvin consistent between start/end frames
- [ ] Central 60% rule for critical action
- [ ] Face >30% frame for lip sync scenes
- [ ] Extension prompt references previous clip context
- [ ] Transition instruction added to scene-ending clip

---

## 8. Full Production Plan Template (--full mode)

```markdown
# Video Production Plan — {Video Title}

## Strategic Brief
{From Phase 1 output}

## A/V Script Summary
{Key beats and timing from Phase 2}

## Scene Breakdown
{Scene plan table from Section 2}

## Per-Scene Production

### Scene {N}: {Beat Name} ({start_time}–{end_time})

**Storyboard:** {1-2 sentence visual description}
**VEO Mode:** {Frame / Ingredients / Extend}
**Resolution:** {720p / 1080p}
**Duration:** {Xs} = {1 gen} + {N extends}
**Audio Type:** {Presenter lip sync / B-Roll voiceover / Music only}

#### NB2 Start Frame
```
{full NB2 prompt}
```

#### NB2 End Frame (if Frame mode)
```
{full NB2 prompt}
```

#### VEO Prompt
```
{full VEO prompt}
```

#### Extension Prompt (if applicable)
```
{full extension prompt}
```

#### Reference Images
| Filename | Content | Usage |
|----------|---------|-------|
| creator-face.png | Presenter face | Identity lock |
| ref-{product}.png | Product shot | Scene context |

---

## Post-Production Checklist
- [ ] No identity drift across all clips
- [ ] Lighting consistent across all segments
- [ ] Audio seamless at extension joints
- [ ] No edge hallucination from ratio mismatch
- [ ] All transitions smooth between scenes
- [ ] Total duration within 120-180s target
- [ ] Narration timing matches dialogue constraints
```
