#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source /vagrant/versions.sh

curl -fsSL https://releases.hashicorp.com/vault/${VAULT_CLI_VERSION}/vault_${VAULT_CLI_VERSION}_linux_amd64.zip -o /tmp/vault.zip && \
    unzip -q /tmp/vault.zip -d /tmp && \
    install -m 0755 /tmp/vault /usr/local/bin/vault && \
    rm /tmp/vault.zip /tmp/vault
