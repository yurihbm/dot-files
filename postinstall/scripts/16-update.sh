#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nUpdating system..."

# Update the system
sudo dnf update -y -q

# Clean up
sudo dnf autoremove -y -q
sudo dnf clean all -q

clear
