#!/usr/bin/env bash

set -e

echo "#### updating apt"
apt-get -y update

echo "#### installing build essential"
apt-get -y install build-essential

echo "#### installing tools via aptitude"
apt-get install -y aptitude
aptitude install -y git git-completion zip unzip jq

echo "#### installing tools via apt"
apt install -y make openconnect
