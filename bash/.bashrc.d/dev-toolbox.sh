#!/bin/bash

# Check if toolbox name matches
if [ "$TOOLBOX_NAME" != "dev-toolbox" ]; then
  return
fi

eval "$(starship init bash)"

# ========== Aliases ==========

# Neovim as default code editor
alias code="nvim"

# Bash configuration shortcuts
alias bash-config="code ~/.bashrc"
alias bash-reload='source ~/.bashrc && clear'

# Tmux with custom config
alias tmux="tmux -f ~/.config/tmux/tmux.conf"

# PNPM shortcuts
alias pn="pnpm"
alias pnx="pnpx"
