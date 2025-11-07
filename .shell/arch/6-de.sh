#!/bin/bash

sudo pacman -Suy egl-wayland hyprland meson cpio cmake --noconfirm
sudo pacman -S nautilus gvfs gvfs-smb --noconfirm
sudo pacman -Suy ttf-freefont ttf-dejavu ttf-sazanami ttf-0xproto-nerd --noconfirm
sudo pacman -S alacritty kitty firefox transmission-qt  kubectl ansible wofi --noconfirm
sudo pacman -S ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick --noconfirm # for yazi
sudo pacman -S vlc vlc-plugin-ffmpeg --noconfirm


sudo mkdir -p /opt/homebrew/bin
sudo ln -sf /usr/bin/nu /opt/homebrew/bin/nu

sudo systemctl enable systemd-resolved --now

let config = [
    "[Resolve]"
    $"DNS=1.1.1.1"
    "FallbackDNS=8.8.8.8 9.9.9.9"
    "DNSSEC=yes"
] | str join "\n"

echo $config | sudo tee /etc/systemd/resolved.conf | ignore

sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved

sudo pacman -Suy --noconfirm
sudo pacman -S steam telegram-desktop --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S spotify deezer gitkraken jetbrains-toolbox docker-desktop unimatrix visual-studio-code-bin freelens-bin --noconfirm
yay -S vesktop --noconfirm # Discord

sudo pacman -Suy sddm --noconfirm

sudo systemctl enable sddm.service
sudo systemctl start sddm.service
