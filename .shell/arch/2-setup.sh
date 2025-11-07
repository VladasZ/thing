#!/bin/bash

set -euxo pipefail

#!!! cat /etc/fstab !!!

ln -sf /usr/share/zoneinfo/Europe/Vilnius /etc/localtime
hwclock --systohc
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo pc1 > /etc/hostname

pacman -Syu --noconfirm

bootctl install

ls /boot/

tee /boot/loader/loader.conf > /dev/null <<EOF
default  arch.conf
timeout  2
console-mode max
editor   no
EOF

tee /boot/loader/entries/arch.conf > /dev/null <<EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=a7f9e36b-651c-4679-ab36-7f604a87a986 rw
EOF

pacman -S dhcpcd openssh sudo --noconfirm

passwd

cd ~/

useradd -m -G wheel vladas
passwd vladas
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config


cat > /home/vladas/setup.sh << 'EOF'
#!/bin/bash

set -euxo pipefail

sudo systemctl enable dhcpcd
sudo systemctl start dhcpcd
sudo systemctl enable sshd
sudo systemctl start sshd

mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHkmISFq/mUIiQcdYMVLadaS2ajdfpMNob3CtCl/s0c vladas" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
EOF

chmod +x /home/vladas/setup.sh

exit

# reboot
