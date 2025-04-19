#!/bin/bash

set -e

source ./scripts/helpers/status.sh

trap 'unset GH_TEMP_TOKEN' EXIT

echo -e "\nInstalling github-cli..."

if [[ -z "$GH_TEMP_TOKEN" ]]; then
echo -e "\nError: GH_TEMP_TOKEN not defined. Please set it in your environment."
  exit 1
fi

sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli -y

echo "$GH_TEMP_TOKEN" | gh auth login -p ssh --skip-ssh-key --with-token
gh ssh-key add ~/.ssh/id_github_ed25519;

gh extension install github/gh-copilot

echo -e "\Github CLI installed and authenticated. SSH key added to GitHub."

clear

