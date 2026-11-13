#!/usr/bin/env bash
# Render the Groundwork SOC 2 congratulations card to a print-ready PDF.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PUBLIC="$ROOT/public"
OUT="$PUBLIC/print/Groundwork-SOC2-Congratulations.pdf"
PORT="${CARD_EXPORT_PORT:-8766}"

cd "$ROOT"
mkdir -p "$PUBLIC/print"

python3 -m http.server "$PORT" --directory "$PUBLIC" --bind 127.0.0.1 >/tmp/groundwork-card-http.log 2>&1 &
SERVER_PID=$!
cleanup() { kill "$SERVER_PID" 2>/dev/null || true; }
trap cleanup EXIT

for _ in 1 2 3 4 5 6 7 8 9 10; do
  if curl -sf "http://127.0.0.1:$PORT/print/soc2-congratulations.html" >/dev/null; then
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
  --print-to-pdf="$OUT" \
  "http://127.0.0.1:$PORT/print/soc2-congratulations.html"

if ! python3 -c "import pymupdf" >/dev/null 2>&1; then
  ls -lh "$OUT"
  echo "SOC 2 congratulations card exported."
  exit 0
fi

python3 - "$OUT" <<'PY'
import sys
import pymupdf
path = sys.argv[1]
doc = pymupdf.open(path)
page = doc[0]
print(f"pages={doc.page_count} size={page.rect}")
pix = page.get_pixmap(matrix=pymupdf.Matrix(3, 3))
preview = "/tmp/soc2-congratulations-preview.png"
pix.save(preview)
print(f"preview={preview} px={pix.width}x{pix.height}")
PY

ls -lh "$OUT"
echo "SOC 2 congratulations card exported."
