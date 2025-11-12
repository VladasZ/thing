#!/bin/bash

sudo pacman -Suy nvidia-dkms nvidia-utils --noconfirm
sudo pacman -Suy vulkan-intel lib32-vulkan-intel mesa lib32-mesa --noconfirm

let file = "/etc/modprobe.d/nvidia.conf"

"options nvidia NVreg_EnableGpuFirmware=0
options nvidia_drm modeset=1 fbdev=1" | sudo tee /etc/modprobe.d/nvidia.conf

sudo mkinitcpio -P

cat /etc/modprobe.d/nvidia.conf

lspci -k | grep -A 3 VGA

sudo dmesg | grep nvi
modprobe nvidia -vv
