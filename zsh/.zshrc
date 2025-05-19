# vim: filetype=sh

# Environment variables
export LOCAL_DIR="$HOME/.local"
export GO_LOCATION="$LOCAL_DIR/go"
export GOPATH="$GO_LOCATION/workspace"
export DOCKER_HOST="unix:///run/user/$UID/docker.sock"
export LC_MESSAGES="en_US.UTF-8"

# Load local secrets

# Secrets DIR (.env files location).
SECRETS_DIR="$HOME/.local/secrets"

if [ -d "$SECRETS_DIR" ]; then
  for env_file in "$SECRETS_DIR"/*.env; do
    if [ -f "$env_file" ]; then
      source "$env_file"
    fi
  done
fi

# Path configuration
EZA_BIN="$LOCAL_DIR/eza/bin"
NVIM_BIN="$LOCAL_DIR/nvim-linux-x86_64/bin"
GO_BIN="$GO_LOCATION/bin:$GOPATH/bin"
export PATH="$PATH:$NVIM_BIN:$GO_BIN:$GOPATH:$EZA_BIN"

# Path oh-my-zsh installation.
export ZSH="$LOCAL_DIR/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Theme configuration
ZSH_THEME="spaceship"

export SPACESHIP_NODE_SYMBOL=" "
export SPACESHIP_GOLANG_SYMBOL=" "
export SPACESHIP_DIR_TRUNC=1
export SPACESHIP_TIME_SHOW=always
export SPACESHIP_USER_SHOW=always
export SPACESHIP_HOST_SHOW=always
export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  venv
  node
  python
  golang
  git
  exit_code
  exec_time
  line_sep
  char
)

# ZSH plugins
plugins=(
  git
  docker
  tmux
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Make Home and End keys work with tmux and nvim.
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line

# Load user defined aliases and functions.
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_functions ] && source ~/.zsh_functions

# NVM
export NVM_DIR="$LOCAL_DIR/nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Load SSH keys
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s) >/dev/null 2>&1

  # Add ssh keys here:
  ssh-add ~/.ssh/id_github_ed25519 >/dev/null 2>&1
fi

# Load GPG keys
export GPG_TTY=$(tty)

# uv
. "$HOME/.local/uv/env"
