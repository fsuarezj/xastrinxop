# Contributing to XastrinShop

This platform repo uses **Git submodules**. Each component is an independent repository with its own history, CI, and release cycle.

## Repository layout

- **xastrinxop** (this repo): docker-compose, docs, cross-service scripts, contract CI
- **xastrinshop-api**: Flask REST API
- **xastrinshop-ui**: React admin dashboard
- **whatsapp_chat_llm**: WhatsApp ordering bot

## Making changes

### 1. Change code in the component repo

```bash
cd xastrinshop-ui          # or api / whatsapp_chat_llm
git checkout -b feature/my-change
# edit, test
git add .
git commit -m "Describe the component change"
git push origin feature/my-change
```

Open a pull request in the **component repository**, not the platform repo.

### 2. Bump the submodule pointer (optional but recommended)

After the component change is merged to `main`, update the platform repo to pin the new commit:

```bash
cd xastrinshop-ui
git checkout main
git pull

cd ..
git add xastrinshop-ui
git commit -m "Bump xastrinshop-ui submodule"
git push origin main
```

This keeps the platform repo reproducible: anyone cloning `xastrinxop` at a given commit gets known component versions.

## When to update the platform repo

Update **xastrinxop** when you change:

- `docker-compose.yml`
- Root `.env.example`
- `scripts/` or `Makefile`
- Cross-service CI (`.github/workflows/contract-ci.yml`)
- Submodule pointers after component releases

Do **not** put component source code in the platform repo directly.

## Running tests

```bash
# From platform root
make test

# Or per component
make test-api
make test-ui
make test-bot
```

## Branch strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production-ready |
| `staging` | Integration testing with sandbox APIs |

Align tags across repos for releases (e.g. `v0.1.0` on api, ui, bot, then platform).

## Clone checklist for new contributors

```bash
git clone --recurse-submodules git@github.com:fsuarezj/xastrinxop.git
cd xastrinxop
cp .env.example .env
# Fill in API keys in .env
docker compose up --build
```
