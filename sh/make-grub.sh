#!/bin/sh

# Copyright 2013  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Create the 64-bit EFI GRUB binary (bootx64.efi) and the El-Torito boot
# image (efiboot.img) that goes in the /isolinux directory for booting on
# UEFI systems.

# First, build bootx64.efi, which will be installed here in /EFI/BOOT:
grub-mkimage --format=x86_64-efi --output=bootx64.efi --config=grub.cfg --compression=xz --prefix=/EFI/BOOT part_gpt part_msdos fat ext2 hfs hfsplus iso9660 udf ufs1 ufs2 zfs chain linux boot appleldr ahci configfile normal regexp minicmd reboot halt search search_fs_file search_fs_uuid search_label gfxterm gfxmenu efi_gop efi_uga all_video loadbios gzio echo true probe loadenv bitmap_scale font cat help ls png jpeg tga test at_keyboard usb_keyboard

# Then, create a FAT formatted image that contains bootx64.efi in the
# /EFI/BOOT directory.  This is used to bootstrap GRUB from the ISO image.
dd if=/dev/zero of=efiboot.img bs=1K count=1440
# Format the image as FAT12:
mkdosfs -F 12 efiboot.img
# Create a temporary mount point:
MOUNTPOINT=$(mktemp -d)
# Mount the image there:
mount -o loop efiboot.img $MOUNTPOINT
# Copy the GRUB binary to /EFI/BOOT:
mkdir -p $MOUNTPOINT/EFI/BOOT
cp -a bootx64.efi $MOUNTPOINT/EFI/BOOT
# Unmount and clean up:
umount $MOUNTPOINT
rmdir $MOUNTPOINT
# Move the efiboot.img to ../../isolinux:
#mv efiboot.img ../../isolinux
cp efiboot.img /chili/livecd/boot/grub
echo
echo "Done building /EFI/BOOT/bootx64.efi and /isolinux/efiboot.img."
