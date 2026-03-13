#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=/vagrant/versions.sh
source /vagrant/versions.sh

export DEBIAN_FRONTEND=noninteractive

echo "#### installing Java LTS and Maven"

apt-get update

apt-get install -y \
  "openjdk-${JAVA_VERSION}-jdk" \
  maven \
  unzip

echo "#### installing Gradle ${GRADLE_VERSION}"

ARCH="bin"
GRADLE_ZIP="gradle-${GRADLE_VERSION}-${ARCH}.zip"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

curl -fsSL -o "${TMP_DIR}/${GRADLE_ZIP}" \
  "https://services.gradle.org/distributions/${GRADLE_ZIP}"

mkdir -p /opt/gradle
rm -rf "/opt/gradle/gradle-${GRADLE_VERSION}"
unzip -q "${TMP_DIR}/${GRADLE_ZIP}" -d /opt/gradle

ln -sfn "/opt/gradle/gradle-${GRADLE_VERSION}" /opt/gradle/current
ln -sfn /opt/gradle/current/bin/gradle /usr/local/bin/gradle

echo "#### configuring JAVA_HOME for all users"
JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
cat > /etc/profile.d/java-gradle.sh <<EOF
export JAVA_HOME="${JAVA_HOME}"
export GRADLE_HOME="/opt/gradle/current"
export PATH="\$GRADLE_HOME/bin:\$PATH"
EOF
chmod 644 /etc/profile.d/java-gradle.sh

echo
echo "==== Java / Maven / Gradle Versions ===="
java -version
javac -version
mvn -version
gradle --version
echo "========================================"
