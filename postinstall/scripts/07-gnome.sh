#!/bin/bash

echo -e "\nImporting GNOME settings..."

dconf load / <../gnome/config.ini

echo -e "\nGNOME settings import complete.\n"
