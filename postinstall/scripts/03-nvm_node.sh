#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling NVM and latest LTS Node..."
NVM_DIR="$HOME/.local/nvm"
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
corepack enable

echo -e "\nNVM and Node installed."

clear

