#!/bin/bash

set -e

echo "✅ Variables"
echo "✅ ZSH"
echo "✅ Neovim"
echo "✅ NVM and Node"
echo "✅ Pyenv"

echo -e "\nInstalling go..."

wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm -f "go${GO_VERSION}.linux-amd64.tar.gz"

echo -e "\nGo ${GO_VERSION} installed."

clear

