#!/usr/bin/env bash

set -ex

echo "Downloading and installing helm..."
curl -L https://git.io/get_helm.sh | bash

echo "Getting kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

echo "Making kubectl executable..."
chmod +x ./kubectl

echo "Moving kubectl binary to PATH..."
mv ./kubectl /usr/local/bin/kubectl

echo "DONE!"
kubectl version
