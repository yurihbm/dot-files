# ========== Neovim as Default Editor ==========

export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# ========== Go Config ==========

export GOPATH="$HOME/.local/share/go"

# ========== Docker Config ==========

export DOCKER_HOST="unix:///run/user/$UID/docker.sock"
export DOCKER_CONFIG="$HOME/.config/docker"

# ========== NPM Config ==========

export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/.npmrc"
export NPM_CONFIG_INIT_MODULE="$HOME/.config/npm/.npm-init.js"

# ========== Yarn Config ==========

export YARN_GLOBAL_FOLDER="$HOME/.local/share/yarn"
export YARN_ENABLE_TELEMETRY=false

# ========== Secret Environment Variables ==========

if [ -d "$HOME/.local/secrets" ]; then
  for sf in "$HOME/.local/secrets/"*(N); do
    if [ -f "$sf" ]; then
      . "$sf"
    fi
  done
fi
unset sf
