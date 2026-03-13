#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source /vagrant/versions.sh

export DEBIAN_FRONTEND=noninteractive

echo "installing python tooling"

apt-get update

apt-get install -y \
  python-is-python3 \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev

echo "python version:"
python --version

echo "pip version:"
pip3 --version
