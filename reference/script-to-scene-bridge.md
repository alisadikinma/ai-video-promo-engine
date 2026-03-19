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
Maintain exact facial identity from reference image: ref/cast-c{N}-face.png.
Maintain exact body proportions from reference image: ref/cast-c{N}-body.png.
{If institutional: Wearing exact uniform as shown in reference image: ref/cast-c{N}-costume.png.}
SCENE: {environment from script A/V direction}.
Match environment from reference image: ref/env-{location}.png.
{If product visible: Match exact product from reference image: ref/product-{name}.png.}
{If brand visible: Use exact brand asset from reference image: ref/brand-{asset}.png.}
EXPRESSION: {emotion from beat — see 04-cinematography-lookup.md}.
CAMERA: {shot size} {lens} {aperture}, {angle}.
LIGHTING: {pattern} {ratio}, {kelvin}K {film stock}.
ATMOSPHERE: {atmosphere type}.
CULTURAL CONTEXT: {from strategic-brief.md Cultural Context — local architecture, landmarks, plate codes, ethnicity of background figures}.
TECHNICAL: {aspect_ratio}, {resolution}, high thinking mode.
TONE: {atmosphere keywords from global-promo-config.md Section 13 per video_tone}.
WARDROBE: {wardrobe from creator profile}.
```

**End Frame Template:**
```
SUBJECT: {SAME character, NEW pose/position reflecting end-of-scene state}.
{SAME creator reference phrase — verbatim}
Maintain exact facial identity from reference image: ref/cast-c{N}-face.png.
Maintain exact body proportions from reference image: ref/cast-c{N}-body.png.
{If institutional: Wearing exact uniform as shown in reference image: ref/cast-c{N}-costume.png.}
SCENE: {SAME environment — verbatim}.
Match environment from reference image: ref/env-{location}.png.
{If product visible: Match exact product from reference image: ref/product-{name}.png.}
EXPRESSION: {evolved emotion — e.g., concern → realization}.
CAMERA: {SAME lens}, {potentially different shot size or angle}.
LIGHTING: {SAME pattern, SAME ratio, SAME kelvin — critical for consistency}.
ATMOSPHERE: {SAME atmosphere}.
CULTURAL CONTEXT: {SAME cultural context — verbatim}.
TECHNICAL: {SAME aspect ratio}, {SAME resolution}.
TONE: {SAME tone atmosphere — verbatim}.
WARDROBE: {SAME wardrobe — verbatim}.
```

**Required Reference Images Table (include after EACH prompt):**
```markdown
| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | ref/cast-c{N}-face.png | {Character name} face | ⬜ |
| 2 | ref/cast-c{N}-body.png | {Character name} full body | ⬜ |
| 3 | ref/cast-c{N}-costume.png | {Institution} uniform | ⬜ (if institutional) |
| 4 | ref/env-{location}.png | {Location} establishing | ⬜ |
| 5 | ref/product-{name}.png | Product hero shot | ⬜ (if product visible) |
| 6 | ref/brand-{asset}.png | Brand asset | ⬜ (if brand visible) |
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
Maintain exact facial identity from reference image: ref/cast-c{N}-face.png.
ANGLE: {front / three-quarter / profile} — generate all 3 for best consistency.
LIGHTING: Neutral diffused (clean identity data — NOT dramatic).
BACKGROUND: Clean, simple (studio white or neutral).
EXPRESSION: Neutral, natural.
TECHNICAL: {aspect_ratio}, 4K resolution, high thinking mode.
WARDROBE: {wardrobe from creator profile}.
```

**Required Reference Images Table (include after prompt):**
```markdown
| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | ref/cast-c{N}-face.png | {Character name} face | ⬜ |
| 2 | ref/cast-c{N}-body.png | {Character name} full body | ⬜ (if Utama) |
```

### For Multi-Character Scenes

When 2+ characters from cast-profile.md appear in the same scene:

**Multi-Character Frame Template (First+Last Frame mode):**
```
SUBJECT: Character {A} ({name}, {role}) and Character {B} ({name}, {role}) in {interaction from script}.
Using facial identity from ref/cast-c{A}-face.png for Character {A}.
Using facial identity from ref/cast-c{B}-face.png for Character {B}.
Character {A}: {full description from cast-profile.md, verbatim reference phrase}.
Character {B}: {full description from cast-profile.md, verbatim reference phrase}.
WARDROBE {A}: {costume/wardrobe from cast-profile.md or institutional uniform from ref/cast-c{A}-costume.png}.
WARDROBE {B}: {costume/wardrobe from cast-profile.md or institutional uniform from ref/cast-c{B}-costume.png}.
INTERACTION: {specific action between characters from script A/V direction}.
POSITIONING: Pemeran Utama more prominent (closer to camera, better lit, larger in frame). Pendamping in supporting position.
SCENE: {environment from ref/env-{location}.png}.
CAMERA: {shot size wide enough to fit both characters} {lens} {aperture}, {angle}.
LIGHTING: {pattern} {ratio}, {kelvin}K {film stock}.
ATMOSPHERE: {atmosphere type}.
TECHNICAL: {aspect_ratio}, {resolution}, high thinking mode.
```

**Multi-Character Ingredients Template:**
```
CHARACTER {A} REFERENCE:
SUBJECT: {Character A full description — verbatim from cast-profile.md}.
Using facial identity from ref/cast-c{A}-face.png.
WARDROBE: {costume from cast-profile.md}.
ANGLE: {front / three-quarter / profile}.
LIGHTING: Neutral diffused (clean identity data).
BACKGROUND: Clean studio white.
TECHNICAL: {aspect_ratio}, 4K, high thinking mode.

CHARACTER {B} REFERENCE:
(same structure, different character)

NOTE: Generate separate reference images per character for Ingredients mode.
VEO Ingredients accepts up to 3 reference images — use 1 per character (max 3 chars per generation).
```

**Character Hierarchy in Frame:**
- Pemeran Utama: Always more prominent (closer to camera, better lit, larger in frame)
- Pemeran Pendamping: Supporting position (slightly behind, beside, or angled away)
- Max 3 characters per frame for clean composition
- If 4+ characters needed: use shot/reverse-shot or group-then-individual sequence

**Multi-Character Consistency Checklist (in addition to standard checklist):**
- [ ] Each character's reference phrase used verbatim from cast-profile.md
- [ ] Each character's identity ref file specified (ref/cast-c{N}-face.png)
- [ ] Character hierarchy correct (Utama prominent, Pendamping supporting)
- [ ] Costume matches cast-profile.md (institutional if applicable)
- [ ] Spatial relationship between characters is physically plausible

---

## 4. Scene → VEO 3.1 Video Prompts

### Presenter Scene (Lip Sync) Template

```
~{duration}s, {resolution}, {aspect_ratio}.
Camera: {camera_movement from 04-cinematography-lookup.md}, {speed}.
Subject: {micro-movements — subtle eye blinks every 2-3 seconds, gentle breathing motion}.
Maintain exact facial identity from reference image: ref/cast-c{N}-face.png.
{If institutional: Wearing exact uniform as shown in reference image: ref/cast-c{N}-costume.png.}
{Character} says: {narration text from script — max 8-15 words per 8s}.
Expression shift: {start_emotion} to {end_emotion} over {duration}s.
SFX: {sound effects from script}.
Ambient: {background atmosphere + music direction}.
Tone atmosphere: {from global-promo-config.md Section 13 per video_tone}.
{veo_negative_prompt from global-promo-config.md}
Maintain exact lighting, environment, appearance from reference image.
```

**Required Reference Images Table (include after EACH VEO prompt):**
```markdown
| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | ref/cast-c{N}-face.png | {Character name} face | ⬜ |
| 2 | ref/cast-c{N}-costume.png | Costume/uniform | ⬜ (if institutional) |
| 3 | ref/env-{location}.png | Environment | ⬜ (if location-specific) |
```

### B-Roll Scene (Voiceover, No Lip Sync) Template

```
~{duration}s, {resolution}, {aspect_ratio}.
Camera: {camera_movement}, {speed}.
Subject: {product/environment action from script}.
{If product visible: Match exact product from reference image: ref/product-{name}.png.}
{If environment: Match environment from reference image: ref/env-{location}.png.}
{If brand visible: Use exact brand asset from reference image: ref/brand-{asset}.png.}
{ambient_motion — floating particles, screen content shifting, etc.}
Voiceover: {narration text from script}.
SFX: {sound effects}.
Ambient: {background music + atmosphere}.
Tone atmosphere: {from global-promo-config.md Section 13 per video_tone — e.g., "lighthearted, bright" or "tense, dramatic"}.
Cultural context: {from strategic-brief.md — local ambient sounds, weather atmosphere, architectural backdrop}.
{veo_negative_prompt}
No character lip sync. Voiceover is background narration track only.
```

**Required Reference Images Table (include after EACH VEO prompt):**
```markdown
| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | ref/product-{name}.png | Product shot | ⬜ (if product visible) |
| 2 | ref/env-{location}.png | Environment | ⬜ (if location-specific) |
| 3 | ref/brand-{asset}.png | Brand asset | ⬜ (if brand visible) |
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

### Multi-Character Presenter Scene (Sequential Dialogue)

When 2+ characters have dialogue in the same scene:

```
~{duration}s, {resolution}, {aspect_ratio}.
Camera: {camera_movement — typically wider shot to fit both characters}, {speed}.
Character {A} and Character {B} in {setting from scene}.
Maintain exact facial identity from reference image: ref/cast-c{A}-face.png for Character {A}.
Maintain exact facial identity from reference image: ref/cast-c{B}-face.png for Character {B}.
{If institutional: Character {A} wearing exact uniform from ref/cast-c{A}-costume.png.}
{If institutional: Character {B} wearing exact uniform from ref/cast-c{B}-costume.png.}
Character {A} says: {dialogue line — max 8-15 words}.
[0.3-0.5s pause — Character {B} reacts with {micro-expression}]
Character {B} says: {response — max 8-15 words}.
Both characters: {shared micro-movements — subtle breathing, natural eye contact shifts}.
SFX: {sound effects from script}.
Ambient: {background atmosphere + music direction}.
{veo_negative_prompt from global-promo-config.md}
Maintain exact appearance from reference images for ALL characters.
```

**Required Reference Images Table (include after EACH multi-char VEO prompt):**
```markdown
| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | ref/cast-c{A}-face.png | {Character A name} face | ⬜ |
| 2 | ref/cast-c{B}-face.png | {Character B name} face | ⬜ |
| 3 | ref/cast-c{A}-costume.png | {Character A} costume | ⬜ (if institutional) |
| 4 | ref/cast-c{B}-costume.png | {Character B} costume | ⬜ (if institutional) |
| 5 | ref/env-{location}.png | Environment | ⬜ |
```

**CRITICAL VEO LIP SYNC RULE:** VEO handles 1 speaker at a time.
- For dialogue exchange: sequential delivery with reaction pauses, NOT simultaneous speaking
- Max 2 dialogue turns per 8s clip (each turn 3-6s)
- If scene needs more dialogue turns: use Extend or split into multiple clips

### Multi-Character B-Roll Scene (No Dialogue)

```
~{duration}s, {resolution}, {aspect_ratio}.
Camera: {camera_movement}, {speed}.
Character {A} and Character {B} {action from script — e.g., walking through facility, reviewing dashboard}.
Maintain exact facial identity from reference image: ref/cast-c{A}-face.png for Character {A}.
Maintain exact facial identity from reference image: ref/cast-c{B}-face.png for Character {B}.
{If institutional: Character {A} wearing exact uniform from ref/cast-c{A}-costume.png.}
{If institutional: Character {B} wearing exact uniform from ref/cast-c{B}-costume.png.}
{If product visible: Match exact product from reference image: ref/product-{name}.png.}
{ambient_motion — characters interact naturally with environment}.
Voiceover: {narration text from script}.
SFX: {sound effects}.
Ambient: {background music + atmosphere}.
{veo_negative_prompt}
No character lip sync. Voiceover is background narration track only.
Maintain appearance consistency for all characters from reference images.
```

**Required Reference Images Table:**
```markdown
| # | Reference File | Content | Upload Status |
|---|---------------|---------|---------------|
| 1 | ref/cast-c{A}-face.png | {Character A name} face | ⬜ |
| 2 | ref/cast-c{B}-face.png | {Character B name} face | ⬜ |
| 3 | ref/cast-c{A}-costume.png | {Character A} costume | ⬜ (if institutional) |
| 4 | ref/cast-c{B}-costume.png | {Character B} costume | ⬜ (if institutional) |
| 5 | ref/product-{name}.png | Product shot | ⬜ (if product visible) |
| 6 | ref/env-{location}.png | Environment | ⬜ |
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
- [ ] All cast members' reference phrases used verbatim (not generic "creator")
- [ ] Multi-character scenes specify EACH character's identity ref (ref/cast-c{N}-face.png)
- [ ] Character hierarchy correct (Pemeran Utama prominent, Pendamping supporting)
- [ ] Costume matches institution ref (if institutional) — ref/cast-c{N}-costume.png
- [ ] ref-manifest.md validated before generating any prompts (Phase 3.5 gate)
- [ ] Max 3 characters per frame (4+ use shot/reverse-shot)
- [ ] VEO dialogue scenes: 1 speaker at a time, sequential delivery
- [ ] **All reference images explicitly embedded in prompt text** (not just uploaded as files)
- [ ] **Reference image injection syntax used** (`maintain exact facial identity from reference image: ref/cast-c{N}-face.png`)
- [ ] **Required Reference Images table included after EACH prompt** (NB2 and VEO)

---

## 8. Full Production Plan Template (--full mode)

```markdown
# Video Production Plan — {Video Title}

## Strategic Brief
{From Phase 1 output}

## Cast Summary
{From cast-profile.md}

| # | Name | Role | Identity Lock | Ref Files |
|---|------|------|---------------|-----------|

## Reference Manifest
{From ref-manifest.md — Phase 3.5 validated}
Total refs: {N}/{N} ✅

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

#### Required Reference Images (MANDATORY — upload before generating)
| # | Filename | Content | Embedded in Prompt? | Upload Status |
|---|----------|---------|--------------------|----|
| 1 | ref/cast-c1-face.png | {Character 1 name} face — identity lock | ✅ Yes | ⬜ |
| 2 | ref/cast-c2-face.png | {Character 2 name} face — identity lock | ✅ Yes | ⬜ |
| 3 | ref/product-{name}.png | Product shot — scene context | ✅ Yes | ⬜ |
| 4 | ref/env-{location}.png | Environment — background | ✅ Yes | ⬜ |
| 5 | ref/costume-{institution}.png | Institutional uniform — wardrobe ref | ✅ Yes | ⬜ |

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

---

## 9. Reference Manifest Generation (Phase 3.5)

### Auto-Derive Algorithm

**INPUT:** scene-plan.md + cast-profile.md + strategic-brief.md

```
# Step 1: Cast references
FOR each character in cast-profile.md:
    IF role == "Pemeran Utama":
        ADD ref/cast-c{N}-face.png    (MANDATORY)
        ADD ref/cast-c{N}-body.png    (MANDATORY)
        IF institution_detected:
            ADD ref/cast-c{N}-costume.png (MANDATORY)
    IF role == "Pemeran Pendamping":
        ADD ref/cast-c{N}-face.png    (MANDATORY)

# Step 2: Environment references
locations = []
FOR each scene in scene-plan.md:
    EXTRACT location from visual description
    IF location NOT IN locations:
        locations.append(location)
        ADD ref/env-{location-slug}.png (MANDATORY)

# Step 3: Product references
products = []
FOR each scene in scene-plan.md:
    IF scene mentions product by name:
        IF product NOT IN products:
            products.append(product)
            ADD ref/product-{product-slug}.png (MANDATORY)

# Step 4: Brand asset references
brand_assets = []
FOR each scene in scene-plan.md:
    IF scene mentions brand logo, UI, dashboard, packaging:
        IF asset NOT IN brand_assets:
            brand_assets.append(asset)
            ADD ref/brand-{asset-slug}.png (MANDATORY)

# Step 5: Institution costume (shared)
IF institution_detected:
    ADD ref/costume-{institution-slug}.png (MANDATORY)
```

**OUTPUT:** ref-manifest.md

### Manifest Output Format

```markdown
# Reference Manifest — {Video Title}

## Overview
| Total Required | {N} images |
| Validation Mode | Hard Block (cannot proceed without 100%) |
| Naming Convention | Per global-promo-config.md Section 11 |

## Cast References

### Character 1: {Name} ({Role}) — {FULL/MINIMAL} REF
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/cast-c1-face.png | Face front view | {scene_list} | ⬜/✅ |
| ref/cast-c1-body.png | Full body | {scene_list} | ⬜/✅ |
| ref/cast-c1-costume.png | {Institution} uniform | {scene_list} | ⬜/✅ |

(repeat per character)

## Product References
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/product-{name}.png | {description} | {scene_list} | ⬜/✅ |

## Environment References
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/env-{location}.png | {description} | {scene_list} | ⬜/✅ |

## Brand Assets
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/brand-{asset}.png | {description} | {scene_list} | ⬜/✅ |

## Costume/Uniform (Institution: {name})
| Filename | Content | Used in Scenes | Status |
|----------|---------|----------------|--------|
| ref/costume-{institution}.png | {uniform_type} front view | All cast scenes | ⬜/✅ |

## Validation Summary
- Total required: {N}
- Uploaded: {M}/{N}
- Status: ❌ BLOCKED / ✅ PASSED
```

### Scene-to-Ref Mapping

After manifest is built, create a reverse mapping showing which refs each scene needs:

```markdown
## Scene-to-Reference Map

| Scene # | Beat | Characters | Product | Environment | Brand | Costume |
|---------|------|-----------|---------|-------------|-------|---------|
| 1 | Pattern Interrupt | — | — | ref/env-outdoor.png | — | — |
| 2 | Hook | c1, c3 | — | ref/env-studio.png | — | ref/costume-kai.png |
| 3 | Foreshadow | c1 | ref/product-hero.png | ref/env-studio.png | — | ref/costume-kai.png |
| ... | ... | ... | ... | ... | ... | ... |
```

This map is used in Phase 4 to ensure each scene's NB2 prompts reference the correct files.

---

## 10. Tone-to-Cinematography Mapping

Reference `global-promo-config.md` Section 13 for the full Tone Impact Matrix. This section provides operational lookup for Phase 4 (NB2) and Phase 5 (VEO).

### Tone → Lighting Setup

| Tone | Lighting Ratio | Kelvin | Atmosphere | Film Stock Override |
|------|---------------|--------|------------|-------------------|
| Humorous | 2:1 (bright, flat) | 5600K (daylight) | Clean, bright | Kodak Portra 400 (warm, friendly) |
| Serious | 4:1+ (dramatic) | 3200K (tungsten) | Heavy haze, shadows | Kodak Vision3 500T (default) |
| Professional | 2:1 (clean, even) | 4500K (neutral) | Clean, minimal | Kodak Ektar 100 (sharp, precise) |
| Inspirational | 3:1 (warm glow) | 3500K (golden) | Light haze, warm | Kodak Portra 400 (warm) |
| Casual | 2:1 (natural) | 5600K (daylight) | Natural, minimal | Fujifilm Pro 400H (soft, natural) |
| Edgy | 6:1+ (harsh contrast) | Mixed warm/cool | Smoke, grit | Kodak T-MAX 3200 (grainy, raw) |

### Tone → Camera Style

| Tone | Default Shot | Lens | Movement | Angle |
|------|-------------|------|----------|-------|
| Humorous | MS/MWS (wider) | 35mm | Handheld-style, bounce | Eye-level, playful |
| Serious | CU/MCU (tight) | 85mm | Slow dolly/push | Eye-level to low |
| Professional | MCU/MS (standard) | 50mm | Steady, precise | Eye-level |
| Inspirational | MS to WS (sweeping) | 35mm | Crane/jib, reveal | Low angle (heroic) |
| Casual | MCU/MS | 50mm | Gentle handheld | Eye-level |
| Edgy | CU/ECU (extreme) | 24mm wide | Fast whip pan, dutch | Dutch tilt 10-15° |

### Tone → Audio Direction

| Tone | Music Style | SFX | Ambient |
|------|------------|-----|---------|
| Humorous | Upbeat, quirky, pizzicato | Comic timing whooshes, playful pops | Light, airy room tone |
| Serious | Orchestral, minimal, sparse | Impact hits, silence beats, bass drops | Deep rumble, tension drone |
| Professional | Corporate ambient, clean synth | Subtle UI clicks, clean transitions | Quiet office hum |
| Inspirational | Swelling strings, piano, emotional build | Risers, swells, chime accents | Open air, nature |
| Casual | Acoustic guitar, chill lo-fi | Natural sounds, soft transitions | Cafe ambiance, street life |
| Edgy | Electronic, aggressive beats, distortion | Glitch effects, bass stabs, static | Industrial hum, urban noise |

### Tone → Character Expression (NB2)

| Tone | Default Expression | Eye Direction | Micro-movements |
|------|-------------------|---------------|-----------------|
| Humorous | Warm smile, playful, expressive | Direct to camera, wink | Active gestures, head tilts |
| Serious | Stern, determined, intense | Direct to camera, unwavering | Minimal, controlled |
| Professional | Confident, neutral, composed | Direct, slight nod | Measured hand gestures |
| Inspirational | Hopeful, inspired, eyes bright | Upward/forward, visionary | Open palms, expansive |
| Casual | Relaxed, friendly, natural | Varied, conversational | Natural fidgets, nods |
| Edgy | Intense, challenging, sharp | Piercing direct stare | Sharp head turns, pointed |

### How to Apply

When generating NB2/VEO prompts:
1. Read `video_tone` from strategic-brief.md
2. Look up tone in tables above
3. Override default cinematography values with tone-specific values
4. Inject tone atmosphere keywords into VEO prompt
5. Apply tone expression to character NB2 prompts

---

## 11. Ref Image NB2 Prompt Templates

Templates for generating reference images when user doesn't have them. Used in Phase 3.5 Step 3.5.2b.

Reference `global-promo-config.md` Section 15 for NB2 defaults (ref images use neutral lighting, clean bg, 4K, CFG 6.0, Denoise 0.40, Thinking High).

**CRITICAL: Follow dependency order from `global-promo-config.md` Section 17.**
Generate in this order: Tier 1 (face + product + env) → Tier 2 (body) → Tier 3 (costume) → Tier 4 (scene images). Each downstream tier MUST inject upstream refs in its prompt.

### Cast Face Reference Template — TIER 1 (no upstream dependency)

```
SUBJECT: {ethnicity} {gender}, {age_range}, {key_features from cast-profile.md}.
Portrait, front view, looking directly at camera.
EXPRESSION: Neutral, natural, relaxed.
BACKGROUND: Clean studio white, seamless.
LIGHTING: Neutral diffused soft light, even illumination, no dramatic shadows.
CAMERA: Medium close-up, 85mm f/2.8, eye-level.
TECHNICAL: {aspect_ratio}, 4K resolution, CFG 6.0, Denoise 0.40, Thinking High.
No accessories obscuring face. Hair naturally styled. Skin texture visible.
```

**Dependency:** None — this is the foundational identity anchor. Generate FIRST.

### Cast Body Reference Template — TIER 2 (depends on face ref)

```
SUBJECT: {ethnicity} {gender}, {age_range}, {key_features from cast-profile.md}.
Maintain exact facial identity from reference image: ref/cast-c{N}-face.png.
Full body standing pose, feet visible, arms relaxed at sides.
WARDROBE: {wardrobe from cast-profile.md — e.g., "navy blazer, white open-collar shirt"}.
EXPRESSION: Neutral, confident posture.
BACKGROUND: Clean studio white, seamless.
LIGHTING: Neutral diffused soft light, even from head to toe.
CAMERA: Full body shot, 50mm f/4, eye-level.
TECHNICAL: {aspect_ratio}, 4K resolution, CFG 6.0, Denoise 0.40, Thinking High.
Full wardrobe clearly visible. Natural standing pose.
Face MUST match ref/cast-c{N}-face.png exactly — same person, same features.
```

**Dependency:** ref/cast-c{N}-face.png MUST exist before generating this.

**Required Upstream Reference:**
```markdown
| # | Reference File | Content | Status |
|---|---------------|---------|--------|
| 1 | ref/cast-c{N}-face.png | Face identity anchor (Tier 1) | Must be ✅ |
```

### Cast Costume/Uniform Reference Template — TIER 3 (depends on face + body ref)

```
SUBJECT: Official {institution} uniform worn by {ethnicity} {gender}, {age_range}.
Maintain exact facial identity from reference image: ref/cast-c{N}-face.png.
Maintain exact body proportions and build from reference image: ref/cast-c{N}-body.png.
Front view, full uniform visible from collar to shoes.
DETAILS: {uniform_color}, {emblem/badge description — position, colors, text if known}.
{Rank insignia if applicable}. {Hat/headwear if applicable}.
ACCESSORIES: {ID badge, belt, shoes specific to institution}.
BACKGROUND: Clean neutral gray.
LIGHTING: Neutral diffused, even illumination to show all uniform details.
CAMERA: Full body, 50mm f/4, eye-level.
TECHNICAL: {aspect_ratio}, 4K resolution, CFG 6.0, Denoise 0.40, Thinking High.
Face and body MUST match ref/cast-c{N}-face.png and ref/cast-c{N}-body.png — same person in uniform.
NOTE: AI cannot generate accurate institutional logos/badges — describe placement and colors instead.
```

**Dependency:** ref/cast-c{N}-face.png AND ref/cast-c{N}-body.png MUST exist before generating this.

**Required Upstream References:**
```markdown
| # | Reference File | Content | Status |
|---|---------------|---------|--------|
| 1 | ref/cast-c{N}-face.png | Face identity anchor (Tier 1) | Must be ✅ |
| 2 | ref/cast-c{N}-body.png | Body proportions (Tier 2) | Must be ✅ |
```

### Product Reference Template — TIER 1 (no upstream dependency)

```
SUBJECT: {product_name} — {brief product description from strategic-brief.md}.
Hero angle, {product_orientation — e.g., "three-quarter view showing interface"}.
{Key visual features — screen content, buttons, packaging details}.
BACKGROUND: Clean white or light gradient.
LIGHTING: Soft commercial lighting, subtle shadow for depth, even illumination.
CAMERA: Product shot, {lens based on product size — 50mm for small, 35mm for large}, f/5.6.
TECHNICAL: {aspect_ratio}, 4K resolution, CFG 6.0, Denoise 0.40, Thinking High.
Professional product photography style. No distracting elements.
```

**Dependency:** None — independent of character refs. Can be generated in parallel with Tier 1 face refs.

### Environment Reference Template — TIER 1 (depends on cultural research, not other refs)

```
SUBJECT: Wide establishing shot of {location}, {region}, Indonesia.
ARCHITECTURE: {cultural_architecture from strategic-brief.md Cultural Context}.
LANDMARKS: {cultural_landmarks visible in mid-ground or background}.
VEHICLES: Vehicles with {cultural_plate_code}-series license plates visible in street/parking.
PEOPLE: Background figures with {cultural_ethnicity} appearance — {cultural_physical_features}.
SKY/WEATHER: {cultural_weather — e.g., "tropical humid atmosphere, bright equatorial sun, cumulus clouds"}.
VEGETATION: {local_flora — e.g., "tropical palms, frangipani trees"}.
TIME OF DAY: {morning/midday/afternoon/evening — based on scene requirement}.
CAMERA: Wide shot, 24mm f/8, eye-level.
LIGHTING: Natural {time_of_day} light, {cultural_weather_kelvin}K.
TECHNICAL: 16:9, 4K resolution, CFG 6.0, Denoise 0.40, Thinking High.
Photorealistic, authentic Indonesian {region} atmosphere.
```

**Dependency:** Cultural research data (Step 3.5.2a) must be completed first. No dependency on other ref images. Can be generated in parallel with Tier 1 face/product refs.

### Brand Logo — CANNOT GENERATE

```
⚠️ Brand logo CANNOT be reliably generated by AI image models.
Logos require exact typography, specific color codes, and precise geometry
that AI models cannot reproduce accurately.

INSTRUCTION TO USER:
"Brand logo tidak bisa di-generate oleh AI. Silakan provide file logo asli
dalam format PNG (transparent background preferred) ke: ref/brand-{name}.png"

If user insists on AI generation, warn:
"Logo yang di-generate AI TIDAK akan akurat — typography, warna, dan proporsi
akan berbeda dari logo asli. Sangat direkomendasikan pakai file logo yang sudah ada."
```

### Template Usage Notes

1. All ref image templates use **neutral lighting** — NOT cinematic/dramatic
2. All ref image templates use **clean backgrounds** — NOT scene environments
3. Ref images are for AI identity lock — they need CLARITY over AESTHETICS
4. Cultural context (from Step 3.5.2a) is ONLY injected into **Environment** template
5. Cast face/body templates pull description from **cast-profile.md** verbatim
6. If institution detected, costume template pulls from **global-promo-config.md** Section 12
7. **MUST follow dependency order** from `global-promo-config.md` Section 17: face → body → costume → scene images
8. **Downstream refs MUST inject upstream refs** — body prompt injects face ref, costume prompt injects face + body ref
9. **Within each tier, generate in parallel** — all Tier 1 refs can be generated simultaneously
10. **Validate each tier before advancing** — all Tier 1 refs must be ✅ before starting Tier 2
