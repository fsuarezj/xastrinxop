#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -f "${ROOT_DIR}/.env" ]]; then
  echo "Copy .env.example to .env and configure secrets first."
  exit 1
fi

set -a
source "${ROOT_DIR}/.env"
set +a

echo "Starting XastrinShop API on port ${API_PORT:-5000}..."
(cd "${ROOT_DIR}/xastrinshop-api" && PYTHONPATH=src python run.py) &
API_PID=$!

echo "Starting XastrinShop UI on port 5173..."
(cd "${ROOT_DIR}/xastrinshop-ui" && npm run dev) &
UI_PID=$!

echo "Starting WhatsApp bot on port ${BOT_PORT:-3000}..."
(cd "${ROOT_DIR}/whatsapp_chat_llm/src" && python app.py) &
BOT_PID=$!

trap 'kill ${API_PID} ${UI_PID} ${BOT_PID} 2>/dev/null || true' EXIT INT TERM
wait
