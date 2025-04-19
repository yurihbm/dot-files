#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nInstalling zsh..."
sudo dnf install zsh -y
echo -e "\nzsh installed."

echo -e "\nInstalling oh-my-zsh..."

if [ -d "$ZSH" ]; then
   echo "oh-my-zsh is already installed. Exiting."
   return 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo -e "\noh-my-zsh installed."

echo -e "\nBacking up .zshrc file..."
cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
echo -e "\nBack up complete."

echo -e "\nSetting zsh as default shell..."
sudo chsh -s $(which zsh) "$USER"
echo -e "Done."

echo -e "\nCopying new .zshrc file..."
cp "../.zshrc" "$HOME/.zshrc"
echo -e "\nDone."

echo -e "\nInstalling plugins (zsh-autosuggestions and zsh-syntax-highlight)..."
ZSH_CUSTOM="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
echo -e "\nPlugins installed."

echo -e "\nInstalling theme (spaceship)..."
[ ! -f "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ] && \
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 && \
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
echo -e "\nTheme installed."

clear

