#!/bin/bash

set -e

JAVA_VERSION="25.0.1-open"
SDKMAN_DIR="$HOME/.sdkman"

echo "Checking current Java version..."

if java -version 2>&1 | grep -q 'version "25\.'; then
    echo "Java 25 is already active."
    java -version
    exit 0
fi

echo "Installing SDKMAN..."

if [ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
    curl -s "https://get.sdkman.io" | bash
fi

source "$SDKMAN_DIR/bin/sdkman-init.sh"

echo "Installing Java $JAVA_VERSION..."

if ! sdk list java | grep -q "$JAVA_VERSION"; then
    echo "Java $JAVA_VERSION is not available through SDKMAN."
    exit 1
fi

sdk install java "$JAVA_VERSION"

echo "Activating Java $JAVA_VERSION..."

sdk use java "$JAVA_VERSION"

export JAVA_HOME="$SDKMAN_DIR/candidates/java/$JAVA_VERSION"
export PATH="$JAVA_HOME/bin:$PATH"

echo "Java after installation:"
java -version

echo "JAVA_HOME=$JAVA_HOME"
