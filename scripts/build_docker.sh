#!/usr/bin/env bash

export TAG="${1}"
export HUB=utako
export GOOS=linux

# Use this once you've created your clusters and have already used helm to deploy
# istio-init and istio.

# builds docker images, updates helm charts to point to correct hub and tag
make docker

# pushes docker images to hub and tag
make push

# uses new docker images to upgrade istio on kubernetes
helm upgrade istio install/kubernetes/helm/istio
