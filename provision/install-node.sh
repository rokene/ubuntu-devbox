#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source /vagrant/versions.sh

VAGRANT_USER="vagrant"
VAGRANT_HOME="/home/${VAGRANT_USER}"
NVM_DIR="${VAGRANT_HOME}/.nvm"
NVM_VERSION="${NVM_VERSION:-v0.39.7}"
NODE_VERSION="${NODE_VERSION:-22}"

echo "installing NVM ${NVM_VERSION} for the ${VAGRANT_USER} user"
if [ ! -s "${NVM_DIR}/nvm.sh" ]; then
  su - "${VAGRANT_USER}" -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash"
fi

echo "ensuring NVM is loaded from .bashrc"
BASHRC="${VAGRANT_HOME}/.bashrc"

grep -qxF 'export NVM_DIR="$HOME/.nvm"' "${BASHRC}" || \
  echo 'export NVM_DIR="$HOME/.nvm"' >> "${BASHRC}"

grep -qxF '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' "${BASHRC}" || \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "${BASHRC}"

grep -qxF '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' "${BASHRC}" || \
  echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> "${BASHRC}"

echo "installing Node.js ${NODE_VERSION} for the ${VAGRANT_USER} user"
su - "${VAGRANT_USER}" -c "
  export NVM_DIR=\"\$HOME/.nvm\"
  [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"
  nvm install ${NODE_VERSION}
  nvm alias default ${NODE_VERSION}
  nvm use default
  node --version
  npm --version
"