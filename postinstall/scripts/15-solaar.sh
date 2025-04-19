#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling solaar..."

if command -v solaar >/dev/null 2>&1; then
   echo "Solaar is already installed. Skipping..."
   return 0
fi

sudo dnf install solaar libX11-devel -y -q

wget https://raw.githubusercontent.com/pwr-Solaar/Solaar/master/rules.d-uinput/42-logitech-unify-permissions.rules
sudo mv 42-logitech-unify-permissions.rules /etc/udev/rules.d/

sudo udevadm control --reload-rules && sudo udevadm trigger

echo -e "\nSolaar installed."

clear
