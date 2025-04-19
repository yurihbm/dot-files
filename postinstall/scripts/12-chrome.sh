#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Google Chrome...\n"

trap 'rm -rf *.rpm' EXIT

echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install ./google-chrome-stable_current_x86_64.rpm -y

clear

