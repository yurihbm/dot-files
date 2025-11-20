#!/bin/bash

echo -e "\nInstalling eza (a modern replacement for 'ls')..."

curl -L https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -o ./eza_x86_64-unknown-linux-gnu.tar.gz

mkdir -p "$HOME/.local/bin"

tar -xvf eza_x86_64-unknown-linux-gnu.tar.gz -C "$HOME/.local/bin" --strip-components=1

rm eza_x86_64-unknown-linux-gnu.tar.gz

echo -e "\neza installation complete.\n"
