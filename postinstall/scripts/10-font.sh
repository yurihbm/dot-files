#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling JetBrains Mono Nerd Font..."

# Download the font from Nerd Fonts GitHub releases
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
FONT_DIR="$LOCAL_DIR/share/fonts"
TEMP_DIR=$(mktemp -d)

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download and extract the font
curl -L "$FONT_URL" -o "$TEMP_DIR/JetBrainsMono.zip"
unzip -o "$TEMP_DIR/JetBrainsMono.zip" "*.ttf" "*.otf" -d "$FONT_DIR/jetbrains-mono"

# Refresh font cache
fc-cache -fv "$FONT_DIR"

# Clean up
rm -rf "$TEMP_DIR"

echo "JetBrains Mono Nerd Font installed successfully."
