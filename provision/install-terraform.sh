#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=/vagrant/versions.sh
source /vagrant/versions.sh

ARCH="amd64"
OS="linux"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

ZIP_NAME="terraform_${TERRAFORM_VERSION}_${OS}_${ARCH}.zip"
URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${ZIP_NAME}"

echo "#### installing Terraform ${TERRAFORM_VERSION}"

apt-get update
apt-get install -y unzip curl

curl -fsSL -o "${TMP_DIR}/${ZIP_NAME}" "${URL}"
unzip -o "${TMP_DIR}/${ZIP_NAME}" -d "${TMP_DIR}"

install -m 0755 "${TMP_DIR}/terraform" /usr/local/bin/terraform

echo
echo "==== Terraform Version ===="
terraform version
echo "==========================="
