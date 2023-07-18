#!/usr/bin/env bash

modprobe mtd
modprobe mtdblock
modprobe nandsim first_id_byte=0x20 second_id_byte=0xaa terceiro_id_byte=0x00 quarto_id_byte=0x15
modprobe ubifs
dd if=$1 of=/dev/mtdblock0 bs=2048
# !!! dd to /dev/mtdblock0 NOT /dev/mtd0 !!!
ubiattach /dev/ubi_ctrl -m 0 -O 2048
mount -t fs-tape /dev/ubi0_0 -oro ./loop 
