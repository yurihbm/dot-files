#!/bin/bash

# ========== Flatpak Applications ==========

echo -e "\nInstalling Flatpak applications...\n"
flatpak install -y --noninteractive --user \
  com.belmoussaoui.Authenticator \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  com.google.Chrome \
  com.valvesoftware.Steam \
  hu.irl.cameractrls \
  rest.insomnia.Insomnia \
  io.github.pwr_solaar.solaar \
  io.neovim.nvim \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark
echo -e "\nFlatpak application installation complete.\n"
