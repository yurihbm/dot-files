#!/bin/bash

set -e

echo "\nInstalling whitesur-icon-theme-mod..."
git clone git@github.com:yurihbm/whitesur-icon-theme-mod.git "$HOME/.icons/whitesur-icon-theme-mod"
cd "$HOME/.icons/whitesur-icon-theme-mod"
./install.sh
cd -
echo "whitesur-icon-theme-mod installed. Use Gnome Tweaks to set it up."

