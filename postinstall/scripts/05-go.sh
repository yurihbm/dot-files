#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Go..."

if command -v go >/dev/null 2>&1; then
   echo -e "\nGo is already installed. Skipping..."
   return 0
fi

wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
rm -rf "$LOCAL_DIR/go"
tar -C $LOCAL_DIR -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm -f "go${GO_VERSION}.linux-amd64.tar.gz"

echo -e "\nGo ${GO_VERSION} installed."

clear
