#!/bin/bash

set -e

echo "\n✅ Variables"
echo "\n✅ ZSH"
echo "\n✅ Neovim"
echo "\n✅ NVM and Node"
echo "\n✅ Pyenv"
echo "\n✅ Go"

echo "\nConfiguring git..."
# Configure SSH key for GitHub
mkdir -p ~/.ssh
if [ ! -f ~/.ssh/id_github_ed25519 ]; then
   ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_github_ed25519 -N ""
else
    echo "SSH key already exists at ~/.ssh/id_github_ed25519. Skipping key generation."
fi

# Start SSH agent if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi
ssh-add ~/.ssh/id_github_ed25519

# Git configuration
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global core.editor "nvim"

clear

