#!/usr/bin/env bash

set -e

echo "#### updating apt"
apt-get -y update

echo "#### installing build essential"
apt-get -y install build-essential

echo "#### installing software prop common"
sudo apt install -y software-properties-common
