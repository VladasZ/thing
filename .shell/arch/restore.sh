#!/bin/bash

set -euxo pipefail

DISK="/dev/sdb"

mount "${DISK}3" /mnt
mount --mkdir "${DISK}1" /mnt/boot

arch-chroot /mnt
