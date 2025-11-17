clear

echo "First you should enable third party repositories through the Programs app."
read -p $'Do you want to continue? (y/n): ' -r CONTINUE
if [[ ! $CONTINUE =~ ^[Yy]$ ]]; then
  echo -e "\nExiting..."
  exit 1
fi

echo "Getting necessary variables..."

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

export GIT_NAME
export GIT_EMAIL
