#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling github-cli..."

if gh auth status >/dev/null 2>&1; then
  echo -e "\nGitHub CLI is already authenticated. Skipping..."
  return 0
fi

if [[ -z "$GH_TEMP_TOKEN" ]]; then
  echo -e "\nError: GH_TEMP_TOKEN not defined. Please set it in your environment."
  exit 1
fi

sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli -y -q

echo "$GH_TEMP_TOKEN" | gh auth login -p ssh --skip-ssh-key --with-token
unset GH_TEMP_TOKEN

gh ssh-key add ~/.ssh/id_github_ed25519.pub

gh extension install github/gh-copilot

echo -e "\Github CLI installed and authenticated. SSH key added to GitHub."

clear
