#!/bin/bash

# Check if a swap file already exists
if [ -f /swapfile ]; then
    echo "Swap file already exists. Exiting..."
    exit 1
fi

# Allocate space for the swap file
sudo fallocate -l 4G /swapfile

# Set appropriate permissions
sudo chmod 600 /swapfile

# Set up the swap area
sudo mkswap /swapfile

# Enable the swap
sudo swapon /swapfile

# Make the swap permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Display the new swap status
sudo swapon --show
