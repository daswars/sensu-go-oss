SHELL=/bin/bash # Use bash syntax
export SENSU_GO_VERSION=6.1.2
export SENSU_GO_HASH=27af473a8dd3293096708dfcec35e2d98baf1863
export SENSU_GO_REVISION=0
export SENSU_GO_WEB_VERSION=v1.0.3
export SENSU_GO_WEB_HASH=c0890b2dad7b2599bc656460edf89c2596d74fb4
export SENSU_GO_WEB_REVISION=0
export DOCKER_USERNAME=daswars

.PHONY: all
all: build-web build-backend

build-web:
	docker build --ulimit nofile=262144:262144 -f Dockerfile-sensu-go-web-nginx --squash --build-arg SENSU_GO_WEB_VERSION=$(SENSU_GO_WEB_VERSION) -t $(DOCKER_USERNAME)/sensu-web-nginx:$(SENSU_GO_WEB_VERSION)-$(SENSU_GO_WEB_REVISION) .

build-backend:
	docker build -f Dockerfile-sensu-go --squash --build-arg SENSU_GO_HASH=$(SENSU_GO_HASH) --build-arg SENSU_GO_VERSION=$(SENSU_GO_VERSION) -t $(DOCKER_USERNAME)/sensu:$(SENSU_GO_VERSION)-$(SENSU_GO_REVISION) . 


push: build-web build-backend
	docker push $(DOCKER_USERNAME)/sensu:$(SENSU_GO_VERSION)-$(SENSU_GO_REVISION)
	docker push $(DOCKER_USERNAME)/sensu-web-nginx:$(SENSU_GO_WEB_VERSION)-$(SENSU_GO_WEB_REVISION) 

push-latest: push
	docker tag $(DOCKER_USERNAME)/sensu:$(SENSU_GO_VERSION)-$(SENSU_GO_REVISION) $(DOCKER_USERNAME)/sensu:latest
	docker push $(DOCKER_USERNAME)/sensu:latest
	docker tag $(DOCKER_USERNAME)/sensu-web-nginx:$(SENSU_GO_WEB_VERSION)-$(SENSU_GO_WEB_REVISION) $(DOCKER_USERNAME)/sensu-web-nginx:latest
	docker push $(DOCKER_USERNAME)/sensu-web-nginx:latest

compose: all
	docker-compose up -d

clean:
	docker-compose down