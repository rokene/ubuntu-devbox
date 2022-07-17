#!/usr/bin/env bash

set -e

# echo "uninstalling older version"
# sudo apt-get \
#     remove \
#     docker \
#     docker-engine \
#     docker.io \
#     containerd \
#     runc

echo "#### Installing and configuring Docker CE"
apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "#### adding docker's official GPG key"
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "#### setting up repo"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "#### updating apt"
apt-get -y update

echo "#### installing docker engine"
apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose

groupadd -f docker
usermod -aG docker vagrant

systemctl enable docker.service
systemctl enable containerd.service
