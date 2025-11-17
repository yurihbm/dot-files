#!/bin/bash

APPS=(
  "com.belmoussaoui.Authenticator"
  "com.discordapp.Discord"
  "com.github.tchx84.Flatseal"
  "com.google.Chrome"
  "com.mattjakeman.ExtensionManager"
  "com.valvesoftware.Steam"
  "hu.irl.cameractrls"
  "rest.insomnia.Insomnia"
  "io.github.pwr_solaar.solaar"
)

flatpak install -y --noninteractive \
  com.belmoussaoui.Authenticator \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  com.google.Chrome \
  com.mattjakeman.ExtensionManager \
  com.valvesoftware.Steam \
  hu.irl.cameractrls \
  rest.insomnia.Insomnia \
  io.github.pwr_solaar.solaar \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
