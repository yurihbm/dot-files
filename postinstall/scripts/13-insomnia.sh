#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Insomnia..."

if command -v insomnia >/dev/null 2>&1; then
    echo "Insomnia is already installed. Skipping..."
    return 0
fi

trap 'rm -rf *.rpm' EXIT

echo "Installing Insomnia..."
INSOMNIA_URL=$(curl -s https://api.github.com/repos/Kong/insomnia/releases/latest \
  | grep "browser_download_url" \
  | grep ".rpm" \
  | cut -d '"' -f 4)
INSOMNIA_PACKAGE=$(basename "$INSOMNIA_URL")
wget "$INSOMNIA_URL"
sudo dnf install "$INSOMNIA_PACKAGE" -y

clear

