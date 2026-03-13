#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=/vagrant/versions.sh
source /vagrant/versions.sh

export DEBIAN_FRONTEND=noninteractive

echo "#### updating apt metadata"
apt-get update

echo "#### installing Docker prerequisites"
apt-get install -y \
  ca-certificates \
  curl \
  gnupg

echo "#### configuring Docker apt keyring"
install -m 0755 -d /etc/apt/keyrings

if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi

chmod a+r /etc/apt/keyrings/docker.gpg

echo "#### configuring Docker apt repository"
cat > /etc/apt/sources.list.d/docker.list <<EOF
deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable
EOF

echo "#### updating apt metadata after adding Docker repo"
apt-get update

echo "#### installing Docker engine and plugins"
apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "#### enabling Docker"
systemctl enable --now docker
systemctl is-active --quiet docker

echo
echo "==== Docker Versions ===="
docker --version
docker compose version
containerd --version || true
echo "========================="
