#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

#!/bin/bash
set -e
image=${1:?Supply the .iso image of a Gentoo installation medium}
target=${2:?Supply the target device}

echo Checking for the necessary tools presence...
which syslinux
which sfdisk
which mkfs.vfat

echo Mounting Gentoo CD image...
cdmountpoint=/mnt/gentoo-cd
mkdir -p "$cdmountpoint"
trap 'echo Unmounting Gentoo CD image...; umount "$cdmountpoint"' EXIT
mount -o loop,ro "$image" "$cdmountpoint"

echo Creating a disk-wide EFI FAT partition on "$target"...
echo ',,U,*' | sfdisk --wipe always "$target"

echo Installing syslinux MBR on "$target"...
#dd if=/usr/share/syslinux/mbr.bin of="$target"
dd if=/usr/lib/syslinux/mbr.bin of="$target"
sleep 1

echo Creating file system on "$target"p1...
mkfs.vfat "$target"p1 -n GENTOO

echo Mounting file system...
mountpoint=/mnt/gentoo-usb
mkdir -p "$mountpoint"
mount "$target"p1 "$mountpoint"

echo Copying files...
cp -r "$cdmountpoint"/* "$mountpoint"/
mv "$mountpoint"/isolinux/* "$mountpoint"
mv "$mountpoint"/isolinux.cfg "$mountpoint"/syslinux.cfg
rm -rf "$mountpoint"/isolinux*
mv "$mountpoint"/memtest86 "$mountpoint"/memtest
sed -i -e "s:cdroot:cdroot slowusb:" -e "s:kernel memtest86:kernel memtest:" "$mountpoint"/syslinux.cfg

echo Unmounting file system...
umount "$mountpoint"

echo Installing syslinux on "$target"p1
syslinux "$target"p1

echo Syncing...
sync

echo 'Done!'
