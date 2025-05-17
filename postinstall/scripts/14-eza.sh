#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling eza...\n"

if command -v eza >/dev/null 2>&1; then
  echo "eza is already installed. Skipping..."
  return 0
fi

EZA_URL=$(
  curl -s https://api.github.com/repos/eza-community/eza/releases/latest |
    grep "browser_download_url" |
    grep "eza_x86_64-unknown-linux-gnu.tar.gz" |
    cut -d '"' -f 4
)
EZA_TAR=$(basename "$EZA_URL")
mkdir -p "$LOCAL_DIR/eza/bin"
wget "$EZA_URL"
tar -xzf "$EZA_TAR" -C "$LOCAL_DIR/eza/bin"

rm -rf "$EZA_TAR"

clear
