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
   ["10-font.sh"]="Font"
   ["11-themes.sh"]="Themes"
   ["12-chrome.sh"]="Chrome"
   ["13-insomnia.sh"]="Insomnia"
   ["14-eza.sh"]="Eza"
   ["15-solaar.sh"]="Solaar"
   ["16-update.sh"]="Update"
   ["17-config.sh"]="Configuration"
)

# Order of scripts to ensure consistent output.
ORDER=(
   "01-zsh.sh"
   "02-neovim.sh"
   "03-nvm_node.sh"
   "04-pyenv.sh"
   "05-go.sh"
   "06-git.sh"
   "07-gh_cli.sh"
   "08-gpg.sh"
   "09-docker.sh"
   "10-font.sh"
   "11-themes.sh"
   "12-chrome.sh"
   "13-insomnia.sh"
   "14-eza.sh"
   "15-solaar.sh"
   "16-update.sh"
   "17-config.sh"
)

echo -e "🔧 Post-installation progress:\n"

# If the script is run from main.sh, show all steps as completed.
# Otherwise, show status based on current script.
if [[ "$CALLER_SCRIPT" == "main.sh" ]]; then
   for script in "${ORDER[@]}"; do
      echo "✅ ${TITLES[$script]}"
   done
   echo -e "\n🎉 All steps completed successfully!"
else
   FOUND_CURRENT=false
   for script in "${ORDER[@]}"; do
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
