clear

echo "Getting necessary variables..."

# Local dir for installation of tools.
LOCAL_DIR="$HOME/.local"
mkdir -p "$LOCAL_DIR"

GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1 | sed 's/go//')
NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

clear

read -p $'Enter your GitHub personal access token (for gh-cli authentication): ' -r GH_TEMP_TOKEN
clear
if [[ -z "$GH_TEMP_TOKEN" ]]; then
  echo -e "\nError: GitHub token not provided. Exiting..."
  exit 1
fi

read -p $'Enter your Git name: ' -r GIT_NAME
clear
if [[ -z "$GIT_NAME" ]]; then
  echo -e "\nError: Git name not provided. Exiting..."
  exit 1
fi

read -p $'Enter your Git email: ' -r GIT_EMAIL
clear
if [[ -z "$GIT_EMAIL" ]]; then
  echo -e "\nError: Git name or email not provided. Exiting..."
  exit 1
fi

read -p $'Enter your GPG (GitHub) passphrase: ' -r GPG_PASSPHRASE
clear
if [[ -z "$GPG_PASSPHRASE" ]]; then
  echo -e "\nError: GPG passphrase not provided. Exiting..."
  exit 1
fi

read -p $'Enter your GPG (GitHub) key title: ' -r GPG_KEY_TITLE
clear
if [[ -z "$GPG_KEY_TITLE" ]]; then
  echo -e "\nError: GPG key title not provided. Exiting..."
  exit 1
fi

printf "\nGo version: %s\n" "$GO_VERSION"
printf "\nNVM version: %s\n" "$NVM_VERSION"
# Mask GitHub token (show first 1/4, hide 3/4).
GITHUB_TOKEN_MASKED="${GH_TEMP_TOKEN:0:${#GH_TEMP_TOKEN}/4}****"
printf "\nGitHub token: %s\n" "$GITHUB_TOKEN_MASKED"
# Mask Git name (hide second half).
GIT_NAME_MASKED="${GIT_NAME:0:${#GIT_NAME}/2}****"
printf "\nGit name: %s\n" "$GIT_NAME_MASKED"
# Mask Git email (show first letter and domain).
GIT_EMAIL_MASKED="${GIT_EMAIL:0:1}****${GIT_EMAIL#*@}"
printf "\nGit email: %s\n" "$GIT_EMAIL_MASKED"
# Mask GPG passphrase (show first 1/4, hide 3/4).
GPG_PASSPHRASE_MASKED="${GPG_PASSPHRASE:0:${#GPG_PASSPHRASE}/4}****"
printf "\nGPG passphrase: %s\n" "$GPG_PASSPHRASE_MASKED"
printf "\nGPG key title: %s\n" "$GPG_KEY_TITLE"

read -p $'\nContinue? (y/n): ' -r
if [[ $REPLY != "y" ]]; then
  echo -e "\nExiting..."
  exit 1
fi
clear

export GO_VERSION
export NVM_VERSION
export GH_TEMP_TOKEN
export GIT_NAME
export GIT_EMAIL
export GPG_PASSPHRASE
export GPG_KEY_TITLE

clear

