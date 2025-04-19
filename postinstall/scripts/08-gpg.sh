#!/bin/bash

set -e

source ./scripts/helpers/status.sh

echo -e "\nAdding GPG key to GitHub..."

if gpg --list-keys --with-colons "$GIT_EMAIL" >/dev/null 2>&1; then
    echo -e "\nA GPG key for $GIT_EMAIL already exists. Skipping..."
    exit 0
fi

# Generate unique temporary file for key parameters
TEMP_KEYPARAMS=$(mktemp)

# Trap to remove the temporary files on exit
trap 'rm -f "$TEMP_KEYPARAMS" gpgkey.asc' EXIT

# Creating a GPG key for GitHub.
cat >"$TEMP_KEYPARAMS" <<EOF
%echo -e Generating an ECC GPG key
Key-Type: eddsa
Key-Curve: ed25519
Subkey-Type: ecdh
Subkey-Curve: cv25519
Name-Real: ${GIT_NAME}
Name-Email: ${GIT_EMAIL}
Expire-Date: 0
Passphrase: ${GPG_PASSPHRASE}
%commit
%echo -e done
EOF

# Generate the GPG key
gpg --batch --generate-key "$TEMP_KEYPARAMS"
rm keyparams

# Export the GPG key
KEY_ID=$(gpg --list-keys --with-colons "$GIT_EMAIL" | grep '^pub' | cut -d: -f5)
gpg --armor --export "$KEY_ID" > gpgkey.asc

# Add the GPG key to GitHub
gh gpg-key add gpgkey.asc -t "$GPG_KEY_TITLE"

echo -e "\nGPG key added to GitHub. You can now use it for signing commits."

clear

