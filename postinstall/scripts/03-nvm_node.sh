#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling NVM and latest LTS Node..."

if command -v nvm >/dev/null 2>&1; then
  echo -e "\nNVM is already installed. Skipping..."
  return 0
fi

mkdir -p $NVM_DIR

curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

nvm install --lts
corepack enable

echo -e "\nNVM and Node installed."

clear
