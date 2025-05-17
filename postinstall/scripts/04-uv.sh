#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling uv..."

if command -v uv >/dev/null 2>&1; then
  echo -e "\nuv is already installed. Skipping..."
  return 0
fi

curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$UV_DIR" sh

echo -e "\nuv installed."

clear
