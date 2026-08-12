#!/bin/bash

set -e

JAVA_VERSION="25.0.1-open"
SDKMAN_DIR="$HOME/.sdkman"

echo "=== Checking Java ==="

if java -version 2>&1 | grep -q 'version "25\.'; then
    echo "Java 25 is already active."
else
    echo "=== Installing SDKMAN ==="

    if [ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
        curl -s "https://get.sdkman.io" | bash
    fi

    source "$SDKMAN_DIR/bin/sdkman-init.sh"

    echo "=== Installing Java $JAVA_VERSION ==="

    if [ ! -d "$SDKMAN_DIR/candidates/java/$JAVA_VERSION" ]; then
        sdk install java "$JAVA_VERSION"
    else
        echo "Java $JAVA_VERSION is already installed."
    fi

    echo "=== Activating Java $JAVA_VERSION ==="

    sdk use java "$JAVA_VERSION"
fi

export JAVA_HOME="$SDKMAN_DIR/candidates/java/$JAVA_VERSION"
export PATH="$JAVA_HOME/bin:$PATH"

echo "=== Java environment ==="
echo "JAVA_HOME=$JAVA_HOME"

"$JAVA_HOME/bin/java" -version
"$JAVA_HOME/bin/javac" -version
