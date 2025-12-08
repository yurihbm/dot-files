export ZSH="$HOME/.config/.oh-my-zsh"

# Detection logic
if [ ! -d "$ZSH" ]; then
  echo "Oh My Zsh not found. Installing..."

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
  dnf
  docker
  docker-compose
  eza
  git
  gpg-agent
  mise
  starship
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# eza plugin config
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes

source $ZSH/oh-my-zsh.sh
