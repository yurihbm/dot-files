#!/bin/bash

set -e

# Log file setup
LOG_FILE="postinstall.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Function to handle errors
error_handler() {
    echo "❌ An error occurred during the post-installation setup."
    echo "Please check the log file at: $LOG_FILE for more details."
}
trap error_handler ERR


# Checking superuser privileges
if [ "$EUID" -ne 0 ]; then
    echo -e "This script must be run as root. Attempting to elevate privileges...\n"
    exec sudo -E "$0" "$@"
fi

# Checking if the script is run from its own directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ "$PWD" != "$SCRIPT_DIR" ]; then
    echo "Script is not being run from its own directory. Changing directory..."
    pushd "$SCRIPT_DIR" > /dev/null
fi

# Ensure to return to the original directory
trap 'popd > /dev/null' EXIT

# Load variables
source ./scripts/00-vars.sh

echo -e "\nStarting post-installation setup...\n"

# Execute each script in order
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

echo "✅ Variables"
echo "✅ ZSH"
echo "✅ Neovim"
echo "✅ NVM and Node"
echo "✅ Pyenv"
echo "✅ Go"
echo "✅ Git"
echo "✅ GitHub CLI"
echo "✅ GPG (GitHub)"
echo "✅ Docker"
echo "✅ Gnome Extensions"

echo -e "\nPost-installation setup completed successfully.\n"

# Delete log file if everything succeeded
rm -f "$LOG_FILE"

