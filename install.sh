set -euo pipefail

GO_VERSION="1.24.2"
NVM_VERSION="0.40.2"

echo "\nSpecified go version: $GO_VERSION"
echo "\nSpecified nvm version: $NVM_VERSION"
read -p $'\nContinue? (y/n): ' REPLY
if [ "$REPLY" != "y" ]; then
    echo "Exiting..."
    exit 1
fi

echo "\nInstalling zsh...";
sudo dnf install zsh -y;
echo "zsh installed.";

echo "\nInstalling oh-my-zsh...";
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
echo "oh-my-zsh installed.";

echo "\nBacking up .zshrc file...";
cp ~/.zshrc ~/.zshrc.bak;
echo "Back up complete.";

echo "\nSetting zsh as default shell...";
chsh -s $(which zsh);
echo "Done.";

echo "\nCopying new .zshrc file...";
cp .zshrc ~/.zshrc;
echo "Done.";

echo "\nInstalling plugins (zsh-autosuggestions and zsh-syntax-highlight)...";
[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && \
   git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions";

[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ] && \
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting";
echo "Plugins installed.";

echo "\nInstalling theme (spaceship)...";
[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" ] && \
   git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 && \
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme";
echo "Theme installed.";

echo "\nInstalling neovim...";
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
[ -d "/opt/nvim" ] && sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux-x86_64.tar.gz
echo "neovim installed.";

echo "\nInstalling neovim packages dependencies...";
sudo dnf install ripgrep cmake gcc g++ xclip clang-tools-extra;
echo "Dependencies installed.";

echo "\nCopying neovim config...";
mkdir -p ~/.config;
cp .config/nvim ~/.config/nvim -r;
echo "Configuration copied.";

echo "\nInstalling nvm and latest LTS node...;"
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash;
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm;
nvm install --lts;
corepack enable;
echo "nvm and node installed.";

echo "\nInstalling pyenv...";
curl -fsSL https://pyenv.run | bash;
echo "pyenv installed.";

echo "\nInstalling go...";
wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz";
sudo rm -rf "/usr/local/go" && sudo tar -C "/usr/local" -xzf "go${GO_VERSION}.linux-amd64.tar.gz";
rm -rf "go${GO_VERSION}.linux-amd64.tar.gz";
echo "go installed.";

echo "\nConfiguring git...";
read -p "Enter git user email (also used in GitHub ssh key): " git_email;
read -p "Enter git user name: " git_name;
cd;
mkdir -p ~/.ssh;
echo -ne '~/.ssh/id_github_ed25519\n\n\n' | ssh-keygen -t ed25519 -C "${git_email}";
eval "$(ssh-agent -s)";
ssh-add ~/.ssh/id_github_ed25519;
xclip -sel c < ~/.ssh/id_github_ed25519.pub;
git config --global user.name "${git_name}";
git config --global user.email "${git_email}";
git config --global init.defaultBranch main;
git config --global core.editor "nvim";
echo "git configured. Go to GitHub SSH config page (https://github.com/settings/ssh/new). The key is in the clipboard.";

echo "\nInstalling github-cli...";
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo;
sudo dnf install gh --repo gh-cli;
gh auth login;
echo "github-cli installed and configured.";

echo "\nInstalling Solaar and copying config...";
sudo dnf install solaar -y;
cp .config/solaar/* ~/.config/solaar/ -r;
echo "Solaar installed and configured.";

echo "\nInstalling Docker Engine and setting up rootless mode...";
sudo dnf config-manager addrepo --from-file=https://download.docker.com/linux/fedora/docker.repo;
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin fuse-overlayfs -y;
dockerd-rootless-setuptool.sh install;
echo "Rootless Docker installed. Run 'systemctl --user start docker' to start the service.";

echo "\nInstalling Gnome extensions...";
array=(
   https://extensions.gnome.org/extension/1460/vitals/
   https://extensions.gnome.org/extension/517/caffeine/
   https://extensions.gnome.org/extension/19/user-themes/
   https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/
   https://extensions.gnome.org/extension/3193/blur-my-shell/
   https://extensions.gnome.org/extension/4222/hot-edge/
	https://extensions.gnome.org/extension/6162/solaar-extension/
)
sudo dnf install gnome-shell-extension-appindicator -y;

for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done
echo "Gnome extensions installed.";

echo "\nInstalling whitesur-icon-theme-mod..."
git clone git@github.com:yurihbm/whitesur-icon-theme-mod.git "$HOME/.icons/whitesur-icon-theme-mod";
pushd "$HOME/.icons/whitesur-icon-theme-mod"
./install.sh
popd
echo "whitesur-icon-theme-mod installed. Use Gnome Tweaks to set it up.";

echo "\nFINISHED!";

