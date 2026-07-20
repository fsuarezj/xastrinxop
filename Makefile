.PHONY: dev-api dev-ui dev-bot test-api test-ui test-bot test generate-types

dev-api:
	cd xastrinxop-api && PYTHONPATH=src python run.py

dev-ui:
	cd xastrinxop-ui && npm run dev

dev-bot:
	cd whatsapp_chat_llm/src && python app.py

test-api:
	cd xastrinxop-api && PYTHONPATH=src pytest tests/ -q

test-ui:
	cd xastrinxop-ui && npm run lint && npm run build && npm run test:contract

test-bot:
	cd whatsapp_chat_llm/src && PYTHONPATH=. python -m unittest discover -s test -p 'test_*.py' -q

test: test-api test-ui test-bot

generate-types:
	./scripts/generate-api-types.sh
