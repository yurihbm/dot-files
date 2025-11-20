#!/bin/bash

echo -e "\nInstalling Flatpak applications...\n"
flatpak install -y --noninteractive \
  com.belmoussaoui.Authenticator \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  com.google.Chrome \
  com.valvesoftware.Steam \
  hu.irl.cameractrls \
  rest.insomnia.Insomnia \
  io.github.pwr_solaar.solaar \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark
echo -e "\nFlatpak application installation complete.\n"

echo -e "\nSetting GTK theme to Adwaita Dark...\n"
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
echo -e "\nGTK theme set to Adwaita Dark.\n"

echo -e "\nCopying Solaar configuration...\n"
SOLAAR_CONFIG_FOLDER="$HOME/.var/app/io.github.pwr_solaar.solaar/config/solaar"
mkdir -p "$SOLAAR_CONFIG_FOLDER"
cp ../config/solaar/*.yaml "$SOLAAR_CONFIG_FOLDER" -R
sudo cp ../config/solaar/*.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
echo -e "\nSolaar configuration copied.\n"
