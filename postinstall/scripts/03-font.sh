#!/bin/bash

curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -o "./JetBrainsMono.zip"

mkdir -p "$HOME/.local/share/fonts/"

unzip -o "./JetBrainsMono.zip" "*.ttf" "*.otf" -d "$HOME/.local/share/fonts/"

fc-cache -fv "$HOME/.local/share/fonts/"

rm "./JetBrainsMono.zip"
