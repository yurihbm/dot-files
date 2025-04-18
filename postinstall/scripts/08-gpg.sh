#!/bin/bash

set -e

echo "\nAdding GPG key to GitHub..."

# Creating a GPG key for GitHub.
cat >keyparams <<EOF
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
gpg --batch --generate-key keyparams
rm keyparams

# Export the GPG key
KEY_ID=$(gpg --list-keys --with-colons "$GIT_EMAIL" | grep '^pub' | cut -d: -f5)
gpg --armor --export "$KEY_ID" > gpgkey.asc

# Add the GPG key to GitHub
gh gpg-key add gpgkey.asc -t "$GPG_KEY_TITLE"
rm gpgkey.asc

