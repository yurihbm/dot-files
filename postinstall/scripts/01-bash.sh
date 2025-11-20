#!/bin/bash

echo -e "\nBacking up .bashrc file..."
cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
echo -e "\nBack up complete."

echo -e "\nCopying global .bashrc files..."
cp ../bash/.bashrc "$HOME"
mkdir -p "$HOME/.bashrc.d"
cp ../bash/.bashrc.d/* "$HOME/.bashrc.d/"
echo -e "\nDone."
