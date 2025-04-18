#!/bin/bash

set -e

source ./scripts/00-vars.sh

echo "\nStarting post-installation setup...\n"

./scripts/01-zsh.sh
./scripts/02-neovim.sh
./scripts/03-nvm_node.sh
./scripts/04-pyenv.sh
./scripts/05-go.sh
./scripts/06-git.sh
./scripts/07-gh_cli.sh
./scripts/08-gpg.sh
./scripts/09-docker.sh
./scripts/10-gnome_extensions.sh
./scripts/11-icons.sh

echo "\nPost-installation setup completed successfully.\n"
