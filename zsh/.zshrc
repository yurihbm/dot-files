# vim: filetype=sh

# ========== Toolbox environment setup ==========

export TOOLBOX_ENVS_FOLDER="$HOME/.toolbox-envs"
export TOOLBOX_TEMPLATE_FOLDER="$TOOLBOX_ENVS_FOLDER/_template"

if [ -f /run/.toolboxenv ]; then
  export TOOLBOX_NAME=$(awk -F= '$1 == "name" { sub(/^"/, "", $2); sub(/"$/, "", $2); print $2 }' /run/.containerenv)
  export TOOLBOX_FOLDER="$TOOLBOX_ENVS_FOLDER/$TOOLBOX_NAME"
  . "$TOOLBOX_FOLDER/.zshrc"
fi

# ========== Global Environment Setup ==========

if [ -d ~/.zshrc.d ]; then
  for rc in ~/.zshrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export GPG_TTY=$(tty)
