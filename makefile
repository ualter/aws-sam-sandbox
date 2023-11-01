.DEFAULT_GOAL := help
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

DC_CMD := docker compose
DC_PROJ_NAME := sandbox-graphql

BLUE       := "'\033[34;1m'"
GREEN      := "'\033[32;0m'"
BOLD_GREEN := "'\033[32;1m'"
RESET      := "'\033[0;0m'"

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-18s\033[33m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ --| Utils |-------------------------------------------------------------------

init: ## Create sam project
	@echo ""; \
	sam init --name lambda-api --runtime python3.10 --dependency-manager pip --app-template hello-world; \
	echo ""