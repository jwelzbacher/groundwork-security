# Groundwork → Claude Design

Upload this folder (or the files listed below) when you set up or remix the Groundwork design system in [Claude Design](https://claude.com/product/design).

## What to upload

| File | Why Claude needs it |
|---|---|
| `Groundwork-Brand-Guide.pdf` | Full visual identity: logo, color, type, components, do/don’t |
| `DESIGN.md` (repo root, also copied here) | Token values + rules Claude can apply on every project |
| `tokens/tokens.json` | DTCG tokens (hex, type, radius, spacing) |
| `tokens/tokens.css` | CSS variables that already run the marketing site |
| `logos/svg/mark.svg` | Official mark |
| `logos/svg/lockup-horizontal-on-paper.svg` | Primary lockup |
| `palette/groundwork-palette.svg` | Named swatches |

Also point Claude at the live site or this GitHub repo so it can read `public/css/styles.css` and `public/index.html`. Real pages teach layout better than a palette alone.

## After extraction, check these

Claude Design reads hex values more reliably than *roles*. Confirm the generated system:

1. Page background is Paper `#FBF8F2`, not white and not Soil.
2. Primary buttons are Clay `#C4785A` pills with white labels — not Soil, not blue.
3. Headlines are **Fraunces**, body is **Outfit**.
4. Clay is an accent, never a full-bleed section fill.
5. The logo is the stepped terrace mark — never a shield or lock.

Test prompts:

- “Create a one-page capabilities leave-behind for a Series A SaaS that needs SOC 2.”
- “Design a 8-slide readiness-sprint proposal deck.”
- “Make a LinkedIn banner and a square logo tile.”

## Paste-ready system prompt

If you start a project without the org design system attached, paste this:

```
Design for Groundwork Security & Compliance (groundworksec.com).

Brand idea: earthwork, not cyber. Warm soil greens and clay. Editorial, not neon.

Colors:
- Paper #FBF8F2 canvas (never pure white)
- Soil #1C2E26 identity / dark sections
- Canopy #24382F dark cards
- Moss #4F6D58 kickers
- Sage #A8B5A0 secondary on dark
- Clay #C4785A primary buttons and a single accent
- Clay Deep #9E5438 button hover
- Sand #F4EFE6 warm bands and type on Soil
- Ink #171C19 text on light
- Muted #5A635D secondary text

Type: Fraunces (headlines, weight ~520, tracking -0.035em) + Outfit (body 17px/1.65, buttons, uppercase kickers at 0.14em).

Shape: cards 18px, featured panels 28px, buttons fully pill. One shadow: 0 24px 60px rgba(28,46,38,0.12). Hairline borders rgba(28,46,38,0.12).

Logo: rounded 12px Soil square, three terraces (Clay / Sage / Terrace #5C7A62) and a Sand mountain summit. Do not add a lock or shield.

Voice: short, concrete, construction-inflected. No “next-gen,” no fear-based cyber clichés.

Clay is the action color, not a surface. Soil is the identity color, not body text on Paper.
```
