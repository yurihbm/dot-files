#!/bin/bash

set -e

source "$(dirname "$0")/scripts/helpers/status.sh"

echo -e "\nInstalling pyenv..."
curl -fsSL https://pyenv.run | bash

echo -e "\npyenv installed."

clear

