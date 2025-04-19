#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling go..."

wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
mkdir -p "$HOME/.local/go"
sudo rm -rf "$HOME/.local/go" && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm -f "go${GO_VERSION}.linux-amd64.tar.gz"

echo -e "\nGo ${GO_VERSION} installed."

clear

