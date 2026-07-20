# XastrinShop Workspace

Platform repository orchestrating the XastrinShop components via Git submodules.

## Components

| Submodule | Repository | Port |
|-----------|------------|------|
| [xastrinshop-api](xastrinshop-api/) | [github.com/fsuarezj/xastrinxop-api](https://github.com/fsuarezj/xastrinxop-api) | 5000 |
| [xastrinshop-ui](xastrinshop-ui/) | [github.com/fsuarezj/xastrinshop-ui](https://github.com/fsuarezj/xastrinshop-ui) | 5173 |
| [whatsapp_chat_llm](whatsapp_chat_llm/) | [github.com/fsuarezj/whatsapp_chat_llm](https://github.com/fsuarezj/whatsapp_chat_llm) | 3000 |

## Clone

```bash
git clone --recurse-submodules git@github.com:fsuarezj/xastrinxop.git
cd xastrinxop
cp .env.example .env
```

If you already cloned without submodules:

```bash
git submodule update --init --recursive
```

## Quick start

### Docker Compose

```bash
docker compose up --build
```

### Local development

```bash
# Terminal 1 - API
cd xastrinshop-api
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
PYTHONPATH=src python run.py

# Terminal 2 - UI
cd xastrinshop-ui
npm install
npm run dev

# Terminal 3 - Bot
cd whatsapp_chat_llm
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cd src && python app.py
```

Or from the platform root:

```bash
./scripts/dev.sh
```

## Submodule workflow

| Task | Command |
|------|---------|
| Update all submodules | `git submodule update --remote --merge` |
| Work on a component | `cd xastrinshop-ui && git checkout -b feature/my-change` |
| Push a component change | Commit and push inside the submodule directory |
| Record new submodule SHA | `cd .. && git add xastrinshop-ui && git commit -m "Bump ui submodule"` |

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full two-step commit process.

## Default credentials

- Admin: `admin` / `Admin12345`
- Bot service account: `bot` / `BotService123`

## Architecture

```
WhatsApp User -> whatsapp_chat_llm -> xastrinshop-api <- xastrinshop-ui
                                         |
                                      SQLite/PostgreSQL
```

## Testing

```bash
make test
```

## API contract

OpenAPI spec: [xastrinshop-ui/swagger.json](xastrinshop-ui/swagger.json)

Regenerate shared types:

```bash
make generate-types
```

## First-time GitHub setup

If `xastrinxop-api` or this platform repo are not on GitHub yet, create them first:

```bash
# On GitHub: create empty repos fsuarezj/xastrinxop-api and fsuarezj/xastrinxop
cd xastrinshop-api && git push -u origin main
cd .. && git push -u origin main
```
