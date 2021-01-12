SHELL=/bin/bash # Use bash syntax
export SENSU_GO_VERSION=6.2.1
export SENSU_GO_HASH=38fe0fea4fa88ab3f46ce9d5c157393f4cf69b46
export SENSU_GO_REVISION=0
export SENSU_GO_WEB_VERSION=v1.0.5
export SENSU_GO_WEB_HASH=6fe78601bc423a5c3624a720220a9d99126fe98b
export SENSU_GO_WEB_REVISION=0
export DOCKER_USERNAME=daswars

.PHONY: all
all: build-web build-backend

build-web:
	docker build --ulimit nofile=262144:262144 -f Dockerfile-sensu-go-web-nginx --squash --build-arg SENSU_GO_WEB_VERSION=$(SENSU_GO_WEB_VERSION) -t $(DOCKER_USERNAME)/sensu-web-nginx:$(SENSU_GO_WEB_VERSION)-$(SENSU_GO_WEB_REVISION) .

build-backend:
	docker build -f Dockerfile-sensu-go --squash --build-arg SENSU_GO_HASH=$(SENSU_GO_HASH) --build-arg SENSU_GO_VERSION=$(SENSU_GO_VERSION) -t $(DOCKER_USERNAME)/sensu:$(SENSU_GO_VERSION)-$(SENSU_GO_REVISION) . 

push-backend: build-backend
	docker tag $(DOCKER_USERNAME)/sensu:$(SENSU_GO_VERSION)-$(SENSU_GO_REVISION) $(DOCKER_USERNAME)/sensu:latest
	docker push $(DOCKER_USERNAME)/sensu:latest
	docker push $(DOCKER_USERNAME)/sensu:$(SENSU_GO_VERSION)-$(SENSU_GO_REVISION)

push-web: build-web
	docker tag $(DOCKER_USERNAME)/sensu-web-nginx:$(SENSU_GO_WEB_VERSION)-$(SENSU_GO_WEB_REVISION) $(DOCKER_USERNAME)/sensu-web-nginx:latest
	docker push $(DOCKER_USERNAME)/sensu-web-nginx:latest

push: push-backend push-web

compose: all
	docker-compose up -d

clean:
	docker-compose down