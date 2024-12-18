# Hardened Nginx

This repository contains a Dockerfile that exposes a static `index.html` using Nginx. Below are the instructions to build, push, and deploy the Dockerfile using Kubernetes. The deployment manifest is secured applying hardening kubernetes options.

## Prerequisites

- A Kubernetes cluster. In this example, we use [kind](https://kind.sigs.k8s.io/) to deploy a local Kubernetes cluster.
- A self signed certificate : `mkdir certs && openssl req -x509 -subj '/CN=localhost' -nodes -days 365 -newkey rsa:4096 -keyout certs/server.key -out certs/server.crt`

## Setup

1. **Deploy a local Kubernetes cluster using kind:**

  ```sh
  kind create cluster
  ```

2. **Build and push the Docker image:**

  The `Makefile` in this repository can be used to build and push the Docker image.

  ```sh
  make push
  ```

3. **Deploy the application:**

  Use the `Makefile` to deploy the application to your Kubernetes cluster.

  ```sh
  make deploy
  ```

## Makefile Targets

- `build`: Builds the Docker image.
- `push`: Pushes the Docker image to the specified container registry.
- `deploy`: Deploys the application to the Kubernetes cluster.
- `run`: Runs the Docker image locally for debug

## Notes

- Ensure that Docker is installed and running on your machine.
- Make sure you have `kubectl` configured to interact with your Kubernetes cluster.
