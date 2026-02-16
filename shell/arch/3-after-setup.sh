#!/bin/bash

set -euxo pipefail

sudo pacman -S nushell git base-devel rustup lazygit ncdu alsa-lib starship micro nano helix duf yazi btop unzip gping speedtest-cli protobuf --noconfirm
sudo pacman -S docker-buildx unzip rsync --noconfirm

sudo sed -i '/\[multilib\]/,/Include/ s/^#//' /etc/pacman.conf

sudo timedatectl set-ntp true

rustup default stable

mkdir dev

cd dev

# git clone --recursive git@github.com:VladasZ/thing.git
# git clone --recursive git@github.com:VlasdasZ/test-engine.git

git clone https://github.com/VladasZ/thing.git

ln -sf ~/dev/thing/shell/config.nu ~/.config/nushell/config.nu

chsh -s /usr/bin/nu
# chsh -s /opt/homebrew/bin/nu
