#!/bin/bash

set -e

echo "\n✅ Variables"
echo "\n✅ ZSH"
echo "\n✅ Neovim"
echo "\n✅ NVM and Node"
echo "\n✅ Pyenv"
echo "\n✅ Go"
echo "\n✅ Git"
echo "\n✅ GitHub CLI"

echo "\nAdding GPG key to GitHub..."

# Generate unique temporary file for key parameters
TEMP_KEYPARAMS=$(mktemp)

# Trap to remove the temporary files on exit
trap 'rm -f "$TEMP_KEYPARAMS" gpgkey.asc' EXIT

# Creating a GPG key for GitHub.
cat >"$TEMP_KEYPARAMS" <<EOF
%echo Generating an ECC GPG key
Key-Type: eddsa
Key-Curve: ed25519
Subkey-Type: ecdh
Subkey-Curve: cv25519
Name-Real: ${GIT_NAME}
Name-Email: ${GIT_EMAIL}
Expire-Date: 0
Passphrase: ${GPG_PASSPHRASE}
%commit
%echo done
EOF

# Generate the GPG key
gpg --batch --generate-key "$TEMP_KEYPARAMS"
rm keyparams

# Export the GPG key
KEY_ID=$(gpg --list-keys --with-colons "$GIT_EMAIL" | grep '^pub' | cut -d: -f5)
gpg --armor --export "$KEY_ID" > gpgkey.asc

# Add the GPG key to GitHub
gh gpg-key add gpgkey.asc -t "$GPG_KEY_TITLE"

clear

