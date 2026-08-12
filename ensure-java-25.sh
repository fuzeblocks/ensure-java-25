#!/bin/bash

set -e

JAVA_VERSION="25.0.1-open"
SDKMAN_DIR="$HOME/.sdkman"
JAVA_HOME_PATH="$SDKMAN_DIR/candidates/java/$JAVA_VERSION"

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

    if ! sdk list java | grep -q "$JAVA_VERSION"; then
        echo "Java $JAVA_VERSION is not available through SDKMAN."
        exit 1
    fi

    if [ ! -d "$JAVA_HOME_PATH" ]; then
        sdk install java "$JAVA_VERSION"
    fi

    echo "=== Activating Java $JAVA_VERSION ==="

    sdk use java "$JAVA_VERSION"
fi

# Force Java 25 for the current process
export JAVA_HOME="$JAVA_HOME_PATH"
export PATH="$JAVA_HOME/bin:$PATH"

echo "=== Java environment ==="
echo "JAVA_HOME=$JAVA_HOME"
echo "java:"
"$JAVA_HOME/bin/java" -version

echo "javac:"
"$JAVA_HOME/bin/javac" -version

echo "PATH:"
echo "$PATH"
