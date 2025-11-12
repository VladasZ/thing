#!/bin/bash

sudo pacman -S samba --noconfirm

sudo nano /etc/samba/smb.conf


# [global]
#    workgroup = WORKGROUP
#    server string = ZFS Server
#    netbios name = pc1
#    security = user
#    map to guest = never
#    create mask = 0777
#    directory mask = 0777
#    load printers = no
#    printing = bsd
#    disable spoolss = yes
#
# [raid4TB]
#    path = /mnt/raid4TB
#    valid users = vladas
#    browseable = yes
#    writable = yes
#    read only = no
#    create mask = 0777
#    directory mask = 0777
#    force user = vladas
#    force group = users
# [home]
#    path = /home/vladas
#    valid users = vladas
#    browseable = yes
#    writable = yes
#    read only = no
#    create mask = 0700
#    directory mask = 0700
#    force user = vladas
#    force group = users


sudo smbpasswd -a vladas

sudo pacman -S docker docker-compose --noconfirm
sudo systemctl enable --now docker


# sudo chown -R vladas:users /mnt/raid4TB
# sudo chmod -R 770 /mnt/raid4TB



sudo systemctl start nmb
sudo systemctl enable nmb

sudo systemctl status smb nmb
