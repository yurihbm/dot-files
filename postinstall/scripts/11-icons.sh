#!/bin/bash

set -e

echo "\n✅ Variables"
echo "\n✅ ZSH"
echo "\n✅ Neovim"
echo "\n✅ NVM and Node"
echo "\n✅ Pyenv"
echo "\n✅ Go"
echo "\n✅ Git"
echo "\n✅ GitHub CLI"
echo "\n✅ GPG (GitHub)"
echo "\n✅ Docker"
echo "\n✅ Gnome Extensions"


echo "\nInstalling whitesur-icon-theme-mod..."
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
    ./install.sh || { echo "Error: Failed to run install.sh. Exiting..."; exit 1; }
    popd > /dev/null
else
    echo "Error: install.sh not found in the repository. Exiting..."
    exit 1
fi

echo "whitesur-icon-theme-mod installed. Use Gnome Tweaks to set it up."

clear

