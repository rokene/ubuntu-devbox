#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "#### installing Azure CLI"

apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release apt-transport-https

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor --batch --yes -o /etc/apt/keyrings/microsoft.gpg

chmod a+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST="$(lsb_release -cs)"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ ${AZ_DIST} main" \
  > /etc/apt/sources.list.d/azure-cli.list

apt-get update
apt-get install -y azure-cli

echo
echo "==== Azure CLI Version ===="
az version
echo "==========================="
