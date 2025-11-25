# ========== Starship and Mise Initialization ==========

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
