#!/bin/zsh

echo -e "\nInstalling zsh..."

sudo dnf update -y -q
sudo dnf install -y -q zsh 

echo -e "\nBacking up .zshrc file..."
cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
echo -e "\nBack up complete."

echo -e "\nCopying global .zshrc files..."
cp ../zsh/.zshrc "$HOME"
mkdir -p "$HOME/.zshrc.d"
cp ../zsh/.zshrc.d/* "$HOME/.zshrc.d/"
echo -e "\nDone."
