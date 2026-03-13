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

# To support mermaid cli and puppeter; headless browser deps
sudo apt-get install -y \
  libgbm1 \
  libasound2t64 || sudo apt-get install -y libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgcc-s1 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6

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
