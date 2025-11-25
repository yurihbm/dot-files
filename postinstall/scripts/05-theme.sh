#!/bin/bash

echo -e "\nDownloading WhiteSur Icon Theme..."

USER_ICONS_FOLDER="$HOME/.local/icons"
WHITESUR_ICON_THEME_FOLDER="$USER_ICONS_FOLDER/whitesur-icon-theme"

if [ -d "$WHITESUR_ICON_THEME_FOLDER" ]; then
  echo -e "\nWhiteSur Icon Theme is already installed. Removing existing installation..."
  rm -rf "$WHITESUR_ICON_THEME_FOLDER"
fi

mkdir -p "$USER_ICONS_FOLDER"

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git "$WHITESUR_ICON_THEME_FOLDER"

echo -e "\nCopying custom icons to WhiteSur Icon Theme..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICONS_DIR="$(realpath "$SCRIPT_DIR/../../icons")"
cp "$ICONS_DIR"/* "$WHITESUR_ICON_THEME_FOLDER/alternative/apps/scalable/"

echo -e "\nInstalling WhiteSur Icon Theme..."

bash "$WHITESUR_ICON_THEME_FOLDER/install.sh" -a -n whitesur

echo -e "\nWhiteSur Icon Theme installation complete.\n"
