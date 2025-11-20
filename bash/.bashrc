# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export TOOLBOX_ENVS_FOLDER="$HOME/.toolbox-envs"
export TOOLBOX_TEMPLATE_FOLDER="$TOOLBOX_ENVS_FOLDER/_template"

if [ -f /run/.toolboxenv ]; then
  export TOOLBOX_NAME=$(awk -F= '$1 == "name" { sub(/^"/, "", $2); sub(/"$/, "", $2); print $2 }' /run/.containerenv)
  export TOOLBOX_FOLDER="$TOOLBOX_ENVS_FOLDER/$TOOLBOX_NAME"
  . "$TOOLBOX_FOLDER/.bashrc"
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

export GPG_TTY=$(tty)
