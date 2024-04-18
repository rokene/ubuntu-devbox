#!/usr/bin/env bash

set -e

echo "Install NVM for the Vagrant user"
su - vagrant -c 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash'

echo "Source the NVM script to make it available in this session"
su - vagrant -c 'echo "export NVM_DIR=\"$HOME/.nvm\"" >> ~/.bashrc'
su - vagrant -c 'echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"" >> ~/.bashrc'
su - vagrant -c 'echo "[ -s \"$NVM_DIR/bash_completion\" ] && \. \"$NVM_DIR/bash_completion\"" >> ~/.bashrc'

echo "Load NVM and install Node.js LTS 20"
su - vagrant -c 'export NVM_DIR="$HOME/.nvm"
                  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                  nvm install 20
                  nvm use 20
                  nvm alias default node'
