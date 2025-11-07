#!/bin/bash

set -euxo pipefail

sudo pacman -Suy nushell git base-devel rustup lazygit ncdu alsa-lib starship micro nano helix duf yazi btop unzip gping speedtest-cli --noconfirm

sudo sed -i '/\[multilib\]/,/Include/ s/^#//' /etc/pacman.conf

sudo timedatectl set-ntp true

rustup default stable

mkdir dev

cd dev

# git clone --recursive git@github.com:VladasZ/thing.git
# git clone --recursive git@github.com:VlasdasZ/test-engine.git

git clone https://github.com/VladasZ/thing.git
git clone https://github.com/VladasZ/local.git

chsh -s /usr/bin/nu

rm -f ~/.config/nushell/config.nu
ln -s ~/dev/thing/.shell/config.nu ~/.config/nushell/config.nu

rm -f ~/.config/starship.toml
ln -s ~/dev/thing/.shell/starship.toml ~/.config/starship.toml

ln -s ~/dev/thing/.shell/helix.toml ~/.config/helix/config.toml


rm -f ~/.ssh/config
ln -s ~/dev/thing/.shell/ssh_config ~/.ssh/config
