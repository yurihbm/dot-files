#!/bin/bash

set -e

echo "\nInstalling Docker Engine and setting up rootless mode..."
sudo dnf config-manager addrepo --from-file=https://download.docker.com/linux/fedora/docker.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin fuse-overlayfs -y
dockerd-rootless-setuptool.sh install
echo "Rootless Docker installed. Run 'systemctl --user start docker' to start the service."

