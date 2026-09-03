---
version: alpha
name: Groundwork
description: Brand and UI system for Groundwork Security & Compliance — earthwork, not cyber-noir. Identity color is Soil; action color is Clay.
colors:
  primary: "#1c2e26"
  secondary: "#4f6d58"
  tertiary: "#c4785a"
  neutral: "#fbf8f2"
  soil: "#1c2e26"
  canopy: "#24382f"
  moss: "#4f6d58"
  terrace: "#5c7a62"
  sage: "#a8b5a0"
  clay: "#c4785a"
  clay-deep: "#9e5438"
  sand: "#f4efe6"
  paper: "#fbf8f2"
  ink: "#171c19"
  muted: "#5a635d"
  on-primary: "#f4efe6"
  on-tertiary: "#ffffff"
  on-paper: "#171c19"
  line: "rgba(28, 46, 38, 0.12)"
  link-on-dark: "#f0c2b0"
typography:
  h1:
    fontFamily: Fraunces
    fontSize: 72px
    fontWeight: 520
    lineHeight: 1.08
    letterSpacing: -0.035em
  h2:
    fontFamily: Fraunces
    fontSize: 40px
    fontWeight: 520
    lineHeight: 1.12
    letterSpacing: -0.035em
  h3:
    fontFamily: Fraunces
    fontSize: 22px
    fontWeight: 520
    lineHeight: 1.2
    letterSpacing: -0.03em
  body-md:
    fontFamily: Outfit
    fontSize: 17px
    fontWeight: 400
    lineHeight: 1.65
    letterSpacing: -0.011em
  lede:
    fontFamily: Outfit
    fontSize: 18px
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: -0.011em
  kicker:
    fontFamily: Outfit
    fontSize: 12px
    fontWeight: 600
    lineHeight: 1
    letterSpacing: 0.14em
  button:
    fontFamily: Outfit
    fontSize: 16px
    fontWeight: 600
    lineHeight: 1
    letterSpacing: -0.011em
  caption:
    fontFamily: Outfit
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.45
    letterSpacing: 0
rounded:
  sm: 12px
  md: 18px
  lg: 28px
  full: 999px
spacing:
  xs: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 40px
  "2xl": 84px
components:
  button-primary:
    backgroundColor: "{colors.clay}"
    textColor: "{colors.on-tertiary}"
    rounded: "{rounded.full}"
    padding: 12px
    typography: "{typography.button}"
  button-primary-hover:
    backgroundColor: "{colors.clay-deep}"
    textColor: "{colors.on-tertiary}"
    rounded: "{rounded.full}"
  button-ghost:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.full}"
    padding: 12px
    typography: "{typography.button}"
  chip:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.muted}"
    rounded: "{rounded.full}"
    padding: 8px
    typography: "{typography.caption}"
  card:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.md}"
    padding: 24px
  card-dark:
    backgroundColor: "{colors.canopy}"
    textColor: "{colors.sand}"
    rounded: "{rounded.md}"
    padding: 24px
  section-dark:
    backgroundColor: "{colors.soil}"
    textColor: "{colors.sand}"
  section-sand:
    backgroundColor: "{colors.sand}"
    textColor: "{colors.ink}"
  kicker-label:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.moss}"
    typography: "{typography.kicker}"
  nav:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.muted}"
    height: 74px
  input:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.sm}"
    padding: 12px
    typography: "{typography.body-md}"
  canvas:
    backgroundColor: "{colors.neutral}"
    textColor: "{colors.ink}"
  meta-on-dark:
    backgroundColor: "{colors.soil}"
    textColor: "{colors.sage}"
  link-on-dark:
    backgroundColor: "{colors.soil}"
    textColor: "{colors.link-on-dark}"
  terrace-course:
    backgroundColor: "{colors.terrace}"
    textColor: "{colors.on-primary}"
---

## Overview

Groundwork Security & Compliance is a fractional CISO and security-engineering practice for companies that need SOC 2, HITRUST, ISO 27001, or FedRAMP without a full-time security team.

The visual system is **earthwork, not cyber**. Soil, clay, sand, and canopy greens. Editorial serif headlines. No shields, padlocks, circuit boards, neon cyan, or black-hat imagery. The brand should feel like a well-built foundation: warm, exact, and durable.

Identity color is **Soil** (`#1c2e26`). Action color is **Clay** (`#c4785a`). Do not treat Clay as a surface fill. Do not treat Soil as a text color on Paper — use **Ink** (`#171c19`) for body copy.

Headline voice: short, concrete, construction-inflected. “Lay the groundwork. Get certified. Keep shipping.” Prefer “install,” “standing,” “path,” “baseline” over “synergy,” “next-gen,” or “AI-powered” as a headline.

Default canvas is **Paper** (`#fbf8f2`), not pure white. Dark bands use Soil with Sand type. Kickers are Moss, uppercase, tracked out, with a short Clay rule to the left.

Logo mark is a rounded Soil square with three stepped terraces (Clay, Sage, Terrace) capped by a Sand mountain summit. The summit's shadow face carries a ridge hairline and seven contour lines cut out of the Sand, so the tile reads through them as pen hatching — no second color and no strokes. Below 32px, and in single-color or stitched reproduction, use the untextured summit. It reads as earthworks / a foundation course — never as a generic app icon with a lock.

## Colors

Named after ground, not a generic ramp.

- **Soil / primary (`#1C2E26`):** Logo field, dark sections, footer-weight surfaces. The brand’s center of gravity.
- **Canopy (`#24382F`):** Cards sitting on Soil. One step lighter so dark layouts still have hierarchy.
- **Moss / secondary (`#4F6D58`):** Kickers, success, “alive” metadata. Not a button fill.
- **Terrace (`#5C7A62`):** Middle course in the mark. Use sparingly in UI; it belongs to the logo.
- **Sage (`#A8B5A0`):** Secondary text and rules on Soil. Never body text on Paper (contrast is too low).
- **Clay / tertiary (`#C4785A`):** Primary buttons, kicker rules, numerals, one accent per composition. Large type only if needed; do not set small running text in Clay.
- **Clay Deep (`#9E5438`):** Button hover and error-adjacent emphasis.
- **Sand (`#F4EFE6`):** Alternate section bands, type on Soil.
- **Paper / neutral (`#FBF8F2`):** Page background. Softer than white so the system stays warm.
- **Ink (`#171C19`):** Body and headlines on light surfaces.
- **Muted (`#5A635D`):** Secondary copy, nav links, captions on Paper.
- **Line (`rgba(28, 46, 38, 0.12)`):** Hairline borders. No 1px solid black.

Pairings that are in-bounds: Ink on Paper, Ink on Sand, Sand on Soil, White on Clay (buttons only), Sage on Soil, Moss on Paper for kickers. Pairings that are out: Clay on Soil as a large fill, Soil text on Paper, Sage text on Paper, neon on anything.

## Typography

Two families, always:

- **Fraunces** (variable, optical size 9–144, weight ~480–560) for h1–h3. Slightly soft, old-style, not a tech grotesque. Tracking tight (`-0.035em`). Line height ~1.08. Headlines may wrap aggressively; hero h1 is sized to about 11 characters on desktop.
- **Outfit** for UI, body, kickers, buttons. Weight 400 body, 600 for buttons and kickers. Body 17px / 1.65 / `-0.011em`.

Do not introduce Inter, Roboto, Geist, Space Grotesk, or system-ui as the intended brand face. Fallback stack: Fraunces → Iowan Old Style → Georgia → serif; Outfit → Avenir Next → system-ui → sans-serif.

Kickers: Outfit 0.78rem, weight 600, `letter-spacing: 0.14em`, uppercase, Moss, with an 18×2px Clay bar before the label.

## Layout

Max content width is **1180px**, with `width: min(1180px, calc(100% - 40px))` centering. Section padding is **84px** vertical. Hero is 72px top, 40px bottom. Cards gap **18px**. Page grid is 2 / 3 / 4 columns that collapse to 1 at 900px.

Radius scale: inputs 12px, cards 18px, large panels and portraits 28px, pills and buttons 999px. Do not mix sharp 4px Material corners into this system.

A sticky nav sits at 74px, Paper at 86% opacity, `backdrop-filter: blur(16px)`, hairline bottom border.

## Elevation & Depth

One shadow: `0 24px 60px rgba(28, 46, 38, 0.12)` on the hero aside, portraits, and other raised Soil or image panels. Cards themselves are flat: Paper or white fill, Line border, no drop shadow. Dark cards on Soil use a faint Sand border at 8% opacity, no shadow.

Hero atmosphere is a soft Clay radial wash at the top-right plus a repeating two-line hill pattern at ~7% Soil. Do not add noise textures, glassmorphism stacks, or colored glows.

## Shapes

The mark’s 12px corner on a 64px square is the seed. Cards 18px, featured panels 28px, buttons fully pill-shaped. Chips are pills. Form fields 12px. Portraits crop 4:5, object-position toward the face, 28px radius.

Do not use circles for the logo. Do not squircle the mark into a different radius. Do not add a lock, shield, or checkmark on top of the terraces.

## Components

**Primary button:** Clay fill, white label, pill, 12×20px padding, weight 600. Hover: Clay Deep and `translateY(-1px)`. Never outline-Clay as the primary.

**Ghost button:** transparent, Ink label, Line border, same pill geometry.

**Chip:** white or Paper, Line border, pill, Muted 0.82rem. Used for frameworks (SOC 2, HITRUST) and credentials — not as a CTA.

**Card (light):** white, Line border, 18px radius, 24px padding. h3 Fraunces ~1.35rem. Body Muted.

**Card (dark):** Canopy on Soil, Sand heading, `#c8d0c6` body, faint Sand border.

**Kicker:** Moss uppercase + Clay rule. Same on dark sections (kicker stays Moss/Sage, not Clay text).

**Hero panel:** Soil, Sand type, 28px radius, list rows divided by 12% Sand lines, Sage for the right-hand meta.

**Inputs:** white, Line border, 12px radius, 12×14px padding, Ink value. Error text Clay Deep. Success text Moss.

## Do's and Don'ts

Do set headlines in Fraunces and body in Outfit. Do leave generous type size and short lines. Do use Clay once per view as the action. Do show the stepped mark on Soil or Paper only. Do speak like an operator who still ships the work.

Do not use stock “hacker in a hoodie,” binary rain, or shield-and-lock logos. Do not recolor the terraces. Do not put the mark on photography without a Soil or Paper tile. Do not stretch, rotate, or outline the mark. Do not write “cyber,” “next-gen,” or “we leverage AI” as a headline. Do not use pure `#000` or `#fff` as the page canvas. Do not set running text smaller than 16px. Do not invent a second accent (no blue, no gold).
