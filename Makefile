### Defensive settings for make:
#     https://tech.davis-hansson.com/p/make/
SHELL:=bash
.ONESHELL:
.SHELLFLAGS:=-xeu -o pipefail -O inherit_errexit -c
.SILENT:
.DELETE_ON_ERROR:
MAKEFLAGS+=--warn-undefined-variables
MAKEFLAGS+=--no-builtin-rules

.PHONY: all
all: help

VERSION:=$(shell cat version.txt)

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build-image
build-image: ## Build the rancher-lets-encrypt docker image
	@echo "Building ghcr.io/pretagov/rancher-lets-encrypt:${VERSION}"
	@docker build --tag ghcr.io/pretagov/rancher-lets-encrypt:${VERSION} .

push-image: ## Push the rancher-lets-encrypt image to ghcr.io/pretagov
	@echo "Pushing ghcr.io/pretagov/rancher-lets-encrypt:${VERSION}"
	@docker push ghcr.io/pretagov/rancher-lets-encrypt:${VERSION}
