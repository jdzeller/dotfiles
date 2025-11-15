#!/bin/bash

# Partition Disk
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 512MB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart root ext4 512MB 60%
parted /dev/nvme0n1 -- mkpart home ext4 60% 90%
parted /dev/nvme0n1 -- mkpart swap linux-swap 90% 100%

# Format Disk
mkfs.ext4 -L nixos /dev/nvme0n1p2
mkfs.ext4 -L home /dev/nvme0n1p3
mkswap -L swap /dev/nvme0n1p4
mkfs.fat -F 32 -n boot /dev/nvme0n1p1

# Mount root filesystem to /mnt
mount /dev/disk/by-label/nixos /mnt

# Make and Mount /boot filesystem within root filesystem on /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

# Enable swap if needed
# swapon /dev/nvme0n1p2
