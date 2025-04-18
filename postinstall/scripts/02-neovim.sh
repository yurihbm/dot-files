#!/bin/bash

set -e

echo "\nInstalling neovim...";
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
[ -d "/opt/nvim" ] && sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux-x86_64.tar.gz
echo "neovim installed.";

echo "\nInstalling neovim packages dependencies...";
sudo dnf install ripgrep cmake gcc g++ xclip clang-tools-extra;
echo "Dependencies installed.";

echo "\nCopying neovim config...";
mkdir -p ~/.config;
cp .config/nvim ~/.config/nvim -r;
echo "Configuration copied.";

