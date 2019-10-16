.DEFAULT_GOAL := help
.PHONY: build

USERID ?= $$(id -u)
DOCKER_RUN = docker run --rm -it -e USERID=$(USERID)
DOCKER_IMAGE_CONFIGURE = overhangio/openedx-mfe-configure
DOCKER_IMAGE_BUILD = overhangio/openedx-mfe-build

images: image-configure image-build

image-configure: ## Build the builder docker image
	docker build -t $(DOCKER_IMAGE_CONFIGURE) ./configure/
	
image-build: ## Build the builder docker image
	docker build -t $(DOCKER_IMAGE_BUILD) ./build/

env.yml:
	touch env.yml

configure: env.yml ## Generate an env.sh file for the app
	$(DOCKER_RUN) -v $$(pwd)/env.yml:/env.yml -v $(APP):/app $(DOCKER_IMAGE_CONFIGURE)

shell: ## Start a shell inside the app builder image
	$(DOCKER_RUN) -v $(APP):/app --entrypoint=sh $(DOCKER_IMAGE_BUILD)

install: ## Install nodejs requirements
	$(DOCKER_RUN) -v $(APP):/app $(DOCKER_IMAGE_BUILD) npm install

# TODO expose a different port for each app?
start: ## Start development server
		$(DOCKER_RUN) -v $(APP):/app -p 1995:1995 $(DOCKER_IMAGE_BUILD) npm start

lint: ## Lint app code
		$(DOCKER_RUN) -v $(APP):/app $(DOCKER_IMAGE_BUILD) npm run lint

test: ## Run app tests
		$(DOCKER_RUN) -v $(APP):/app $(DOCKER_IMAGE_BUILD) npm run test

build: ## Build static app for production
		$(DOCKER_RUN) -v $(APP):/app $(DOCKER_IMAGE_BUILD) npm run build

ESCAPE = 
help: ## Print this help
	@grep -E '^([a-zA-Z_-]+:.*?## .*|######* .+)$$' Makefile \
		| sed 's/######* \(.*\)/\n               $(ESCAPE)[1;31m\1$(ESCAPE)[0m/g' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-30s\033[0m %s\n", $$1, $$2}'