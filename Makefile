APP_ENV ?= staging

.PHONY: run-poller
run-poller:
	RAILS_ENV=$(APP_ENV) bundle exec rails telegram:bot:poller

.PHONY: run-poller-background
run-poller-background:
	RAILS_ENV=$(APP_ENV) bundle exec rails telegram:bot:poller &

.PHONY: kill-poller
kill-poller:
	kill -9 $(APP_PID)

# Deploy #

.PHONY: deploy-app-check
deploy-app-check:
	SERVER_IP=$(SERVER_IP) bundle exec cap production deploy:check

.PHONY: deploy-app
deploy-app:
	SERVER_IP=$(SERVER_IP) bundle exec cap production deploy
