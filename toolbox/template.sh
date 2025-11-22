# vim: filetype=sh

# ========== Toolbox Container Setup ==========

FILE_TOOLBOX_NAME="_template"

# Check if toolbox name matches
if [ "$TOOLBOX_NAME" != "$FILE_TOOLBOX_NAME" ]; then
  return
fi

# Container-specific environment variables
export XDG_CONFIG_HOME="$TOOLBOX_FOLDER/config"
export XDG_DATA_HOME="$TOOLBOX_FOLDER/data"
export XDG_STATE_HOME="$TOOLBOX_FOLDER/state"
export XDG_CACHE_HOME="$TOOLBOX_FOLDER/cache"
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

# Load additional .zshrc.d scripts
if [ -d $TOOLBOX_FOLDER/.zshrc.d ]; then
  for rc in $TOOLBOX_FOLDER/.zshrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# ========== Oh My Zsh Config ==========

export ZSH="$TOOLBOX_FOLDER/.oh-my-zsh"

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
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Empty string disables the Oh My Zsh themes
ZSH_THEME=""

source $ZSH/oh-my-zsh.sh

# ========== Starship and Mise Initialization ==========

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

# ========== Go Environment Isolation ==========

# 1. GOPATH: Downloaded packages and modules
export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"
# 2. GOCACHE: Build cache
export GOCACHE="$XDG_CACHE_HOME/go-build"

# ========== Neovim as Default Editor ==========
#
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# ========== Aliases ==========

# Git aliases
alias gac="ga -A && gc"
alias gacm="ga -A && gc -m"
alias gaca="ga -A && gc --amend"
alias gll="git pull --all"

# Bash configuration shortcuts
alias global-zsh-config="nvim $HOME/.zshrc"
alias zsh-config="nvim $TOOLBOX_FOLDER/.zshrc"
alias zsh-reload="source $HOME/.zshrc && clear && echo \"🔄 zsh configuration reloaded.\""

# Tmux with custom config
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# PNPM shortcuts
alias pn="pnpm"
alias pnx="pnpx"
