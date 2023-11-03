.DEFAULT_GOAL := help
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

DC_CMD := docker compose
DC_PROJ_NAME := sandbox-graphql
STACK_NAME := lambda-api

BLUE  := "'\033[34;1m'"
GREEN := "'\033[32;1m'"
RESET := "'\033[0;0m'"

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-18s\033[33m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ --| Utils |-------------------------------------------------------------------

build: ## Build function code to generate artifacts
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam build --use-container --no-cached ${RESET}\n"; \
	sam build --use-container --no-cached; \
	echo ""

build-container: ## Build using container
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam build --use-container --no-cached ${RESET}\n"; \
	sam build --use-container --no-cached; \
	echo ""

validate: ## Validate SAM Template
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam validate ${RESET}\n"; \
	sam validate; \
	echo ""

local-invoke: ## SAM Local Invoke
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam local invoke HelloWorldFunction${RESET}\n"; \
	sam local invoke HelloWorldFunction; \
	echo ""

sync-stack: ## Synchronizing a development stack
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam sync --stack-name ${STACK_NAME} --watch ${RESET}\n"; \
	sam sync --stack-name ${STACK_NAME} --watch; \
	echo ""

deploy: ## SAM Deploy
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam deploy${RESET}\n"; \
	sam deploy --no-confirm-changeset; \
	echo ""

deploy-guided: ## SAM Deploy guided
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam deploy --guided ${RESET}\n"; \
	sam deploy --guided; \
	echo ""

start-local: ## Start the lambda locally
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam local start-api ${RESET}\n"; \
	sam local start-api; \
	echo ""

print-stack: ## List Stack Outputs (deployed)
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam list stack-outputs ${RESET}\n"; \
	sam list stack-outputs; \
	echo ""

print-apiurl: ## Print API Gateway URL of the deployed Lambda (needs jq installed)
	@echo ""; \
	printf "${BLUE}Launching... ${GREEN}sam list stack-outputs --output json | jq -r '.[N].OutputValue' ${RESET}\n"; \
	api_values=$$(sam list stack-outputs --output json | jq -r '.[2] | "\(.OutputKey), \(.OutputValue)"'); \
	IFS=', ' read -r -a array <<< "$$api_values"; \
	api_key=$${array[0]}; \
	api_url=$${array[1]}; \
	printf "\n$$api_key: ${BLUE}\n   $$api_url"; \
	api_values=$$(sam list stack-outputs --output json | jq -r '.[3] | "\(.OutputKey), \(.OutputValue)"'); \
	IFS=', ' read -r -a array <<< "$$api_values"; \
	api_key=$${array[0]}; \
	api_url=$${array[1]}; \
	printf "\n${RESET}$$api_key: ${BLUE}\n   $$api_url"; \
	echo ""

call-hello: ## Call Hello World API Gateway URL of the deployed Lambda (needs jq installed)
	@echo ""; \
	api_values=$$(sam list stack-outputs --output json | jq -r '.[2] | "\(.OutputKey), \(.OutputValue)"'); \
	IFS=', ' read -r -a array <<< "$$api_values"; \
	api_key=$${array[0]}; \
	api_url=$${array[1]}; \
	printf "Calling... ${BLUE}\n   $$api_url \n\n${RESET}"; \
	printf "Result... ${BLUE}\n   "; \
	curl $$api_url; \
	echo ""

call-qr: ## Call QRCode API Gateway URL of the deployed Lambda (needs jq installed)
	@echo ""; \
	api_values=$$(sam list stack-outputs --output json | jq -r '.[3] | "\(.OutputKey), \(.OutputValue)"'); \
	IFS=', ' read -r -a array <<< "$$api_values"; \
	api_key=$${array[0]}; \
	api_url=$${array[1]}; \
	printf "Calling... ${BLUE}\n   $$api_url \n\n${RESET}"; \
	printf "Result... ${BLUE}\n   "; \
	curl $$api_url; \
	echo ""

clean-up: ## Clean stack, delete everything
	@echo ""; \
	read -p "     Delete everything from AWS, confirm ? [y/n]: " RESP; \
	if [[ $$RESP == "y" ]]; then\
		echo ""; \
		printf "${BLUE}Launching... ${GREEN}aws cloudformation delete-stack --stack-name ${STACK_NAME} ${RESET}\n"; \
		aws cloudformation delete-stack --stack-name ${STACK_NAME}; \
		echo ""; \
	else\
		echo ""; \
	    printf " ${GREEN}Canceled!${RESET}"; \
		echo ""; \
	fi; \


