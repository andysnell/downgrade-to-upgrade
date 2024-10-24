.DEFAULT_GOAL := vendor
SHELL := bash

php74 = docker compose run --rm php74
php83 = docker compose run --rm php83

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

.PHONY: php74
php74:
	@$(php74) bash

.PHONY: php83
php83:
	@$(php83) bash

.PHONY: lint74
lint74:
	@$(php74) vendor/bin/parallel-lint --exclude vendor .

.PHONY: lint83
lint83:
	@$(php83) vendor/bin/parallel-lint --exclude vendor .
