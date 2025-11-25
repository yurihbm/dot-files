export ZSH="$HOME/.config/.oh-my-zsh"

# Detection logic
if [ ! -d "$ZSH" ]; then
  echo "Oh My Zsh not found. Installing..."

  mkdir -p "$ZSH"

  # Using --unattended to avoid prompts and preventing shell switch
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  echo "\nInstalling plugins..."

  local ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$ZSH/custom}"
  # Zsh syntax highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting
  # Zsh autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions

  echo "\nInstallation complete."
fi

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Empty string disables the Oh My Zsh themes
ZSH_THEME=""

source $ZSH/oh-my-zsh.sh
