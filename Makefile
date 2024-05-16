NLG_GENIEACS_VERTION = 1.0.0

build-docker-full: ## Build Docker image for development.
	@echo "build docker container"
	docker build --no-cache --tag netkaofficialhub/nlg-genieacs:$(NLG_GENIEACS_VERTION).$(shell git log -1 --pretty=format:"%h") .

build-docker-official: ## Build Docker image for official.
	@echo "build docker container"
	docker build --no-cache --tag netkaofficialhub/nlg-genieacs:$(NLG_GENIEACS_VERTION) .

publish-nlg-development: ##
	docker push netkaofficialhub/nlg-genieacs:$(NLG_GENIEACS_VERTION).$(shell git log -1 --pretty=format:"%h")

publish-nlg-official: ##
	docker push netkaofficialhub/nlg-genieacs:$(NLG_GENIEACS_VERTION)