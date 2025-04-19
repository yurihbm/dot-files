#!/bin/bash

set -e

echo "✅ Variables"
echo "✅ ZSH"

echo -e "\nInstalling neovim...";
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
[ -d "/opt/nvim" ] && sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux-x86_64.tar.gz
echo -e "\nneovim installed.";

echo -e "\nInstalling neovim packages dependencies...";
sudo dnf install ripgrep cmake gcc g++ xclip clang-tools-extra -y;
echo -e "\nDependencies installed.";

echo -e "\nCopying neovim config...";
mkdir -p ~/.config;
cp ../.config/nvim ~/.config/nvim -r;
echo -e "\nConfiguration copied.";

clear

