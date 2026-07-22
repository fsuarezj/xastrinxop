# Xastrinxop (platform)

Multi-repo workspace via Git submodules: `xastrinxop-api`, `xastrinxop-ui`, `whatsapp_chat_llm`.

## Ownership
- Component code changes: commit inside the submodule repo.
- Platform changes only: docker-compose, Makefile, scripts, contract CI, submodule SHA bumps.
- Never put component source into the platform root.

## Definition of done
- API: `make test-api`
- UI: `make test-ui`
- Full: `make test`
- After OpenAPI/swagger changes: `make generate-types` and leave a clean git status for generated files.

## Safety
- Never commit `.env` or real secrets.
- Prefer existing patterns in neighboring files over inventing new architecture.