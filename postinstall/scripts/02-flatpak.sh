#!/bin/bash

# ========== Flatpak Applications ==========

echo -e "\nInstalling Flatpak applications...\n"

flatpak install -y --noninteractive \
  com.belmoussaoui.Authenticator \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  com.valvesoftware.Steam \
  hu.irl.cameractrls \
  rest.insomnia.Insomnia \
  io.github.pwr_solaar.solaar \
  io.github.nozwock.Packet \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark

echo -e "\nFlatpak application installation complete.\n"
