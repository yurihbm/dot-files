#!/bin/bash

set -e

echo "\nInstalling Gnome extensions..."
declare -a array=(
   https://extensions.gnome.org/extension/1460/vitals/
   https://extensions.gnome.org/extension/517/caffeine/
   https://extensions.gnome.org/extension/19/user-themes/
   https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/
   https://extensions.gnome.org/extension/3193/blur-my-shell/
   https://extensions.gnome.org/extension/4222/hot-edge/
   https://extensions.gnome.org/extension/6162/solaar-extension/
)
sudo dnf install gnome-shell-extension-appindicator -y
for i in "${array[@]}"; do
    EXTENSION_ID=$(curl -s "$i" | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm -f ${EXTENSION_ID}.zip
done
echo "Gnome extensions installed."

