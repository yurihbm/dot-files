#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling whitesur-icon-theme-mod...\n"
mkdir -p "$HOME/.icons"
# Clone the repository if not already cloned
if [ -d "$HOME/.icons/whitesur-icon-theme-mod" ]; then
   echo "Repository already cloned. Skipping..."
else
   git clone git@github.com:yurihbm/whitesur-icon-theme-mod.git "$HOME/.icons/whitesur-icon-theme-mod"
fi

# Run the install script
if [ -f "$HOME/.icons/whitesur-icon-theme-mod/install.sh" ]; then
    pushd "$HOME/.icons/whitesur-icon-theme-mod" > /dev/null
    ./install.sh || { echo -e "\nError: Failed to run install.sh. Exiting..."; exit 1; }
    popd > /dev/null
else
    echo "\nError: install.sh not found in the repository. Exiting..."
    exit 1
fi

echo -e "whitesur-icon-theme-mod installed. Use Gnome Tweaks to set it up."

clear

