#!/bin/bash

set -e

echo "\n✅ Variables"
echo "\n✅ ZSH"
echo "\n✅ Neovim"
echo "\n✅ NVM and Node"
echo "\n✅ Pyenv"
echo "\n✅ Go"
echo "\n✅ Git"
echo "\n✅ GitHub CLI"
echo "\n✅ GPG (GitHub)"

echo "\nInstalling Docker Engine and setting up rootless mode..."
sudo dnf config-manager addrepo --from-file=https://download.docker.com/linux/fedora/docker.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin fuse-overlayfs -y

if ! command -v dockerd-rootless-setuptool.sh &> /dev/null; then
    echo "Error: dockerd-rootless-setuptool.sh not found. Please ensure Docker is installed correctly."
    exit 1
fi

dockerd-rootless-setuptool.sh install

echo "Rootless Docker installed. Run 'systemctl --user start docker' to start the service."

clear

