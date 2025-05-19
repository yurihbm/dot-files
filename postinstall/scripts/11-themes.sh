#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling whitesur-icon-theme-mod...\n"
mkdir -p "$LOCAL_DIR/icons"

ICONS_FOLDER = "$LOCAL_DIR/icons/whitesur-icon-theme-mod"

# Clone the repository if not already cloned.
if [ -d "$ICONS_FOLDER" ]; then
  echo "Repository already cloned. Skipping..."
else
  # Bypass SSH host key checking for the clone, avoiding the prompt.
  GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" \
    git clone git@github.com:yurihbm/whitesur-icon-theme-mod.git "$ICONS_FOLDER"
fi

# Run the install script.
if [ -f "$ICONS_FOLDER/install.sh" ]; then
  pushd "$ICONS_FOLDER" >/dev/null
  ./install.sh || {
    echo -e "\nError: Failed to run install.sh. Exiting..."
    exit 1
  }
  popd >/dev/null
else
  echo "\nError: install.sh not found in the repository. Exiting..."
  exit 1
fi

# Set theme to whitesur if not already set.
CURRENT_ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme)
if [ "$CURRENT_ICON_THEME" != "'whitesur-mod'" ]; then
  gsettings set org.gnome.desktop.interface icon-theme "whitesur-mod"
else
  echo "Icon theme is already set to whitesur-mod. Skipping..."
fi

# Install adw-gtk3-theme for legacy apps.
sudo dnf install adw-gtk3-theme -y -q

# Set theme for legacy apps if not already set.
CURRENT_GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme)
if [ "$CURRENT_GTK_THEME" != "'adw-gtk3-dark'" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
else
  echo "GTK theme is already set to adw-gtk3-dark. Skipping..."
fi

clear
