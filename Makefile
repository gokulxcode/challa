
.PHONY: init backend-start frontend-start test

init:
	@echo "Setup backend & frontend (dev)"
	cd backend && \
	python -m venv .venv && \
	. .venv/bin/activate && \
	pip install -r requirements.txt && \
	python populate_sample_data.py
	cd frontend && npm install

backend-start:
	cd backend && . .venv/bin/activate && uvicorn app.main:app --reload --port 8000

frontend-start:
	cd frontend && npm run dev

test:
	cd backend && . .venv/bin/activate && pytest -q
