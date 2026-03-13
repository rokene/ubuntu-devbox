#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source /vagrant/versions.sh

export DEBIAN_FRONTEND=noninteractive

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

ARCH="amd64"
INSTALL_DIR="/usr/local/bin"

# install kind: https://kind.sigs.k8s.io/docs/user/quick-start/
echo "installing kind ${KIND_VERSION}"
curl -fsSL -o "${TMP_DIR}/kind" \
  "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-${ARCH}"
install -o root -g root -m 0755 "${TMP_DIR}/kind" "${INSTALL_DIR}/kind"

# install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
echo "installing kubectl ${KUBECTL_VERSION}"
curl -fsSL -o "${TMP_DIR}/kubectl" \
  "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl"
curl -fsSL -o "${TMP_DIR}/kubectl.sha256" \
  "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl.sha256"
echo "$(<"${TMP_DIR}/kubectl.sha256")  ${TMP_DIR}/kubectl" | sha256sum --check
install -o root -g root -m 0755 "${TMP_DIR}/kubectl" "${INSTALL_DIR}/kubectl"

# install helm: https://helm.sh/docs/intro/install/
echo "installing helm ${HELM_VERSION}"
HELM_TARBALL="helm-${HELM_VERSION}-linux-${ARCH}.tar.gz"
curl -fsSL -o "${TMP_DIR}/${HELM_TARBALL}" \
  "https://get.helm.sh/${HELM_TARBALL}"
tar -C "${TMP_DIR}" -xzf "${TMP_DIR}/${HELM_TARBALL}"
install -o root -g root -m 0755 \
  "${TMP_DIR}/linux-${ARCH}/helm" \
  "${INSTALL_DIR}/helm"

echo "verifying installed versions"
kind --version
kubectl version --client=true
helm version
