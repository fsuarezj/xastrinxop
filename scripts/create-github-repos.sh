#!/usr/bin/env bash
# Create GitHub repos for xastrinxop-api and xastrinxop if they do not exist yet.
# Requires: GitHub CLI (gh) authenticated, or create repos manually on github.com.

set -euo pipefail

create_repo() {
  local name="$1"
  local source_dir="$2"
  if gh repo view "fsuarezj/${name}" >/dev/null 2>&1; then
    echo "Repo fsuarezj/${name} already exists"
  else
    echo "Creating fsuarezj/${name}..."
    gh repo create "fsuarezj/${name}" --private --source="${source_dir}" --remote=origin
  fi
  git -C "${source_dir}" remote set-url origin "git@github.com:fsuarezj/${name}.git"
  git -C "${source_dir}" push -u origin main
}

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v gh >/dev/null 2>&1; then
  echo "Install GitHub CLI (gh) or create these repos manually on GitHub:"
  echo "  - fsuarezj/xastrinxop-api"
  echo "  - fsuarezj/xastrinxop"
  echo "Then run:"
  echo "  git -C ${ROOT}/xastrinxop-api push -u origin main"
  echo "  git -C ${ROOT} push -u origin main"
  exit 1
fi

create_repo "xastrinxop-api" "${ROOT}/xastrinxop-api"
create_repo "xastrinxop" "${ROOT}"

echo "Done."
