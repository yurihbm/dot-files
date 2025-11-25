# File and directory listing with eza
alias ls="eza --icons -T -L=1"
alias lt="eza --icons -T"

# Neovim alias for Flatpak installation
alias nvim="flatpak run io.neovim.nvim"

# Git aliases
alias gac="ga -A && gc"
alias gacm="ga -A && gc -m"
alias gaca="ga -A && gc --amend"
alias gll="git pull --all"

# Zsh configuration shortcuts
alias zsh-config="nvim $HOME/.zshrc"
alias zsh-reload="source $HOME/.zshrc && clear && echo \"🔄 Zsh configuration reloaded.\""

# Docker user service management
alias docker-start="systemctl --user start docker"
alias docker-stop="systemctl --user stop docker"
alias docker-restart="systemctl --user restart docker"
alias docker-status="systemctl --user status docker"

# PNPM shortcuts
alias pn="pnpm"
alias pnx="pnpx"
