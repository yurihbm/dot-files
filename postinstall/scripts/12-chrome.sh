#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Google Chrome..."

if command -v google-chrome >/dev/null 2>&1; then
   echo "Google Chrome is already installed. Skipping..."
   return 0
fi

trap 'rm -rf *.rpm' EXIT

wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install ./google-chrome-stable_current_x86_64.rpm -y -q

clear
