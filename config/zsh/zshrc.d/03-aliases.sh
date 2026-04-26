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

# GitHub Copilot with permissions
copilot() {
  command copilot \
    --allow-tool='read,
			shell(wc),
			shell(ls),
			shell(find),
			shell(head),
			shell(tail),
			shell(grep),
			shell(git log),
			shell(git diff),
			shell(git status),
			shell(go test),
			shell(go vet),
			shell(bun test),
			shell(bun lint),
			shell(bun format),
			shell(bun typecheck),
			shell(pnpm test),
			shell(pnpm lint),
			shell(pnpm format),
			shell(pnpm typecheck),
			shell(yarn test),
			shell(yarn lint),
			shell(yarn format),
		  shell(yarn typecheck)' \
    "$@"
}
