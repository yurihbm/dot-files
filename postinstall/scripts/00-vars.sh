GO_VERSION="1.24.2"
NVM_VERSION="0.40.2"

read -p $'\nEnter Go version (default: '"$GO_VERSION"'): ' -r INPUT_GO_VERSION
GO_VERSION="${INPUT_GO_VERSION:-$GO_VERSION}"

read -p $'\nEnter NVM version (default: '"$NVM_VERSION"'): ' -r INPUT_NVM_VERSION
NVM_VERSION="${INPUT_NVM_VERSION:-$NVM_VERSION}"

read -p $'\nEnter your GitHub personal access token (for gh-cli authentication): ' -r GH_TOKEN
if [[ -z "$GH_TOKEN" ]]; then
  echo "\nError: GitHub token not provided. Exiting..."
  exit 1
fi

read -p $'\nEnter your Git name: ' -r GIT_NAME
read -p $'\nEnter your Git email: ' -r GIT_EMAIL
if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  echo "\nError: Git name or email not provided. Exiting..."
  exit 1
fi

read -p $'\nEnter your GPG (GitHub) passphrase: ' -r GPG_PASSPHRASE
if [[ -z "$GPG_PASSPHRASE" ]]; then
  echo "\nError: GPG passphrase not provided. Exiting..."
  exit 1
fi

read -p $'\nEnter your GPG (GitHub) key title: ' -r GPG_KEY_TITLE
if [[ -z "$GPG_KEY_TITLE" ]]; then
  echo "\nError: GPG key title not provided. Exiting..."
  exit 1
fi

printf "\nGo version: %s\n" "$GO_VERSION"
printf "\nNVM version: %s\n" "$NVM_VERSION"
# Mask GitHub token (show first 1/4, hide 3/4)
GITHUB_TOKEN_MASKED="${GH_TOKEN:0:${#GH_TOKEN}/4}****"
printf "\nGitHub token: %s\n" "$GITHUB_TOKEN_MASKED"
# Mask Git name (hide second half)
GIT_NAME_MASKED="${GIT_NAME:0:${#GIT_NAME}/2}****"
printf "\nGit name: %s\n" "$GIT_NAME_MASKED"
# Mask Git email (show first letter and domain)
GIT_EMAIL_MASKED="${GIT_EMAIL:0:1}****${GIT_EMAIL#*@}"
printf "\nGit email: %s\n" "$GIT_EMAIL_MASKED"
# Mask GPG passphrase (show first 1/4, hide 3/4)
GPG_PASSPHRASE_MASKED="${GPG_PASSPHRASE:0:${#GPG_PASSPHRASE}/4}****"
printf "\nGPG passphrase: %s\n" "$GPG_PASSPHRASE_MASKED"
printf "\nGPG key title: %s\n" "$GPG_KEY_TITLE"

read -p $'\nContinue? (y/n): ' -r
if [[ $REPLY != "y" ]]; then
  echo "Exiting..."
  exit 1
fi

export GO_VERSION
export NVM_VERSION
export GH_TOKEN
export GIT_NAME
export GIT_EMAIL
export GPG_PASSPHRASE
export GPG_KEY_TITLE

