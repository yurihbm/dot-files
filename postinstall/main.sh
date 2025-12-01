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

# Load variables and utility functions.
echo -e "\nStarting post-installation setup...\n"

if [ -d ./scripts ]; then
  for rc in ./scripts/*; do
    if [ -f "$rc" ]; then
      if ! source "$script"; then
        echo "❌ $script failed with exit code $?."
        echo "Installation cannot continue safely. Please fix the error and run again."
        exit 1
      fi
    fi
  done
fi
unset rc

echo -e "\nPost-installation setup completed successfully!"

echo -e "\nRemember to deviate the following buttons/keys on solaar configuration:"
echo " - Mouse: Mouse Gestures and Smart Shift buttons"
echo " - Keyboard: Emoji, Mute Microphone and Voice Dictation keys"

echo -e "\nGnome Extensions to install:"
echo " - Blur my Shell"
echo " - Caffeine"
echo " - Hot Edge"
echo " - Lock Keys"
echo " - Solaar extension"
echo " - System Monitor"
echo " - Quick Settings Tweaks"
echo " - GSConnect"

echo -e "\nWant to change the default shell to zsh?"
read -p $'Do you want to continue? (y/n): ' -r CONTINUE
if [[ $CONTINUE =~ ^[Yy]$ ]]; then
  chsh -s "$(which zsh)"
  echo -e "\nDefault shell changed to zsh."
else
  echo -e "\nSkipping default shell change."
fi

echo -e "\nRestart the system to apply all changes."
