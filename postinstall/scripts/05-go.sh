#!/bin/bash

set -e

echo "\n✅ Variables"
echo "\n✅ ZSH"
echo "\n✅ Neovim"
echo "\n✅ NVM and Node"
echo "\n✅ Pyenv"

echo "\nInstalling go..."
wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm -f "go${GO_VERSION}.linux-amd64.tar.gz"
echo "go installed."

clear

