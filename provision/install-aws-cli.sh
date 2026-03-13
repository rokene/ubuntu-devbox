#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=/vagrant/versions.sh
source /vagrant/versions.sh

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "#### installing AWS CLI v2"

apt-get update
apt-get install -y curl unzip

if [ "${AWSCLI_VERSION}" = "latest" ]; then
  AWS_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
else
  AWS_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip"
fi

curl -fsSL -o "${TMP_DIR}/awscliv2.zip" "${AWS_URL}"
unzip -q "${TMP_DIR}/awscliv2.zip" -d "${TMP_DIR}"

if command -v aws >/dev/null 2>&1; then
  "${TMP_DIR}/aws/install" --update
else
  "${TMP_DIR}/aws/install"
fi

echo
echo "==== AWS CLI Version ===="
aws --version
echo "========================="
