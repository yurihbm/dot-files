#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Docker Engine and setting up rootless mode..."

if command -v docker >/dev/null 2>&1; then
    echo -e "\nDocker is already installed. Skipping..."
    exit 0
fi

sudo dnf config-manager addrepo --from-file=https://download.docker.com/linux/fedora/docker.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin fuse-overlayfs -y

if ! command -v dockerd-rootless-setuptool.sh &> /dev/null; then
    echo -e "\nError: dockerd-rootless-setuptool.sh not found. Please ensure Docker is installed correctly."
    exit 1
fi

dockerd-rootless-setuptool.sh install

echo -e "\nRootless Docker installed. Run 'systemctl --user start docker' to start the service."

clear

