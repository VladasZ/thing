#!/bin/bash

mkdir .config/hypr
ln -sf ~/dev/thing/.shell/.alacritty.toml ~/.alacritty.toml
ln -sf ~/dev/thing/.shell/hyprland.conf ~/.config/hypr/hyprland.conf
yay -S hyprshot wlogout --noconfirm


# Run this inside hyprland
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo
hyprpm reload

# Scaling:
# https://blog.jetbrains.com/platform/2024/07/wayland-support-preview-in-2024-2/



