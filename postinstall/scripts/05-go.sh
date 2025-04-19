#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Go..."

if command -v go >/dev/null 2>&1; then
    echo -e "\nGo is already installed. Skipping..."
    exit 0
fi

wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
mkdir -p "$HOME/.local/go"
sudo rm -rf "$HOME/.local/go" && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm -f "go${GO_VERSION}.linux-amd64.tar.gz"

echo -e "\nGo ${GO_VERSION} installed."

clear

