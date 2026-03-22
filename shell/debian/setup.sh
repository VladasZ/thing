#!/bin/bash

set -euxo pipefail

sudo apt-get update
sudo apt-get install -y curl unzip ncdu duf btop pkg-config libssl-dev npm

# Install nushell
NUSHELL_VERSION=$(curl -s https://api.github.com/repos/nushell/nushell/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
curl -Lo /tmp/nushell.tar.gz "https://github.com/nushell/nushell/releases/download/${NUSHELL_VERSION}/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/nushell.tar.gz -C /tmp
sudo cp "/tmp/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-gnu/nu" /usr/local/bin/nu
rm -rf /tmp/nushell.tar.gz "/tmp/nu-${NUSHELL_VERSION}-x86_64-unknown-linux-gnu"

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Add nu to /etc/shells if not already present
grep -qxF /usr/local/bin/nu /etc/shells || echo /usr/local/bin/nu | sudo tee -a /etc/shells

# Set nushell as default shell (chsh requires password on GCP, use bashrc workaround)
grep -qxF 'exec /usr/local/bin/nu' ~/.bashrc || echo 'exec /usr/local/bin/nu' >> ~/.bashrc

# Link nushell config
mkdir -p ~/.config/nushell
ln -sf ~/dev/thing/shell/nu/config.nu ~/.config/nushell/config.nu

# Link starship config
ln -sf ~/dev/thing/shell/starship.toml ~/.config/starship.toml

bash ~/dev/thing/shell/common/common-setup.sh
