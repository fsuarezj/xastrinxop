#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SWAGGER="${ROOT_DIR}/xastrinxop-ui/swagger.json"

echo "Converting Swagger 2.0 to OpenAPI 3..."
cd "${ROOT_DIR}/xastrinxop-ui"
npx --yes swagger2openapi swagger.json -o openapi.json

echo "Generating TypeScript types..."
npx openapi-typescript openapi.json -o src/types/api.generated.ts

echo "Generating Python models..."
cd "${ROOT_DIR}/xastrinxop-api"
python3 -m pip install --quiet datamodel-code-generator
datamodel-codegen \
  --input "${ROOT_DIR}/xastrinxop-ui/openapi.json" \
  --input-file-type openapi \
  --output src/xastrinxop_api/schemas/generated.py

echo "Done."
