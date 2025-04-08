#!/bin/bash

# Check if a swap file already exists
if [ -f /swapfile ]; then
    echo "Swap file already exists. Exiting..."
    exit 1
fi

# Allocate space for the swap file
fallocate -l 4G /swapfile

# Set appropriate permissions
chmod 600 /swapfile

# Set up the swap area
mkswap /swapfile

# Enable the swap
swapon /swapfile

# Make the swap permanent
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# Display the new swap status
swapon --show
