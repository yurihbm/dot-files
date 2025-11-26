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
  io.neovim.nvim \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark

echo -e "\nInstalling Neovim extensions for Flatpak...\n"

# Get neovim runtime
NEOVIM_RUNTIME=$(flatpak info io.neovim.nvim --show-runtime | awk -F/ '{print $3}')
NODE_VERSION=24
NODE_EXT_ID="org.freedesktop.Sdk.Extension.node${NODE_VERSION}"
GO_EXT_ID="org.freedesktop.Sdk.Extension.golang"

flatpak install -y --noninteractive \
  ${NODE_EXT_ID}//${NEOVIM_RUNTIME} \
  ${GO_EXT_ID}//${NEOVIM_RUNTIME}
sudo flatpak override io.neovim.nvim --env=FLATPAK_ENABLE_SDK_EXT="node${NODE_VERSION},golang"
sudo flatpak override io.neovim.nvim --talk-name=org.freedesktop.Flatpak

echo -e "\nNeovim Flatpak extensions installation complete.\n"

echo -e "\nFlatpak application installation complete.\n"
