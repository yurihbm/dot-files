#!/bin/bash

echo -e "\nImporting GNOME settings..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dconf load / <"$SCRIPT_DIR/../../gnome/config.ini"

echo -e "\nGNOME settings import complete.\n"
