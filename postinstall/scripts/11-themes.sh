#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling whitesur-icon-theme-mod...\n"
mkdir -p "$HOME/.icons"
# Clone the repository if not already cloned.
if [ -d "$HOME/.icons/whitesur-icon-theme-mod" ]; then
   echo "Repository already cloned. Skipping..."
else
   git clone git@github.com:yurihbm/whitesur-icon-theme-mod.git "$HOME/.icons/whitesur-icon-theme-mod"
fi

# Run the install script.
if [ -f "$HOME/.icons/whitesur-icon-theme-mod/install.sh" ]; then
    pushd "$HOME/.icons/whitesur-icon-theme-mod" > /dev/null
    ./install.sh || { echo -e "\nError: Failed to run install.sh. Exiting..."; exit 1; }
    popd > /dev/null
else
    echo "\nError: install.sh not found in the repository. Exiting..."
    exit 1
fi

# Set theme to whitesur.
gsettings set org.gnome.desktop.interface icon-theme "whitesur-mod"

# Legacy theme for gtk3 apps.
sudo dnf install adw-gtk3-theme -y

# Set theme for legacy apps.
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"

clear

