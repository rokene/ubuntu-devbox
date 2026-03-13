#!/usr/bin/env bash

set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "#### installing Google Cloud CLI"

apt-get update
apt-get install -y ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | gpg --dearmor --batch --yes --no-tty -o /etc/apt/keyrings/google-cloud.gpg

chmod go+r /etc/apt/keyrings/google-cloud.gpg

echo "deb [signed-by=/etc/apt/keyrings/google-cloud.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  > /etc/apt/sources.list.d/google-cloud-sdk.list

apt-get update
apt-get install -y google-cloud-cli

echo
echo "==== Google Cloud CLI Version ===="
gcloud version
echo "=================================="
