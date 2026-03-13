#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=/vagrant/versions.sh
source /vagrant/versions.sh

echo "#### installing Claude Code CLI"

su - vagrant -c "
  export NVM_DIR=\"\$HOME/.nvm\"
  [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"

  npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}
"

echo
echo "==== Claude Code Version ===="

su - vagrant -c "
  export NVM_DIR=\"\$HOME/.nvm\"
  [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"

  claude --version
"

echo "============================="
