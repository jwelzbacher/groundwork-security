#!/usr/bin/env bash
# Deploy public/ to Firebase Hosting. Does not print credential values.
set -euo pipefail

PROJECT_ID="${FIREBASE_PROJECT_ID:-groundwork-security}"
DRY_RUN=0
CRED_FILE=""

usage() {
  echo "Usage: deploy-hosting.sh [--dry-run]" >&2
}

cleanup() {
  if [[ -n "${CRED_FILE}" && -f "${CRED_FILE}" ]]; then
    rm -f "${CRED_FILE}"
  fi
}

trap cleanup EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

if [[ ! -f firebase.json ]]; then
  echo "firebase.json not found at repo root." >&2
  exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "npx is required (Node.js)." >&2
  exit 1
fi

if [[ -n "${GOOGLE_APPLICATION_CREDENTIALS:-}" && -f "${GOOGLE_APPLICATION_CREDENTIALS}" ]]; then
  :
elif [[ -n "${FIREBASE_SERVICE_ACCOUNT:-}" ]]; then
  CRED_FILE="$(mktemp)"
  chmod 600 "${CRED_FILE}"
  printf '%s' "${FIREBASE_SERVICE_ACCOUNT}" > "${CRED_FILE}"
  export GOOGLE_APPLICATION_CREDENTIALS="${CRED_FILE}"
elif [[ -n "${FIREBASE_TOKEN:-}" ]]; then
  :
else
  cat >&2 <<'EOF'
Missing Firebase credentials.

Add a Runtime Secret named FIREBASE_SERVICE_ACCOUNT on the Cursor Cloud Agent
environment. Value: the full Google Cloud service account JSON. Role:
Firebase Hosting Admin on project groundwork-security.

Do not paste the JSON into chat.
EOF
  exit 2
fi

cmd=(npx --yes firebase-tools@15 deploy --only hosting --project "${PROJECT_ID}" --non-interactive)
if [[ "${DRY_RUN}" -eq 1 ]]; then
  cmd+=(--dry-run)
fi

echo "Deploying Hosting for ${PROJECT_ID} (dry-run=${DRY_RUN})"
"${cmd[@]}"
