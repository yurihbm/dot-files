#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling pyenv..."
PYENV_ROOT="$HOME/.local/pyenv"
curl -fsSL https://pyenv.run | bash

echo -e "\npyenv installed."

clear

