#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling JetBrains Mono Nerd Font..."

# Download the font from Nerd Fonts GitHub releases
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR=$(mktemp -d)

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download and extract the font
curl -L "$FONT_URL" -o "$TEMP_DIR/JetBrainsMono.zip"
unzip -o "$TEMP_DIR/JetBrainsMono.zip" -d "$FONT_DIR"

# Refresh font cache
fc-cache -fv

# Set the font in GNOME Terminal
gsettings set org.gnome.Ptyxis use-system-font false
gsettings set org.gnome.Ptyxis font-name 'JetBrainsMono Nerd Font 12'

# Clean up
rm -rf "$TEMP_DIR"

echo "JetBrains Mono Nerd Font installed successfully."
