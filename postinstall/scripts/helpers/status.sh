#!/bin/bash

# Caller script name.
CALLER_SCRIPT="$(basename "${BASH_SOURCE[1]}")"

# Titles for each script.
declare -A TITLES=(
    ["01-zsh.sh"]="ZSH"
    ["02-neovim.sh"]="Neovim"
    ["03-nvm_node.sh"]="NVM and Node"
    ["04-pyenv.sh"]="Pyenv"
    ["05-go.sh"]="Go"
    ["06-git.sh"]="Git"
    ["07-gh_cli.sh"]="GitHub CLI"
    ["08-gpg.sh"]="GPG (GitHub)"
    ["09-docker.sh"]="Docker"
    ["10-gnome_extensions.sh"]="GNOME Extensions"
    ["11-icons.sh"]="Icons"
)

echo -e "🔧 Post-installation progress:\n"

# If the script is run from main.sh, show all steps as completed.
# Otherwise, show status based on current script.
if [[ "$CALLER_SCRIPT" == "main.sh" ]]; then
    for script in "${!TITLES[@]}"; do
        echo "✅ ${TITLES[$script]}"
    done
    echo -e "\n🎉 All steps completed successfully!"
else
    FOUND_CURRENT=false
    for script in "${!TITLES[@]}"; do
        label="${TITLES[$script]}"

        if [ "$script" = "$CALLER_SCRIPT" ]; then
            echo "⌛ $label"
            FOUND_CURRENT=true
        elif [ "$FOUND_CURRENT" = false ]; then
            echo "✅ $label"
        else
            echo "⬜ $label"
        fi
    done
fi

