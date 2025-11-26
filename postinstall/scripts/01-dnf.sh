#!/bin/bash

# ========== DNF Applications ==========

echo -e "\nAdding Docker repository...\n"

sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

echo -e "\nInstalling DNF applications...\n"

sudo dnf copr enable -y atim/starship &&
  sudo dnf copr enable -y jdxcode/mise &&
  sudo dnf install -y \
    google-chrome-stable \
    starship \
    fd-find \
    tmux \
    mise \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin \
    fuse-overlayfs \
    zsh &&
  sudo dnf update -y &&
  sudo dnf clean all

echo -e "\nEnabling Docker Rootless mode...\n"

if ! command -v dockerd-rootless-setuptool.sh &>/dev/null; then
  echo -e "\nError: dockerd-rootless-setuptool.sh not found. Please ensure Docker is installed correctly."
  exit 1
fi

dockerd-rootless-setuptool.sh install

echo -e "\nRootless Docker installed. Run 'systemctl --user start docker' to start the service."

echo -e "\nDNF applications installation complete.\n"
