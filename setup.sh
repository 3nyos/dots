#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Variables
BOOT_PARTITION="/dev/sdX1"
ROOT_PARTITION="/dev/sdX2"
BOOT_LABEL="NIXBOOT"
ROOT_LABEL="NIXROOT"

# Format the partitions
mkfs.vfat -F 32 $BOOT_PARTITION
sudo fatlabel $BOOT_PARTITION $BOOT_LABEL

mkfs.btrfs -L $ROOT_LABEL $ROOT_PARTITION

# Mount the root partition
mount /dev/disk/by-label/$ROOT_LABEL /mnt

# Create Btrfs subvolumes
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/tmp
btrfs subvolume create /mnt/persist
btrfs subvolume create /mnt/home

# Unmount the root partition
umount /mnt

# Mount the tmpfs
mount -t tmpfs -o size=1G,mode=755 tmpfs /mnt

# Create required directories
mkdir -p /mnt/{nix,tmp,persist,home,boot}

# Mount the Btrfs subvolumes
mount -o subvol=nix,noatime /dev/disk/by-label/$ROOT_LABEL /mnt/nix
mount -o subvol=tmp,noatime /dev/disk/by-label/$ROOT_LABEL /mnt/tmp
mount -o subvol=persist,noatime /dev/disk/by-label/$ROOT_LABEL /mnt/persist
mount -o subvol=home,noatime /dev/disk/by-label/$ROOT_LABEL /mnt/home

# Mount the boot partition
mount -o noatime /dev/disk/by-label/$BOOT_LABEL /mnt/boot

echo "Disk setup and mount completed successfully."
