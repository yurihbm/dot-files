#!/bin/bash

echo -e "\dDownloading WhiteSur Icon Theme..."

USER_ICONS_FOLDER="$HOME/.local/icons"

mkdir -p "$USER_ICONS_FOLDER"

WHITESUR_ICON_THEME_FOLDER="$USER_ICONS_FOLDER/whitesur-icon-theme"

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git "$WHITESUR_ICON_THEME_FOLDER"

echo -e "\nCopying custom icons to WhiteSur Icon Theme..."

cp ../icons/* "$WHITESUR_ICON_THEME_FOLDER/alternative/apps/scalable/"

echo -e "\nInstalling WhiteSur Icon Theme..."

bash "$WHITESUR_ICON_THEME_FOLDER/install.sh" -a -n whitesur

echo -e "\nWhiteSur Icon Theme installation complete.\n"
