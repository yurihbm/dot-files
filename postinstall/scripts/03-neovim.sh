#!/bin/bash

# ========== Neovim ==========

NEOVIM_APPIMAGE_PATH="$HOME/.local/bin/nvim"

if command -v nvim >/dev/null 2>&1 || [ -f "$NEOVIM_APPIMAGE_PATH" ]; then
  echo -e "\nNeovim is already installed. Skipping..."
  exit 0
fi

echo -e "\nInstalling Neovim (AppImage)..."

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -o "$NEOVIM_APPIMAGE_PATH"

sudo chmod +x "$NEOVIM_APPIMAGE_PATH"

echo -e "\nNeovim installation complete.\n"
