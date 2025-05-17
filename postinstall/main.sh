#!/bin/bash

set -e

# Log file setup.
LOG_FILE="postinstall.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Function to handle errors.
error_handler() {
  echo "❌ An error occurred during the post-installation setup."
  echo "Please check the log file at: $LOG_FILE for more details."
}
trap error_handler ERR

# Ask for sudo upfront and cache it.
if ! sudo -v; then
  echo "This script requires sudo privileges to run. Exiting."
  exit 1
fi

# Keep sudo session alive while script runs.
# This runs in background and will keep the sudo session alive.
(while true; do
  sudo -v
  sleep 60
done) &
SUDO_KEEPALIVE_PID=$!

# Checking if the script is run from its own directory.
PUSHED=false
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ "$PWD" != "$SCRIPT_DIR" ]; then
  echo "Script is not being run from its own directory. Changing directory..."
  pushd "$SCRIPT_DIR" >/dev/null
  PUSHED=true
fi

# Function to clean up sudo cache and pop directory.
cleanup() {
  if [ -n "$SUDO_KEEPALIVE_PID" ]; then
    kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
    wait "$SUDO_KEEPALIVE_PID" 2>/dev/null
  fi
  if [ "$PUSHED" = true ]; then
    popd >/dev/null
  fi
}

# Call cleanup on exit.
trap cleanup EXIT

# Load variables.
source ./scripts/00-vars.sh

echo -e "\nStarting post-installation setup...\n"

scripts=(
  "./scripts/01-zsh.sh"
  "./scripts/02-neovim.sh"
  "./scripts/03-nvm_node.sh"
  "./scripts/04-pyenv.sh"
  "./scripts/05-go.sh"
  "./scripts/06-git.sh"
  "./scripts/07-gh_cli.sh"
  "./scripts/08-gpg.sh"
  "./scripts/09-docker.sh"
  "./scripts/10-font.sh"
  "./scripts/11-themes.sh"
  "./scripts/12-chrome.sh"
  "./scripts/13-insomnia.sh"
  "./scripts/14-eza.sh"
  "./scripts/15-solaar.sh"
  "./scripts/16-update.sh"
  "./scripts/17-config.sh"
)

# Run each script in the array.
for script in "${scripts[@]}"; do
  echo "Running $script..."
  if ! source "$script"; then
    echo "⚠️  $script failed with exit code $?. Continuing..."
  fi
done

# Print final status.
source "./scripts/helpers/status.sh"

echo "Remember to deviate the following buttons/keys on solaar configuration:"
echo "Mouse: Mouse Gestures and Smart Shift buttons"
echo "Keyboard: Open Emoji Panel, Mute Microphone and Voice Dictation keys"

# Delete log file if everything succeeded.
rm -f "$LOG_FILE"

exec zsh
