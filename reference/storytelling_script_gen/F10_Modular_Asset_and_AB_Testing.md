# F10_Modular_Asset_and_AB_Testing.md
## Component Tagging, Combinatorial Testing & Performance Feedback Loops
> **Priority:** 🟠 HIGH — Without systematic measurement, you're flying blind on what works.
> **Reference:** Robinhood tests 200+ variants. Honey tests 50+ new creatives weekly. One testimonial × 10 hooks × 5 CTAs = 50 unique ad variants from a single production day.

---

## 1. The Modular Asset Philosophy

Every video is an assemblage of **tagged, reusable components**. The most advanced content operations don't create "videos" — they create **component libraries** that are assembled, tested, and iterated.

**The Math:**
```
10 Hooks × 3 Bodies × 5 CTAs = 150 unique variants from ONE production day
```

**The Shift:**
| Old Model | Modular Model |
|---|---|
| Create 1 video → publish → hope | Create components → assemble variants → test → scale winners |
| If it fails, start over | If it fails, diagnose which component failed → swap → retest |
| Creative = art | Creative = testable science |

---

## 2. Component Tagging Taxonomy

Every component in the Hook Vault (F5) and CTA Vault (F6) should be tagged with these dimensions:

### 2.1. Tag Schema

| Component Type | Tag Dimensions | Format |
|---|---|---|
| **Hook** | Type · Tone · Length · Awareness Level · Persona | `hook_data_urgent_5s_problem-aware_operator` |
| **Foreshadow** | Loop Type · Energy Level | `foreshadow_bold-claim_high` |
| **Body Segment** | Topic · Persona · Plan Step | `body_plan-step2_technical_engineer` |
| **Peak** | Technique · Emotional Register | `peak_transformation-reveal_aspirational` |
| **CTA** | Type · Persona · Offer · Friction Level | `cta_transitional_technical_whitepaper_low` |
| **Testimonial** | Persona Match · Proof Type · Duration | `testimonial_clevel_outcome-proof_15s` |
| **Pattern Interrupt** | Channel (V/A/Verbal) · Energy | `interrupt_visual_sudden-zoom_high` |

### 2.2. Tag Examples (Ready-to-Apply)

```
hook_data_urgent_5s_problem-aware_fleet-manager
hook_challenger_authoritative_7s_solution-aware_clevel
hook_empathy_warm_5s_problem-aware_operator
foreshadow_bold-claim_high
foreshadow_story-start_conversational
body_3step-plan_medium_technical
peak_surprise-data_high-impact
peak_testimonial-climax_trust
cta_direct_operator_free-trial_zero-friction
cta_transitional_investor_compliance-audit_low-friction
testimonial_fleet-manager_outcome-proof_12s
interrupt_triple-layer_ambush_high
```

---

## 3. Test Hypothesis Templates

### 3.1. Isolation Tests (Change ONE Component)

| Test Type | What Changes | What Stays | Measures |
|---|---|---|---|
| **Hook A vs Hook B** | Hook only | Same body + CTA | 3s retention rate, overall completion |
| **CTA A vs CTA B** | CTA only | Same hook + body | Click-through rate, conversion rate |
| **Peak A vs Peak B** | Peak moment only | Same hook + body + CTA | Share rate, save rate, CTA conversion |
| **Foreshadow A vs B** | Foreshadow only | Same hook + body | 7s retention rate, completion rate |
| **Platform A vs B** | Platform | Same content | Completion rate, engagement rate per platform |

### 3.2. Hypothesis Format

```
HYPOTHESIS: We believe [Component X] will outperform [Component Y]
            for [Persona] at [Awareness Level]
            because [rationale based on F1/F4/F7/F8 framework].
METRIC    : [Primary metric to measure]
THRESHOLD : [What counts as "winning" — e.g., +15% retention at 7s]
DURATION  : [Minimum run time — 7 days default]
```

**Example:**
```
HYPOTHESIS: We believe the Empathy Hook will outperform the Data Hook
            for Daily Commuter at Problem-Aware level
            because Commuters have MEDIUM agitation tolerance and respond
            better to mirrored frustration than statistics (F4 §2).
METRIC    : 3-second retention rate
THRESHOLD : +10% retention vs. Data Hook variant
DURATION  : 7 days, minimum 1,000 impressions per variant
```

---

## 4. Statistical Rigor

### 4.1. Minimum Requirements

| Parameter | Minimum | Why |
|---|---|---|
| **Impressions per variant** | 1,000+ | Below this, results are noise |
| **Conversions per variant** | 100+ | Below this, conversion data isn't significant |
| **Run time** | 7 days minimum | Accounts for day-of-week variance |
| **Confidence level** | 95% (p < 0.05) | Industry standard for actionable decisions |

### 4.2. Method: Two-Proportion Z-Test

For comparing conversion rates between two variants:

```
H₀: p₁ = p₂ (no difference between variants)
H₁: p₁ ≠ p₂ (significant difference exists)

z = (p̂₁ - p̂₂) / √[p̂(1-p̂)(1/n₁ + 1/n₂)]

where p̂ = pooled proportion = (x₁ + x₂) / (n₁ + n₂)
```

**Practical Rule:** If your testing tool gives you a "confidence" or "significance" score, use it. If not, use the formula above or a free online calculator (e.g., AB Test Calculator).

### 4.3. When to Call a Winner

| Scenario | Decision |
|---|---|
| p < 0.05 and practical difference (>5% lift) | **Winner declared** — scale and archive loser |
| p < 0.05 but tiny difference (<2% lift) | **Technically significant, practically irrelevant** — move to next test |
| p > 0.05 after full sample | **No winner** — both variants are equivalent. Keep current or test new hypothesis. |
| One variant is clearly winning but sample is small | **Wait** — premature calls waste resources. Run to minimum sample. |

---

## 5. Feedback Loop Protocol

### 5.1. Winner Promotion

```
WINNING COMPONENT
       │
       ▼
┌─────────────────┐
│ Tag as "Proven"  │ → Add performance data to tag
│ in F5/F6 Vault   │    (e.g., "+22% 3s retention vs. baseline")
└─────────────────┘
       │
       ▼
┌─────────────────┐
│ Deploy as new    │ → Becomes the default for that
│ baseline          │    persona × awareness × platform combo
└─────────────────┘
```

### 5.2. Loser Analysis

```
LOSING COMPONENT
       │
       ▼
┌─────────────────┐
│ Archive with     │ → Document WHY it lost
│ performance data │    (e.g., "Data hook too abstract for
└─────────────────┘     Operator — needs concrete specifics")
       │
       ▼
┌─────────────────┐
│ Generate         │ → What does this failure teach us?
│ new hypothesis    │    Test the opposite or a variation.
└─────────────────┘
```

### 5.3. Review Cycle

| Cadence | Action |
|---|---|
| **Weekly** | Check running tests — any reaching statistical significance? |
| **Monthly** | Review: Top 3 winners, Bottom 3 losers, Generate 3 new hypotheses |
| **Quarterly** | Vault refresh: retire underperformers from F5/F6, promote proven winners, update baseline metrics |

---

## 6. The Brunson Diagnostic Rule

> **"If something's not working, it's always either your hook, your story, or your offer."** — Russell Brunson

| Symptom | Diagnosis | Fix |
|---|---|---|
| **Low impressions / reach** | Hook problem — not stopping the scroll | Test new hooks. Check Pattern Interrupt (F11). Check platform fit (F9). |
| **Low retention / high drop-off** | Story/Body problem — not holding attention | Check Foreshadow (F7). Check micro-payoff spacing. Check pacing vs. platform (F9). |
| **Low conversion** | CTA/Offer problem — not compelling to act | Test new CTA. Check awareness-level routing (F8). Check offer friction. Consider Godfather Offer. |
| **Low shares / saves** | Peak problem — no memorable moment | Design a stronger Peak (F7 §3). Check Peak timing and technique. |
| **High views but low engagement** | Persona mismatch — wrong audience seeing it | Check targeting. Check awareness level. Content may be reaching Unaware with Product-Aware content. |

---

## 7. Modular Asset Production Checklist

Before a production day, ensure:

- [ ] **Component types planned** — how many hooks, bodies, CTAs, testimonials?
- [ ] **Tag schema applied** — every component pre-tagged before filming
- [ ] **Test hypotheses written** — what are we testing and why?
- [ ] **Minimum variants calculated** — Hooks × Bodies × CTAs = total possible variants
- [ ] **Platform targets identified** — which platforms need which adaptations?
- [ ] **Baseline metrics documented** — current performance to beat
- [ ] **Review cadence set** — when will results be reviewed?

---

## 8. LLM Commandments — Modular Testing

- **MANDATORY: Tag every component in script output** with the taxonomy from §2.
- **MANDATORY: When creating scripts, note which components are swappable** — *"This hook can be replaced with [alternative] for A/B testing."*
- **MANDATORY: Include the Brunson Diagnostic** in Production Notes (Block 4) — identify the single riskiest component in the script.
- **OPTIONAL: Suggest 2 alternative hooks and 2 alternative CTAs** alongside the primary script for immediate A/B testing.

---

*This module transforms the creative engine from "build and hope" into "build, measure, learn." Load after F9, as the performance optimization layer.*
