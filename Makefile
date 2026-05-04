.DEFAULT_GOAL := help
.PHONY: help install build dev validate scrub-check clean

help: ## Показать список команд
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Установить зависимости сайта (npm)
	cd site && npm install

build: ## Собрать статический сайт
	cd site && npm run build

dev: ## Запустить dev-сервер на :3000
	cd site && npm run start -- --host 0.0.0.0

validate: ## Проверить context7.json и отсутствие имён из scrub-list
	@python3 -c "import json; json.load(open('context7.json'))" && echo "✓ context7.json валиден"
	@$(MAKE) scrub-check

scrub-check: ## Проверить изменённые файлы на внутренние имена (читает паттерны из .scrub-patterns)
	@if [ ! -f .scrub-patterns ]; then \
		echo "ℹ  .scrub-patterns не найден — скип scrub-check (см. CONTRIBUTING.md)"; \
		exit 0; \
	fi; \
	pattern=$$(grep -v '^#' .scrub-patterns | grep -v '^$$' | paste -sd '|' -); \
	if [ -z "$$pattern" ]; then \
		echo "ℹ  .scrub-patterns пуст — скип scrub-check"; \
		exit 0; \
	fi; \
	staged=$$(git diff --cached --name-only 2>/dev/null); \
	if [ -z "$$staged" ]; then \
		staged=$$(git diff --name-only 2>/dev/null); \
	fi; \
	if [ -z "$$staged" ]; then \
		echo "Нет изменённых файлов для проверки"; \
		exit 0; \
	fi; \
	hits=$$(echo "$$staged" | xargs grep -liE "$$pattern" 2>/dev/null); \
	if [ -n "$$hits" ]; then \
		echo "⚠  SCRUB-LIST HIT в следующих файлах:"; \
		echo "$$hits"; \
		exit 1; \
	fi; \
	echo "✓ scrub-check чист"

clean: ## Удалить артефакты сборки
	rm -rf site/build site/.docusaurus
