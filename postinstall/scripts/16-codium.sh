#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling VSCodium..."

if command -v codium >/dev/null 2>&1; then
  echo "Solaar is already installed. Skipping..."
  return 0
fi

sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg

printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/yum.repos.d/vscodium.repo

sudo dnf install codium -y -q

echo -e "\nVSCodium installed."

clear
