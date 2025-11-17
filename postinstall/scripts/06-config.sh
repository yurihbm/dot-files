#!/bin/bash

mkdir -p "$HOME/.config"

echo -e "\nCopying config files..."
cp -r ../.config/* "$HOME/.config/" -R
echo -e "\nDone."
