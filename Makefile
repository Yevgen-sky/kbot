# Makefile for kbot

REGISTRY ?= ghcr.io
REPOSITORY ?= Yevgen-sky/kbot
OS ?= linux
ARCH ?= amd64


VERSION ?= v1.0.0

GIT_SHA := $(shell git rev-parse --short HEAD)

IMAGE_TAG := $(VERSION)-$(GIT_SHA)

IMAGE_FULL := $(REGISTRY)/$(REPOSITORY):$(IMAGE_TAG)-$(OS)-$(ARCH)

HELM_CHART_PATH := helm/kbot

.PHONY: print-image docker-build docker-push helm-lint helm-template update-values helm-upgrade

	print-image:
	@echo $(IMAGE_FULL)

	docker-build:
	docker build \
		--platform=$(OS)/$(ARCH) \
		-t $(IMAGE_FULL) .

	docker-push:
	docker push $(IMAGE_FULL)

	helm-lint:
	helm lint $(HELM_CHART_PATH)

	helm-template:
	helm template kbot $(HELM_CHART_PATH)

	update-values:
	sed -i "s/^  registry:.*/  registry: \"$(REGISTRY)\"/" $(HELM_CHART_PATH)/values.yaml
	sed -i "s/^  repository:.*/  repository: \"$(REPOSITORY)\"/" $(HELM_CHART_PATH)/values.yaml
	sed -i "s/^  tag:.*/  tag: \"$(IMAGE_TAG)\"/" $(HELM_CHART_PATH)/values.yaml
	sed -i "s/^  os:.*/  os: \"$(OS)\"/" $(HELM_CHART_PATH)/values.yaml
	sed -i "s/^  arch:.*/  arch: \"$(ARCH)\"/" $(HELM_CHART_PATH)/values.yaml

	helm-upgrade:
	helm upgrade --install kbot $(HELM_CHART_PATH) \
	  --namespace kbot --create-namespace
