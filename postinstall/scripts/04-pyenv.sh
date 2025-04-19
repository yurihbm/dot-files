#!/bin/bash

set -e

source ./scripts/helpers/status.sh

mkdir -p "$HOME/.local/bin"

echo -e "\nInstalling pyenv..."
curl -fsSL https://pyenv.run | bash

echo -e "\npyenv installed."

clear

