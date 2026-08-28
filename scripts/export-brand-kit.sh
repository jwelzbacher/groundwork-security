#!/usr/bin/env bash
# Render the Groundwork brand book to PDF and zip the kit for Drive / Claude Design.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PUBLIC="$ROOT/public"
KIT="$PUBLIC/brand/kit"
PDF="$KIT/Groundwork-Brand-Guide.pdf"
ZIP="$KIT/Groundwork-Brand-Kit.zip"
PORT="${BRAND_EXPORT_PORT:-8765}"

cd "$ROOT"
mkdir -p "$KIT"

python3 -m http.server "$PORT" --directory "$PUBLIC" --bind 127.0.0.1 >/tmp/groundwork-brand-http.log 2>&1 &
SERVER_PID=$!
cleanup() { kill "$SERVER_PID" 2>/dev/null || true; }
trap cleanup EXIT

for _ in 1 2 3 4 5 6 7 8 9 10; do
  if curl -sf "http://127.0.0.1:$PORT/brand/" >/dev/null; then
    break
  fi
  sleep 0.2
done

CHROME="${CHROME_BIN:-$(command -v google-chrome-stable || command -v google-chrome)}"
"$CHROME" \
  --headless=new \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --no-pdf-header-footer \
  --no-first-run \
  --no-default-browser-check \
  --hide-scrollbars \
  --font-render-hinting=none \
  --virtual-time-budget=8000 \
  --run-all-compositor-stages-before-draw \
  --print-to-pdf="$PDF" \
  "http://127.0.0.1:$PORT/brand/?print=1"

# Raster mark for Drive / avatar use (SVG remains the vector source).
MARK_PNG="$KIT/logos/png"
mkdir -p "$MARK_PNG"
"$CHROME" \
  --headless=new \
  --no-sandbox \
  --disable-gpu \
  --hide-scrollbars \
  --default-background-color=00000000 \
  --window-size=512,512 \
  --screenshot="$MARK_PNG/mark-512.png" \
  "http://127.0.0.1:$PORT/brand/kit/logos/svg/mark-padded-paper.svg"

rm -f "$ZIP"
# Zip kit contents with the PDF, excluding the zip itself.
(
  cd "$PUBLIC/brand"
  zip -r -q "$(basename "$KIT")/$(basename "$ZIP")" kit \
    -x "kit/$(basename "$ZIP")"
)

ls -lh "$PDF" "$ZIP" "$MARK_PNG/mark-512.png"
echo "Brand kit exported."
