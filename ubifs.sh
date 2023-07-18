#!/usr/bin/env bash

[ $# -ne 1 ] && { echo not system.img provided, exit.; exit 0; }

sudo umount `pwd`/system
sudo rmmod ubifs
sudo rmmod ubi
sudo rmmod nandsim
sudo rmmod mtdblock

sudo modprobe mtdblock
sudo modprobe nandsim first_id_byte=0xec second_id_byte=0xd5 third_id_byte=0x51 fourth_id_byte=0xa6
#see different nandsim from here http://www.linux-mtd.infradead.org/faq/nand.html#L_nand_nandsim
sudo modprobe ubi

sudo dd if=$1 of=/dev/mtdblock0 bs=2048
sudo ubiattach /dev/ubi_ctrl -m 0 -O 4096
[ $? != 0 ] && { echo attach to device error; exit 0; }
sudo mkdir -p system
sudo mount /dev/ubi0_0 `pwd`/system

[ $? -eq 0 ] && echo successfully extract $1 to `pwd`/system

#use dmesg to see these parameters
#sudo mkfs.ubifs -m 4096 -e 253952 -c 2300 -r system system1.img
#ubinize -o system2.img -p 262144 -m 4096 -s 1024 -O 4096 tmp.cfg
#tmp.cfg
#[ubifs]
#mode=ubi
#image=system1.img
#vol_id=0
#vol_size=248MiB
#vol_type=dynamic
#vol_name=system
#vol_alignment=1
#vol_flags=autoresize
#system.img: HIT archive data
