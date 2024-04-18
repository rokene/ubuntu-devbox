#!/usr/bin/env bash

set -e

# install kind: https://kind.sigs.k8s.io/docs/user/quick-start/
echo "installing kind"
curl -L -o kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
sudo install -o root -g root -m 0755 kind /usr/local/bin/kind

# install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
echo "installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

HELM_FILE_NAME=helm-v3.14.4-linux-amd64.tar.gz

# install helm: https://helm.sh/docs/intro/install/
echo "installing helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
