#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nImporting configs..."

cp ../.config/solaar/* "$HOME/.config/solaar/"

cp -r "../.config/tmux" "$HOME/.config/tmux"

dconf load / <"../gnome/config.conf"

clear
