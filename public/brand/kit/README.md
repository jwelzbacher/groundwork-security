# Groundwork brand kit

Files in this folder are the canonical brand pack for **Groundwork Security & Compliance**.

Use them in three places:

1. **Claude Design** — upload the PDF, `DESIGN.md`, `tokens/`, and `logos/svg/`. Follow `CLAUDE-DESIGN.md`.
2. **Google Drive** — upload the whole `kit/` folder (or the zip). PDF for sharing and print; SVG for vector work in Illustrator, Figma, or Canva.
3. **This website** — the interactive book lives at `/brand`.

## Google Drive folder recipe

Create a shared Drive folder named **Groundwork Brand**. Suggested layout:

```
Groundwork Brand/
  Groundwork-Brand-Guide.pdf          ← share this
  Groundwork-Brand-Kit.zip            ← archive of everything
  Logos/
    SVG/                              ← vectors (this kit’s logos/svg)
    mark.svg
    lockup-horizontal-on-paper.svg
  Palette/
    groundwork-palette.svg
  Tokens/
    DESIGN.md
    tokens.json
    tokens.css
  Claude Design/
    CLAUDE-DESIGN.md
```

Drive previews PDFs and SVGs natively. For new files (slides, one-pagers, proposals), duplicate a Google Doc/Slides themed from the PDF, or start in Claude Design and export PPTX / PDF back into this folder.

Do not recolor the mark. Do not replace Fraunces/Outfit with Calibri or Inter in client-facing work.

## File roles

| File | Format | Use |
|---|---|---|
| `Groundwork-Brand-Guide.pdf` | PDF (print, vector-friendly) | The book. Upload this file to Google Drive and Claude Design. |
| `Groundwork-Logos-SVG.zip` | SVG zip | Logo mark, lockups, palette, pattern — Drive / Figma / Illustrator. |
| `logos/svg/*.svg` | SVG | Logo files for Figma, web, print. |
| `palette/groundwork-palette.svg` | SVG | Named color board. |
| `pattern/hills.svg` | SVG | Hero texture, tiling. |
| `fonts/Fraunces.ttf` · `Outfit.ttf` | TTF (SIL OFL) | Brand typefaces for local files. |
| `tokens/tokens.json` | DTCG JSON | Design tools and Claude Design. |
| `tokens/tokens.css` | CSS variables | Matches `public/css/styles.css`. |
| `DESIGN.md` | Google DESIGN.md | Agents (Claude, Cursor, Gemini). |
| `CLAUDE-DESIGN.md` | Markdown | Setup checklist + paste-ready prompt. |

## Logo files

| SVG | When |
|---|---|
| `mark.svg` | Default. Soil tile, full color terraces, hatched summit. |
| `mark-open.svg` | Terraces only, no tile — place on Soil. |
| `mark-mono-sand.svg` | Single-color Sand on Soil (embroidery, small mono). Untextured summit. |
| `mark-mono-soil.svg` | Single-color Soil on Sand. Untextured summit. |
| `mark-mono-clay.svg` | Single-color on Clay. Special use only. Untextured summit. |
| `lockup-horizontal-on-paper.svg` | Primary lockup. |
| `lockup-horizontal-on-soil.svg` | Reverse lockup. |
| `lockup-stacked-*.svg` | Social avatars, title pages. |
| `wordmark-*.svg` | When the mark already appears nearby. |

Minimum mark size: **24px** digital, **0.35 in** print. Clear space: **25% of the mark’s width** on all sides.

The summit hatching is a large-format detail. Below **32px**, and in single-color or stitched reproduction, use the untextured summit — the mono cuts and the site favicon ship that way. The hatching is negative space inside the Sand shape, so it never introduces a color and never needs a stroke width.

## Regenerating the PDF

From the repo root, with the site served:

```bash
python3 -m http.server 8080 --directory public
google-chrome --headless=new --disable-gpu --no-pdf-header-footer \
  --print-to-pdf=public/brand/kit/Groundwork-Brand-Guide.pdf \
  "http://127.0.0.1:8080/brand/?print=1"
```

Fonts load from Google Fonts; give Chrome a few seconds (the export script waits).
