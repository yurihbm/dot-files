#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling Gnome extensions..."

# Check if necessary commands are available
for cmd in curl jq wget gnome-extensions; do
   if ! command -v "$cmd" &>/dev/null; then
      echo -e "\nError: $cmd is not installed. Please install it and try again."
      exit 1
   fi
done

# Extension URLs
declare -a array=(
   https://extensions.gnome.org/extension/1460/vitals/
   https://extensions.gnome.org/extension/517/caffeine/
   https://extensions.gnome.org/extension/19/user-themes/
   https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/
   https://extensions.gnome.org/extension/3193/blur-my-shell/
   https://extensions.gnome.org/extension/4222/hot-edge/
   https://extensions.gnome.org/extension/6162/solaar-extension/
)

# Install gnome-shell-extension-appindicator using DNF for fedora specific versions
sudo dnf install gnome-shell-extension-appindicator -y -q

# Create temporary directory for downloads
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

for i in "${array[@]}"; do
   EXTENSION_ID=$(curl -s "$i" | grep -oP 'data-uuid="\K[^"]+')
   if [ -z "$EXTENSION_ID" ]; then
      echo -e "\nError: Failed to fetch extension ID from $i. Skipping..."
      continue
   fi

   if gnome-extensions list | grep --quiet "$EXTENSION_ID"; then
      echo -e "\nExtension $EXTENSION_ID is already installed. Skipping..."
      continue
   fi

   VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max' || echo -e "")
   if [ -z "$VERSION_TAG" ]; then
      echo -e "\nError: Failed to fetch version tag for $EXTENSION_ID. Skipping..."
      continue
   fi

   wget -O "$TEMP_DIR/${EXTENSION_ID}.zip" "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
   gnome-extensions install --force "$TEMP_DIR/${EXTENSION_ID}.zip"
   if ! gnome-extensions list | grep --quiet "$EXTENSION_ID"; then
      busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s "$EXTENSION_ID"
   fi
   gnome-extensions enable "$EXTENSION_ID"
done

echo -e "\nGnome extensions installed."

clear
