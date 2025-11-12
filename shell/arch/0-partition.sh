#!/bin/bash

set -euxo pipefail

# fdisk -l

DISK="/dev/sdb"

fdisk "${DISK}" <<EOF
g
n
1

+1G
n
2

+16G
n
3


w
EOF

mkfs.fat -F 32 "${DISK}1"
mkswap "${DISK}2"
mkfs.ext4 "${DISK}3"

mount "${DISK}3" /mnt
mount --mkdir "${DISK}1" /mnt/boot
swapon "${DISK}2"

pacstrap -K /mnt base linux linux-firmware linux-headers intel-ucode
