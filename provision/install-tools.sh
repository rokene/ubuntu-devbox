#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source /vagrant/versions.sh

export DEBIAN_FRONTEND=noninteractive

echo "#### updating apt package index"
apt-get update

echo "#### installing development tools and utilities"
apt-get install -y \
  build-essential \
  git \
  git-completion \
  bash-completion \
  zip \
  unzip \
  jq \
  make \
  openconnect \
  curl \
  wget \
  vim \
  ripgrep \
  fd-find \
  tree \
  tmux \
  htop \
  fzf \
  direnv \
  shellcheck \
  bat \
  dnsutils \
  net-tools

echo "#### enabling bash completion"
grep -qxF 'source /usr/share/bash-completion/bash_completion' /home/vagrant/.bashrc || \
  echo 'source /usr/share/bash-completion/bash_completion' >> /home/vagrant/.bashrc

echo "#### adding convenience aliases"
grep -qxF 'alias fd=fdfind' /home/vagrant/.bashrc || \
  echo 'alias fd=fdfind' >> /home/vagrant/.bashrc

grep -qxF 'alias bat=batcat' /home/vagrant/.bashrc || \
  echo 'alias bat=batcat' >> /home/vagrant/.bashrc

echo
echo "==== Installed Tool Versions ===="

git --version
make --version | head -n1
jq --version
rg --version
fdfind --version
batcat --version
tmux -V
fzf --version
direnv --version
shellcheck --version
curl --version | head -n1
wget --version | head -n1
vim --version | head -n1

echo "================================="
