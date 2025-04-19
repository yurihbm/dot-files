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


# Ask for sudo upfront and cache it
if ! sudo -v; then
   echo "This script requires sudo privileges to run. Exiting."
   exit 1
fi

# Keep sudo session alive while script runs
# This runs in background and will keep the sudo session alive
( while true; do sudo -v; sleep 60; done ) &
SUDO_KEEPALIVE_PID=$!

# Checking if the script is run from its own directory
PUSHED=false
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ "$PWD" != "$SCRIPT_DIR" ]; then
   echo "Script is not being run from its own directory. Changing directory..."
   pushd "$SCRIPT_DIR" > /dev/null
   PUSHED=true
fi

# Function to clean up the background sudo process and return to the original
# directory
cleanup() {
   if [ -n "$SUDO_KEEPALIVE_PID" ]; then
      kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
      wait "$SUDO_KEEPALIVE_PID" 2>/dev/null
   fi   
   if [ "$PUSHED" = true ]; then
      popd > /dev/null
   fi
}

# Ensure to return to the original directory
trap cleanup EXIT

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

echo -e "\n✅ Post-installation steps completed:"
printf " - %-25s %s\n" "Variables" "✅"
printf " - %-25s %s\n" "ZSH" "✅"
printf " - %-25s %s\n" "Neovim" "✅"
printf " - %-25s %s\n" "NVM and Node" "✅"
printf " - %-25s %s\n" "Pyenv" "✅"
printf " - %-25s %s\n" "Go" "✅"
printf " - %-25s %s\n" "Git" "✅"
printf " - %-25s %s\n" "GitHub CLI" "✅"
printf " - %-25s %s\n" "GPG (GitHub)" "✅"
printf " - %-25s %s\n" "Docker" "✅"
printf " - %-25s %s\n" "Gnome Extensions" "✅"

# Delete log file if everything succeeded
rm -f "$LOG_FILE"

