#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling pyenv..."

if command -v pyenv >/dev/null 2>&1; then
    echo -e "\npyenv is already installed. Skipping..."
    return 0
fi

mkdir -p "$HOME/.local/bin"

curl -fsSL https://pyenv.run | bash

echo -e "\npyenv installed."

clear

