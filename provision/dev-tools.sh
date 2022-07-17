#!/usr/bin/env bash
#
# Install/configure sundry dev tools

set -e

echo "#### installing tools via aptitude"
apt-get install -y aptitude
aptitude install -y git git-completion zip unzip jq 

echo "#### installing tools via apt"
apt install -y docker-compose make openconnect nodejs npm
