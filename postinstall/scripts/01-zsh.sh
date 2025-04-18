#!/bin/bash

set -e

echo "\nInstalling zsh..."
sudo dnf install zsh -y
echo "zsh installed."

echo "\nInstalling oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "oh-my-zsh installed."

echo "\nBacking up .zshrc file..."
cp ~/.zshrc ~/.zshrc.bak
echo "Back up complete."

echo "\nSetting zsh as default shell..."
chsh -s $(which zsh)
echo "Done."

echo "\nCopying new .zshrc file..."
cp ../.zshrc ~/.zshrc
echo "Done."

echo "\nInstalling plugins (zsh-autosuggestions and zsh-syntax-highlight)..."
ZSH_CUSTOM="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
echo "Plugins installed."

echo "\nInstalling theme (spaceship)..."
[ ! -f "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ] && \
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 && \
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
echo "Theme installed."
