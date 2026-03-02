#!/bin/bash

echo -e "\nConfiguring Git global settings..."

# Verify required variables are set
if [[ -z "$GIT_NAME" ]] || [[ -z "$GIT_EMAIL" ]]; then
  echo "Error: GIT_NAME or GIT_EMAIL not set. Make sure 00-init.sh is sourced."
  exit 1
fi

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

echo -e "\nGit configuration complete."
