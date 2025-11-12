#!/bin/bash

yay -S hyprshot wlogout --noconfirm


# Run this inside hyprland
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo
hyprpm reload

# Scaling:
# https://blog.jetbrains.com/platform/2024/07/wayland-support-preview-in-2024-2/



