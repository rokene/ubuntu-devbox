#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=/vagrant/versions.sh
source /vagrant/versions.sh

ARCH="amd64"
OS="linux"
GO_TARBALL="go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "#### installing Go ${GO_VERSION}"

curl -fsSL -o "${TMP_DIR}/${GO_TARBALL}" "${GO_URL}"

rm -rf /usr/local/go
tar -C /usr/local -xzf "${TMP_DIR}/${GO_TARBALL}"

cat > /etc/profile.d/go.sh <<'EOF'
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
EOF
chmod 644 /etc/profile.d/go.sh

grep -qxF 'export GOROOT="/usr/local/go"' /home/vagrant/.bashrc || \
  echo 'export GOROOT="/usr/local/go"' >> /home/vagrant/.bashrc

grep -qxF 'export GOPATH="$HOME/go"' /home/vagrant/.bashrc || \
  echo 'export GOPATH="$HOME/go"' >> /home/vagrant/.bashrc

grep -qxF 'export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"' /home/vagrant/.bashrc || \
  echo 'export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"' >> /home/vagrant/.bashrc

install -d -m 0755 -o vagrant -g vagrant /home/vagrant/go
install -d -m 0755 -o vagrant -g vagrant /home/vagrant/go/bin
install -d -m 0755 -o vagrant -g vagrant /home/vagrant/go/src
install -d -m 0755 -o vagrant -g vagrant /home/vagrant/go/pkg

echo
echo "==== Go Version ===="
/usr/local/go/bin/go version
echo "===================="
