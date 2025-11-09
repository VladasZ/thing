
# yay -Rns spotify wezterm-git deezer gitkraken jetbrains-toolbox docker-desktop unimatrix visual-studio-code-bin freelens-bin vesktop --noconfirm



sudo pacman -Rns nvidia-dkms steam nvidia-utils egl-wayland hyprland meson sddm --noconfirm

yay -S hyprland-git --noconfirm

sudo pacman -Syu hyprland nvidia-dkms steam nvidia-utils egl-wayland meson sddm --noconfirm


yay -Ycc --noconfirm
sudo pacman -Rns $(pacman -Qdtq) --noconfirm # autoremove