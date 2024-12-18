# Variables
IMAGE_NAME=hardened-webapp
IMAGE_TAG=1.0.0
REGISTRY=mohsen51
DEPLOYMENT_FILE=deployment.yaml

# Targets
.PHONY: cert build run push deploy clean

# Create the self signed tls certificates
cert:
	mkdir certs || true
	openssl req -x509 -subj '/CN=localhost' -nodes -days 365 -newkey rsa:4096 -keyout certs/server.key -out certs/server.crt

# Build the Docker image
build:
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) -t $(REGISTRY)/$(IMAGE_NAME):latest .

run:
	docker rm -f $(IMAGE_NAME) || true
	docker run --name $(IMAGE_NAME) -d -p 8443:8443 --cap-drop=ALL --privileged=false --security-opt=no-new-privileges $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

# Push the Docker image to the registry with all tags
push: build
	docker push $(REGISTRY)/$(IMAGE_NAME) -a

# Deploy the application on Kubernetes
deploy:
	kubectl apply -f manifests/$(DEPLOYMENT_FILE)

# Clean up the deployment from Kubernetes
clean:
	kubectl delete -f manifests/$(DEPLOYMENT_FILE)
