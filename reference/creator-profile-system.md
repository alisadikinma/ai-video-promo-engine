# Creator Profile System

Generic creator/brand profile system with Ali Sadikin preset. Supports any brand or individual creator.

---

## 1. Profile Setup Flow (Phase 1: Brainstorm)

During Phase 1, the skill collects creator/brand information via AskUserQuestion:

### Step 1: Profile Mode Selection

```
AskUserQuestion:
"Apakah kamu punya creator/brand profile yang sudah ada?"

Options:
A) Start fresh (isi profile baru)
B) Use Ali Sadikin preset
C) Load existing profile (dari file creator-profile.md)
```

### Step 2: Generic Profile Collection (if "Start fresh")

Collect via sequential AskUserQuestion:

| Field | Question | Required? |
|-------|----------|-----------|
| `brand_name` | "Nama brand/company?" | YES |
| `creator_name` | "Nama presenter/host di video?" | YES (if presenter-style) |
| `creator_gender` | "Gender presenter?" → Male / Female / Non-binary | YES (if presenter) |
| `creator_age_range` | "Range usia presenter?" → 20s / 30s / 40s / 50s+ | YES (if presenter) |
| `creator_ethnicity` | "Etnis/appearance presenter?" | YES (for accurate AI generation) |
| `creator_key_features` | "Ciri khas yang harus konsisten?" (glasses, beard, bald, etc.) | Optional |
| `creator_wardrobe` | "Default wardrobe?" → Professional / Casual / Custom | Optional |
| `brand_colors` | "Warna brand utama? (hex code)" | Optional |
| `brand_tagline` | "Tagline brand?" | Optional |
| `product_category` | "Kategori produk?" → Tech/SaaS / E-commerce / Finance / Health / Education / Other | YES |

### Step 3: Reference Image Collection

```
AskUserQuestion:
"Upload reference images ke folder {project}/ref/:
- creator-face.png (foto wajah presenter) — WAJIB untuk presenter-style video
- creator-brand.png (logo brand) — WAJIB

Sudah di-upload?"

Options:
A) Sudah, lanjut
B) Belum, skip dulu (WARNING: image generation tanpa face ref = inconsistent)
C) Video ini tanpa presenter (B-Roll only)
```

---

## 2. Ali Sadikin Preset

Activated via `--preset ali` or interactive selection.

### Physical Reference

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
Using facial identity from reference image: creator-face.png.
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

### Lighting Setups

| Content | Pattern | Ratio | Kelvin | Shot | Lens | Angle |
|---------|---------|-------|--------|------|------|-------|
| Hook | Rembrandt | 4:1 | 3200K | CU | 85mm f/1.8 | Eye-level to slight low |
| Explanation | Loop | 2:1 | 5600K | MCU | 50mm f/2.8 | Eye-level |
| CTA | Butterfly | 2:1 | 3500K | CU | 85mm f/2 | Eye-level |
| Dramatic | Split/Rembrandt | 8:1 | 5600K | CU | 85mm f/1.8 | Eye-level |

### Glasses Anti-Glare

Key light at 30-45° angle to avoid specular reflection on lenses. Never use direct frontal lighting.

---

## 3. Generic Profile Template

When user fills in a new profile, generate this structure and save to `{project}/creator-profile.md`:

```markdown
# Creator Profile — {brand_name}

## Brand Identity
- **Brand Name:** {brand_name}
- **Brand Colors:** {brand_colors}
- **Tagline:** {brand_tagline}
- **Product Category:** {product_category}

## Presenter (if applicable)
- **Name:** {creator_name}
- **Gender:** {creator_gender}
- **Age Range:** {creator_age_range}
- **Ethnicity:** {creator_ethnicity}
- **Key Features:** {creator_key_features}
- **Default Wardrobe:** {creator_wardrobe}

## Reference Phrase (for all NB2 prompts)
```
Using facial identity from reference image: creator-face.png.
Maintain consistent: {creator_ethnicity} {creator_gender}, {creator_age_range},
{creator_key_features}, {creator_wardrobe description}.
```

## Reference Images
- `ref/creator-face.png` — Presenter face photo
- `ref/creator-brand.png` — Brand logo/icon
- `ref/ref-{product}.png` — Product reference (if applicable)

## Wardrobe Defaults
| Context | Wardrobe |
|---------|----------|
| Professional | {wardrobe_professional} |
| Casual | {wardrobe_casual} |
| Formal | {wardrobe_formal} |

## Lighting Notes
- Skin tone responds to: {kelvin_recommendation}K
- Key features to maintain: {key_features_lighting_notes}
```

---

## 4. Mandatory Presenter Appearances

For presenter-style videos, the creator MUST appear in:

| Scene Type | Creator Face? | Notes |
|------------|--------------|-------|
| Hook (opening) | YES (always) | Exaggerated emotion |
| Presenter segments | YES (always) | Lip sync dialogue |
| B-Roll with humans | YES (prominent) | Creator as most prominent figure |
| B-Roll without humans | NO | Product/environment only |
| CTA (closing) | YES (always) | Warm, inviting expression |

---

## 5. Product Reference Images

For product-focused videos, collect additional references:

| Type | Filename Convention | When Required |
|------|-------------------|---------------|
| Product hero shot | `ref/ref-{product-name}.png` | When showing specific product |
| Company logo | `ref/ref-{company}-logo.png` | When brand must be visible |
| UI/Dashboard | `ref/ref-{product}-ui.png` | For SaaS/tech product demos |
| Packaging | `ref/ref-{product}-packaging.png` | For physical products |

---

## 6. Holiday Wardrobe Swaps

Available when using Ali Sadikin preset or custom holidays:

| Holiday | Wardrobe |
|---------|----------|
| Chinese New Year | Slim-fit red tang jacket, gold embroidery, black turtleneck |
| Eid / Lebaran | White modern koko shirt, silver embroidery, white peci |
| Christmas | Charcoal blazer over cream cable-knit sweater |
| Diwali | Navy kurta with gold threadwork |
| Valentine's | Burgundy velvet blazer over white dress shirt |
