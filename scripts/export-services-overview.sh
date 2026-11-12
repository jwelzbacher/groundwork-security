#!/usr/bin/env bash
# Render the Groundwork one-page services overview to PDF.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PDF="$ROOT/collateral/Groundwork-Services-Overview.pdf"
PORT="${OVERVIEW_EXPORT_PORT:-8767}"
URL="http://127.0.0.1:$PORT/collateral/services-overview/"

cd "$ROOT"

python3 -m http.server "$PORT" --directory "$ROOT" --bind 127.0.0.1 >/tmp/groundwork-overview-http.log 2>&1 &
SERVER_PID=$!
cleanup() { kill "$SERVER_PID" 2>/dev/null || true; }
trap cleanup EXIT

for _ in 1 2 3 4 5 6 7 8 9 10; do
  if curl -sf "$URL" >/dev/null; then
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
  "$URL"

ls -lh "$PDF"
echo "Services overview exported."
