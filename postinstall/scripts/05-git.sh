#!/bin/bash

echo -e "\nConfiguring Git global settings..."

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

echo -e "\nGit configuration complete."
