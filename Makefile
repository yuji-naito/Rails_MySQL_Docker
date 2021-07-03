
.DEFAULT_GOAL := help

up: ## Run Server
	docker compose up -d

down: ## Stop Server
	docker compose down --remove-orphans

build: ## BUild contaners
	docker compose build --no-cache --force-rm

install: ## Bundler install
	docker compose exec app bundle install

migrate: ## Migrate database
	docker compose exec app bundle exec rails db:migrate

init: ## initialize develoment
	if ! [ -f .env ];then cp .env.sample .env;fi
	docker compose up -d --build
	@make install
	docker compose exec app bundle exec rails db:create
	docker compose exec app bundle exec rails db:migrate
	docker compose exec app bundle exec rails db:seed

routes: ## Show routes
	docker compose exec app bundle exec rails routes

workspace: ## Login Rails Container
	docker compose exec web bash

console: ## Run Rails console
	docker compose exec web bundle exec rails c

destroy: ## Destroy volumes and containers
	docker compose down --rmi all --volumes --remove-orphans

deploy-production: ## Deploy to Production
	bundle exec cap deploy

deploy-staging: ## Deploy to Staging
	BRANCH=develop bundle exec cap staging deploy

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'