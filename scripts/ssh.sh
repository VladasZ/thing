#!/bin/bash

# Set variables
SSH_DIR="$HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"
PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWOhiJRcgD6k6zR1mB2ODwR1XkxU8aYQxe69APtoADN 146100@gmail.com\n"

# Create .ssh directory if it doesn't exist
if [ ! -d "$SSH_DIR" ]; then
    mkdir "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    echo "Created $SSH_DIR and set permissions to 700."
fi

# Create authorized_keys file if it doesn't exist
if [ ! -f "$AUTH_KEYS" ]; then
    touch "$AUTH_KEYS"
    chmod 600 "$AUTH_KEYS"
    echo "Created $AUTH_KEYS and set permissions to 600."
fi

# Check if the key is already in authorized_keys
if grep -Fxq "$PUB_KEY" "$AUTH_KEYS"; then
    echo "Public key already exists in authorized_keys."
else
    echo "$PUB_KEY" >> "$AUTH_KEYS"
    chmod 600 "$AUTH_KEYS"  # Just to be sure
    echo "Public key added to authorized_keys."
fi
