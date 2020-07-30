#!/bin/sh

choosepartitiondialog(){
	# escolha a particao a ser instalada // Choose install partition
	################################################################
	#partitions=( $(blkid | cut -d: -f1 | sed "s/$/ '*' /") )
	partitions=( $(fdisk -l | sed -n /sd[a-z][0-9]/p | sed "s/$/ '*' /") )
	#partitions=( $(fdisk -l | sed -n /sd[a-z][0-9]/p | awk '{print $1,$5}') )
	part=$(dialog \
	--clear \
	--no-collapse \
	--tab-correct \
	--menu 'Choose partition for installation ChiliOS:'	\
	0 0 0 "${partitions[@]}" 2>&1 >/dev/tty )
}

choosepartitionwhiptail(){
	# escolha a particao a ser instalada // Choose install partition
	################################################################
	#partitions=( $(blkid | cut -d: -f1 | sed "s/$/ '*' /"))
	#partitions=( $(fdisk -l | sed -n /sd[a-z][0-9]/p | sed "s/$/ '*' /"))
	partitions=( $(fdisk -l | sed -n /sd[a-z][0-9]/p | awk '{print $1,$5}'))
	part=$(whiptail \
	--menu 'Choose partition for installation ChiliOS:'	\
	0 0 0 "${partitions[@]}" 2>&1 >/dev/tty )
}

choosepartitionwhiptail
#choosepartitiondialog

