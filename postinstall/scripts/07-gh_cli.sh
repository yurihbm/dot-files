#!/bin/bash

set -e

echo "\nInstalling github-cli..."

if [[ -z "$GH_TOKEN" ]]; then
echo "Error: GH_TOKEN not defined. Please set it in your environment."
  exit 1
fi

sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli -y

echo "$GH_TOKEN" | gh auth login -p ssh --skip-ssh-key --with-token
gh ssh-key add ~/.ssh/id_github_ed25519;
echo "github-cli installed and configured."

