#!/bin/bash

set -e

echo "\nConfiguring git..."
mkdir -p ~/.ssh
echo -ne '~/.ssh/id_github_ed25519\n\n\n' | ssh-keygen -t ed25519 -C "$GIT_EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github_ed25519
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global core.editor "nvim"

