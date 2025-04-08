#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install sudo if it's not installed
if ! command -v sudo &> /dev/null; then
    echo "Installing sudo..."
    apt update
    apt install -y sudo
else
    echo "sudo is already installed."
fi

# Create the user 'vladas' if it doesn't exist
if ! id "vladas" &> /dev/null; then
    echo "Creating user vladas..."
    useradd -m -s /bin/bash vladas
    echo "Set password for vladas:"
    passwd vladas
else
    echo "User vladas already exists."
fi

# Add user 'vladas' to the sudo group
usermod -aG sudo vladas
echo "User vladas added to sudoers group."
