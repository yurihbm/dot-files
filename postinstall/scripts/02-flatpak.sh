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

NEOVIM_APP_ID="io.neovim.nvim"
NEOVIM_RUNTIME=$(flatpak info "$NEOVIM_APP_ID" --show-runtime | awk -F/ '{print $3}')
NODE_VERSION=24
NODE_EXT_ID="org.freedesktop.Sdk.Extension.node${NODE_VERSION}"
GO_EXT_ID="org.freedesktop.Sdk.Extension.golang"
RUST_EXT_ID="org.freedesktop.Sdk.Extension.rust-stable"
RUST_SDK_ENV="/usr/lib/sdk/rust-stable/enable.sh"

flatpak install -y --noninteractive \
  ${NODE_EXT_ID}//${NEOVIM_RUNTIME} \
  ${GO_EXT_ID}//${NEOVIM_RUNTIME} \
  ${RUST_EXT_ID}//${NEOVIM_RUNTIME}

# Configure environment to keep host clean
flatpak override --user "$NEOVIM_APP_ID" --env=FLATPAK_ENABLE_SDK_EXT="node${NODE_VERSION},golang,rust-stable"
flatpak override --user "$NEOVIM_APP_ID" --talk-name=org.freedesktop.Flatpak

# Go
flatpak override --user "$NEOVIM_APP_ID" --env=GOPATH=$HOME/.var/app/$NEOVIM_APP_ID/data/go
flatpak override --user "$NEOVIM_APP_ID" --env=GOBIN=$HOME/.var/app/$NEOVIM_APP_ID/data/go/bin
flatpak override --user "$NEOVIM_APP_ID" --env=GOCACHE=$HOME/.var/app/$NEOVIM_APP_ID/cache/go

# Rust
flatpak override --user "$NEOVIM_APP_ID" --env=CARGO_HOME=$HOME/.var/app/$NEOVIM_APP_ID/data/cargo

# Node
flatpak override --user "$NEOVIM_APP_ID" --env=npm_config_prefix=$HOME/.var/app/$NEOVIM_APP_ID/data/npm
flatpak override --user "$NEOVIM_APP_ID" --env=npm_config_cache=$HOME/.var/app/$NEOVIM_APP_ID/cache/npm

# Update PATH
flatpak override --user "$NEOVIM_APP_ID" --env=PATH=/app/bin:/usr/bin:$HOME/.var/app/$NEOVIM_APP_ID/data/go/bin:$HOME/.var/app/$NEOVIM_APP_ID/data/cargo/bin:$HOME/.var/app/$NEOVIM_APP_ID/data/npm/bin

echo -e "\nNeovim Flatpak extensions installation complete.\n"

echo -e "\nInstalling Neovim system dependencies...\n"

flatpak run --command=sh "$NEOVIM_APP_ID" -c "
  if [ -f $RUST_SDK_ENV ]; then
    # Source the enable script to activate the Rust environment
    . $RUST_SDK_ENV
    echo 'Rust environment activated.'

    echo 'Installing ripgrep...'
    cargo install ripgrep

    echo 'Installing fd-find...'
    cargo install fd-find

    echo 'Installation complete.'
  else
    echo 'Error: Rust SDK environment file not found at $RUST_SDK_ENV.'
    echo 'Please ensure org.freedesktop.Sdk.Extension.rust-stable is installed.'
    exit 1
  fi
"

echo -e "\nNeovim system dependencies installation complete.\n"

echo -e "\nSetting up Neovim script in user local bin...\n"

# bin/nvim path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NEOVIM_SCRIPT_SOURCE="$SCRIPT_DIR/../../bin/nvim"
NEOVIM_SCRIPT_TARGET="$HOME/.local/bin/nvim"

mkdir -p "$HOME/.local/bin"
cp "$NEOVIM_SCRIPT_SOURCE" "$NEOVIM_SCRIPT_TARGET"
chmod +x "$NEOVIM_SCRIPT_TARGET"

echo -e "\nNeovim script setup complete.\n"

echo -e "\nFlatpak application installation complete.\n"
