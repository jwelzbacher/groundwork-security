#!/usr/bin/env bash
# Render the Groundwork HIPAA letter of attestation to PDF.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPORT_DIR="$ROOT/reports/hipaa-letter-of-attestation"
PDF="$ROOT/reports/Groundwork-HIPAA-Letter-of-Attestation-Nurseplexus.pdf"
PORT="${REPORT_EXPORT_PORT:-8766}"

cd "$ROOT"

python3 -m http.server "$PORT" --directory "$ROOT" --bind 127.0.0.1 >/tmp/groundwork-report-http.log 2>&1 &
SERVER_PID=$!
cleanup() { kill "$SERVER_PID" 2>/dev/null || true; }
trap cleanup EXIT

for _ in 1 2 3 4 5 6 7 8 9 10; do
  if curl -sf "http://127.0.0.1:$PORT/reports/hipaa-letter-of-attestation/" >/dev/null; then
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
  "http://127.0.0.1:$PORT/reports/hipaa-letter-of-attestation/?print=1"

ls -lh "$PDF"
echo "HIPAA attestation exported."
