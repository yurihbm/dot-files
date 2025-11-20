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
  "./scripts/01-bash.sh"
  "./scripts/02-flatpak.sh"
  "./scripts/03-font.sh"
  "./scripts/04-theme.sh"
  "./scripts/05-git.sh"
  "./scripts/06-eza.sh"
  "./scripts/07-gnome.sh"
  "./scripts/08-toolbox.sh"
)

# Run each script in the array.
for script in "${scripts[@]}"; do
  echo "Running $script..."
  if ! source "$script"; then
    echo "⚠️  $script failed with exit code $?. Continuing..."
  fi
done

echo "Remember to deviate the following buttons/keys on solaar configuration:"
echo " - Mouse: Mouse Gestures and Smart Shift buttons"
echo " - Keyboard: Emoji, Mute Microphone and Voice Dictation keys"

echo "Gnome Extensions to install:"
echo " - Blur my Shell"
echo " - Caffeine"
echo " - Hot Edge"
echo " - Lock Keys"
echo " - Solaar extension"
echo " - System Monitor"
echo " - GSConnect"

echo "You can use tbx-create <container_name> to create new toolbox containers."
echo "Use tbx-remove <container_name> to remove them."

echo "Restart the system to apply all changes."

# Delete log file if everything succeeded.
rm -f "$LOG_FILE"
