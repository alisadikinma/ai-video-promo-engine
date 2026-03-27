---
source: Creator Cinematography Guide, AI Video Production Reference Sections 10-11 (Docs 5-6)
curated: 2026-03-19
version: 2.0
tokens: ~2800
platform: claude-projects
---

# Creator Profile & Holiday Production

> **Cast System Note:** Ali Sadikin is a preset that fills exactly 1 Pemeran Utama slot
> in the cast system. When activated, the slot number {N} is assigned during cast builder
> (Phase 1). All references below use `ref/cast-c{N}-face.png` where {N} = Ali's assigned
> cast slot. See `creator-profile-system.md` Section 2 for full integration details.

## Ali Sadikin MA — Physical Reference

| Attribute | Spec | Cinematography Impact |
|-----------|------|----------------------|
| Ethnicity | Indonesian | — |
| Age | Late 30s | — |
| Head | Bald, round face | Avoid harsh overhead → angled key, flag above |
| Skin | Warm undertone, natural texture | Responds well to 3200K tungsten |
| Eyes | Dark brown | Need adequate light for catchlights |
| Glasses | Rectangular gunmetal, semi-rimless | Key at 30-45° to avoid glare |
| Facial hair | Clean-shaven | — |
| Build | Medium | — |
| Presence | Confident, approachable, authoritative | — |

### Standard Reference Phrase (Copy Verbatim)
```
Using facial identity from reference image: cast-c{N}-face.png.
(where {N} = Ali Sadikin's assigned cast slot number from cast-profile.md)
Maintain consistent: Indonesian male, late 30s, bald, round face, warm skin
undertone with natural texture, dark brown eyes, rectangular gunmetal
semi-rimless glasses, clean-shaven, confident approachable presence.
```

### Wardrobe Defaults

| Context | Wardrobe |
|---------|----------|
| Professional/Tech | Navy blazer, white open-collar shirt |
| Casual explainer | Dark henley or polo |
| Formal | Dark suit, light shirt |

### Wardrobe × Lighting Notes
- Navy blazer: absorbs well, good skin contrast — works with all setups
- White shirt: can blow out — reduce fill or flag shirt area
- Dark henley: needs edge light for separation on dark backgrounds

### Mandatory Appearances
When Ali Sadikin preset is assigned to a cast slot, that character MUST appear in:
Hook shot, CTA/ending shot, talking-head segments, direct-address moments.
(Per cast-profile-system.md Section 4 — Pemeran Utama mandatory appearances.)

## Creator Lighting Setups

| Content | Pattern | Ratio | Kelvin | Shot | Lens | Angle |
|---------|---------|-------|--------|------|------|-------|
| Hook | Rembrandt | 4:1 | 3200K | CU | 85mm f/1.8 | Eye-level to slight low |
| Explanation | Loop | 2:1 | 5600K | MCU | 50mm f/2.8 | Eye-level |
| CTA | Butterfly | 2:1 | 3500K | CU | 85mm f/2 | Eye-level |
| Dramatic | Split/Rembrandt | 8:1 | 5600K | CU | 85mm f/1.8 | Eye-level |
| Thumbnail | Rembrandt/Split | 4:1-6:1 | Mixed warm/cool | CU tight | 85mm | Slight low + 5-10° dutch |

## Thumbnail Generation

### Requirements
- Creator face from `ref/cast-c{N}-face.png` (Ali Sadikin cast slot) — **50-60% of frame**
- Topic visual in background/side
- Text overlay zone reserved (don't render text, leave space)
- Expression EXAGGERATED (readable at 100×100px)
- Aspect: 9:16 vertical, min 1280×720
- High contrast, saturated, teal-orange grade

### Expression × Topic Combos

| Topic | Expression | Topic Visual |
|-------|------------|-------------|
| AI replacing jobs | Shock + concern | Robot silhouette, code |
| Tech breakthrough | Awe + excitement | Glowing tech, data viz |
| Warning/danger | Serious + urgent | Warning symbols, red |
| Secret/revelation | Knowing smirk + intrigue | Hidden/revealed element |
| Challenge/debate | Confident + confrontational | VS graphic |
| Money/opportunity | Excited + eager | Dollar signs, charts |

### Thumbnail Prompt Template
```
SUBJECT: Ali Sadikin, bald Indonesian man late 30s, gunmetal semi-rimless
glasses, [EXAGGERATED EXPRESSION]. Face 50-60% of frame, [position].
SECONDARY: [TOPIC VISUAL] in background/beside creator.
CAMERA: Tight CU, 85mm f/1.8, eye-level + slight dutch 5-10°.
LIGHTING: Rembrandt/Split 4:1-6:1, mixed warm face/cool topic, strong rim.
COLOR: Vision3 500T, HIGH SATURATION teal-orange, minimal grain.
TEXT ZONES: Reserve [position] for title overlay.
TECHNICAL: 9:16 vertical, min 1280×720, no artifacts.
FACE REF: cast-c{N}-face.png. [WARDROBE as specified].
```

## Holiday Design Reference

### 70/30 Rule
Holiday atmosphere **70-80%** of composition, professional/tech identity **20-30%**.

### Cast System Integration
Holiday wardrobe swaps apply per cast member individually. In multi-character videos:
- Each Pemeran Utama can have independent holiday wardrobe selection
- Pemeran Pendamping may use generic holiday-themed wardrobe
- All cast members in the same scene MUST use the same holiday theme (no mixing Christmas + Eid)
- Holiday palette applies to the entire video, not per-character

### Holiday Palettes & Symbols

**Chinese New Year / Imlek**
- Colors: Red #C8102E, Gold #CC9900, Crimson #960316. Avoid white/black dominant.
- Symbols: Red lanterns, dragon/lion dance, angpao, mandarin oranges, plum blossoms
- Indonesian specifics: Barongsai on poles, dodol keranjang, kebaya encim, Cap Go Meh, tok panjang
- Lighting: "vibrant red and gold tones, paper lantern glow"
- Film stock: Kodak Ektar 100 (vivid reds/golds)
- 2026 zodiac: Fire Horse

**Eid al-Fitr / Lebaran**
- Colors: Green #009A0A, White, Gold #CFB53B
- Symbols: Crescent+star, ketupat, mosques, prayer beads
- ⚠️ Indonesian mosques = **multi-tiered roofs** (Hindu-Javanese), NOT Middle Eastern domes
- Indonesian specifics: Mudik, sungkeman, ketupat+opor ayam+rendang, takbiran+bedug
- Lighting: "soft ethereal white-green, moonlit glow"
- Film stock: Fujifilm Pro 400H (cool greens, soft pastels)
- Text: "Selamat Hari Raya Idul Fitri" / "Mohon Maaf Lahir Batin"

**Christmas / Natal**
- Colors: Red #BB2528, Green #165B33, Gold #F8B229
- Indonesian specifics: NO snow → artificial glitter + tropical greenery + palm trees
- Handcrafted ornaments (wood, rattan, coconut shell), bamboo stars, wayang kulit Nativity
- Lighting: "warm golden fairy light bokeh, fireplace glow"
- Film stock: Kodak Portra 400 (nostalgic warmth)

**Diwali**
- Colors: Red #891E1B, Marigold #F79E1F, Gold #FFDF00, Purple #542182
- Symbols: Diyas, rangoli, marigold garlands
- Lighting: "warm golden diya glow, oil lamp lighting"
- Film stock: Kodak Vision3 500T (tungsten drama)

**Valentine's Day**
- Colors: Wine #5E081E, Rose #E24767, Blush #E4CDD3
- Film stock: Kodak Portra 400
- Lighting: "soft romantic rose-tinted candlelight"

### Holiday Wardrobe Swaps

> These wardrobe swaps are designed for Ali Sadikin preset but can be adapted for any
> cast member. When adapting for other characters, maintain the holiday color palette
> and cultural elements while adjusting fit/style to the character's profile.

| Holiday | Wardrobe |
|---------|----------|
| Chinese New Year | Slim-fit red tang jacket, gold embroidery, black turtleneck |
| Eid / Lebaran | White modern koko shirt, silver embroidery, white peci |
| Christmas | Charcoal blazer over cream cable-knit sweater |
| Diwali | Navy kurta with gold threadwork |
| Valentine's | Burgundy velvet blazer over white dress shirt |

### Natural Tech Props (Pick 1-2)
- Laptop showing AI workflow diagrams
- Holographic AI interface (blue-cyan glow vs warm holiday)
- Transparent tablet reflecting holiday lights
- Floating code patterns integrated into decorations

### AI Bias Countermeasures
- Always include geographic + cultural context: "Indonesian Lebaran in Javanese setting" NOT generic "Eid"
- Indonesian mosque = multi-tiered roofs, NOT Middle Eastern domes
- Include diverse appearance descriptors within cultural groups
- Verify Arabic/Chinese characters for accuracy
