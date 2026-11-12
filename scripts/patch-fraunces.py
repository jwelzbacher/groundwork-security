#!/usr/bin/env python3
"""Build Groundwork's copy of Fraunces from the stock Google Fonts file.

Fraunces' default lowercase s is top-heavy and reads as upside down. The
font ships a conventional s as s.alt, but the only switch for it (ss01) also
swaps h, m, n, and the ampersand. This remaps just the s family in the cmap
and renames the font so it never collides with a stock Fraunces install.

Source: https://github.com/google/fonts/raw/main/ofl/fraunces/Fraunces%5BSOFT,WONK,opsz,wght%5D.ttf

Usage: python3 scripts/patch-fraunces.py path/to/stock/Fraunces.ttf
Needs: pip install fonttools brotli
"""

import sys
from pathlib import Path

from fontTools import subset
from fontTools.ttLib import TTFont

ROOT = Path(__file__).resolve().parent.parent
TTF_OUTPUTS = [
    ROOT / "public/brand/fonts/Fraunces.ttf",
    ROOT / "public/brand/kit/fonts/Fraunces.ttf",
]
WOFF2_OUTPUT = ROOT / "public/fonts/FrauncesGroundwork.woff2"

FAMILY = "Fraunces Groundwork"
PS_FAMILY = "FrauncesGroundwork"
S_GLYPHS = {
    "s", "sacute", "sacutedotaccent", "scircumflex", "scaron", "scarondotaccent",
    "sdotaccent", "sdotbelow", "sdotbelowdotaccent", "scommaaccent", "scedilla",
}
# Google Fonts' latin + latin-ext ranges, which cover every accented s.
WEB_UNICODES = (
    "U+0000-024F,U+0259,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+1E00-1EFF,"
    "U+2000-206F,U+2074,U+20AC,U+20BF,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD"
)


def remap_s(font):
    glyphs = set(font.getGlyphOrder())
    for table in font["cmap"].tables:
        if not table.isUnicode():
            continue
        for code, glyph in list(table.cmap.items()):
            if glyph in S_GLYPHS and f"{glyph}.alt" in glyphs:
                table.cmap[code] = f"{glyph}.alt"


def rename(font):
    name = font["name"]
    if any(FAMILY in r.toUnicode() for r in name.names):
        sys.exit("Source is already patched; start from the stock Google Fonts file.")
    ps_ids = {6, 25} | {
        inst.postscriptNameID for inst in font["fvar"].instances if inst.postscriptNameID != 0xFFFF
    }
    for record in name.names:
        if record.nameID in (0, 7, 8, 9, 11, 12, 13, 14):
            continue
        text = record.toUnicode()
        if record.nameID in ps_ids:
            text = text.replace("Fraunces", PS_FAMILY)
        else:
            text = text.replace("Fraunces", FAMILY)
        if record.nameID == 5:
            text += "; Groundwork build: lowercase s uses s.alt"
        record.string = text


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    font = TTFont(sys.argv[1])
    remap_s(font)
    rename(font)
    for path in TTF_OUTPUTS:
        font.save(path)
        print(f"wrote {path.relative_to(ROOT)}")

    options = subset.Options()
    options.flavor = "woff2"
    options.layout_features = ["*"]
    options.name_IDs = ["*"]
    options.notdef_outline = True
    web = TTFont(TTF_OUTPUTS[0])
    subsetter = subset.Subsetter(options)
    subsetter.populate(unicodes=subset.parse_unicodes(WEB_UNICODES))
    subsetter.subset(web)
    WOFF2_OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    web.flavor = "woff2"
    web.save(WOFF2_OUTPUT)
    print(f"wrote {WOFF2_OUTPUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
