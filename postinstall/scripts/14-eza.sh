#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling eza...\n"

if command -v eza >/dev/null 2>&1; then
    echo "eza is already installed. Skipping..."
    exit 0
fi

trap 'rm -rf *.tar.gz' EXIT

echo "Installing eza..."
EZA_URL=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest \
  | grep "browser_download_url" \
  | grep "eza_x86_64-unknown-linux-gnu.tar.gz" \
  | cut -d '"' -f 4
)
EZA_TAR=$(basename "$EZA_URL")
mkdir -p "$LOCAL_DIR/eza/bin"
wget "$EZA_URL"
tar -xzf "$EZA_TAR" -C "$LOCAL_DIR/eza/bin"

clear

