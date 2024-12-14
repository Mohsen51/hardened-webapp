# Variables
IMAGE_NAME=hardened-webapp
IMAGE_TAG=latest
REGISTRY=mohsen51
DEPLOYMENT_FILE=deployment.yaml

# Targets
.PHONY: build push deploy clean

# Build the Docker image
build:
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) .

run:
	docker run --name $(IMAGE_NAME) -d -p 8080:8080 $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

# Push the Docker image to the registry
push: build
	docker push $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

# Deploy the application on Kubernetes
deploy:
	kubectl apply -f manifests/$(DEPLOYMENT_FILE)

# Clean up the deployment from Kubernetes
clean:
	kubectl delete -f manifests/$(DEPLOYMENT_FILE)
