FILE_TOOLBOX_NAME="_template"

# Check if toolbox name matches
if [ "$TOOLBOX_NAME" != "$FILE_TOOLBOX_NAME" ]; then
  return
fi

CONTAINER_ROOT="$TOOLBOX_ENVS_FOLDER/$FILE_TOOLBOX_NAME"

export XDG_CONFIG_HOME="$CONTAINER_ROOT/config"
export XDG_DATA_HOME="$CONTAINER_ROOT/data"
export XDG_STATE_HOME="$CONTAINER_ROOT/state"
export XDG_CACHE_HOME="$CONTAINER_ROOT/cache"

mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

export HISTFILE="$XDG_STATE_HOME/bash_history"
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Initialize starship prompt and mise environment
eval "$(starship init bash)"
eval "$(mise activate bash)"

# ========== Go Environment Isolation ==========

# 1. GOPATH: Downloaded packages and modules
export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"
# 2. GOCACHE: Build cache
export GOCACHE="$XDG_CACHE_HOME/go-build"

# ========== Neovim as default editor ==========
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# ========== Aliases ==========

# Bash configuration shortcuts
alias global-bash-config="nvim $HOME/.bashrc"
alias bash-config="nvim $TOOLBOX_FOLDER/.bashrc"
alias bash-reload="source $HOME/.bashrc && clear && echo \"🔄 Bash configuration reloaded.\""

# Tmux with custom config
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# PNPM shortcuts
alias pn="pnpm"
alias pnx="pnpx"
