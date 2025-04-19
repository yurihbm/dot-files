#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling solaar..."

sudo dnf install solaar libX11-devel -y

wget https://raw.githubusercontent.com/pwr-Solaar/Solaar/master/rules.d-uinput/42-logitech-unify-permissions.rules
sudo mv 42-logitech-unify-permissions.rules /etc/udev/rules.d/

echo -e "\nSolaar installed."

clear

