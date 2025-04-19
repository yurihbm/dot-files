#!/bin/bash

set -e

source ./scripts/helpers/status.sh

trap 'rm -rf *.tar.gz' EXIT

echo -e "\nInstalling neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
[ -d "$LOCAL_DIR/nvim-*" ] && sudo rm -rf "$LOCAL_DIR/nvim-*"
sudo tar -C "$LOCAL_DIR" -xzf nvim-linux-x86_64.tar.gz
echo -e "\nneovim installed."

echo -e "\nInstalling neovim packages dependencies..."
sudo dnf install ripgrep cmake gcc g++ xclip clang-tools-extra -y -q
echo -e "\nDependencies installed."

echo -e "\nCopying neovim config..."
mkdir -p ~/.config
cp "../.config/nvim" "$HOME/.config/nvim" -r
echo -e "\nConfiguration copied."

clear
