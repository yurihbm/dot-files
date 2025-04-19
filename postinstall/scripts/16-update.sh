#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nUpdating system..."

# Update the system
sudo dnf update -y

# Clean up
sudo dnf autoremove -y
sudo dnf clean all

clear

