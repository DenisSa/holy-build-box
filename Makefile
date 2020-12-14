VERSION = latest

.PHONY: all 64 tags release

all: 64

64:
	docker build --rm -t b64/buildbox:$(VERSION) -f Dockerfile-64 --pull .

tags:
	az acr login --name b64buildbox.azurecr.io
	docker tag b64/buildbox b64buildbox.azurecr.io/buildbox:latest

release: tags
	docker push b64buildbox.azurecr.io/buildbox:latest
