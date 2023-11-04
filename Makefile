.DEFAULT_GOAL := vendor
SHELL := bash

php74 = docker compose run --rm php74
php82 = docker compose run --rm php82

vendor: build
	@$(php74) composer install

.PHONY: build
build:
	@docker compose build --pull

.PHONY: clear
clear:
	@git reset --hard
	@git clean -df

.PHONY: reset
reset: clear
	@$(php74) composer install

.PHONY: restart
restart: clear
	@git checkout main
	@rm -rf vendor
	@$(php74) composer install

.PHONY: bash74
bash74:
	@$(php74) bash

.PHONY: bash82
bash82:
	@$(php82) bash

.PHONY: psysh74
psysh74:
	@$(php74) vendor/bin/psysh

.PHONY: psysh82
psysh82:
	@$(php82) vendor/bin/psysh

.PHONY: lint74
lint74:
	@$(php74) vendor/bin/parallel-lint --exclude vendor .

.PHONY: lint82
lint82:
	@$(php82) vendor/bin/parallel-lint --exclude vendor .
