# Environment variables
export LOCAL_DIR="$HOME/.local"
export GO_LOCATION="$LOCAL_DIR/go"
export GOPATH="$GO_LOCATION/workspace"
export PYENV_ROOT="$LOCAL_DIR/pyenv"
export DOCKER_HOST="unix:///run/user/1000/docker.sock"

# Path configuration
PYENV_BIN="$PYENV_ROOT/bin"
EZA_BIN="$LOCAL_DIR/eza/bin"
NVIM_BIN="$LOCAL_DIR/nvim-linux-x86_64/bin"
GO_BIN="$GO_LOCATION/bin:$GOPATH/bin"
export PATH="$PATH:$NVIM_BIN:$GO_BIN:$GOPATH:$PYENV_BIN:$EZA_BIN"

# Path oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
   zsh-syntax-highlighting
   zsh-autosuggestions
   docker
   tmux
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Make Home and End keys work with tmux and nvim
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line

# Aliases
alias zsh-config="nvim ~/.zshrc"
alias gac="ga -A && gc"
alias gacm="ga -A && gc -m"
alias gaca="ga -A && gc --amend"
alias gll="git pull --all"
alias explorer="explorer.exe ."
alias ls="eza --icons -T -L=1"
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
alias docker-start="systemctl --user start docker"
alias docker-stop="systemctl --user stop docker"
alias docker-restart="systemctl --user restart docker"
alias docker-status="systemctl --user status docker"
alias ce="gh copilot explain"
alias cs="gh copilot suggest"

# Functions
# Load environment variables from file
load-env-file() {
	local env_file="$1"
	if [ -f "$env_file" ]; then
		export $(grep -v '^#' $env_file | xargs -d '\n')
	fi
}
# Unset environment variables from file
unset-env-file() {
	local env_file="$1"
	if [ -f "$env_file" ]; then
		unset $(grep -v '^#' $env_file | sed -E 's/(.*)=.*/\1/' | xargs)
	fi
}

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

# Pyenv
eval "$(pyenv init - zsh)"

# Load SSH keys
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` > /dev/null 2>&1

  # Add ssh keys here:
  ssh-add ~/.ssh/id_github_ed25519 > /dev/null 2>&1
fi

# Load GPG keys
export GPG_TTY=$(tty)

