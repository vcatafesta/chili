#!/usr/bin/env bash

hd=sdi
DEVICE=/dev/$hd
MAX_SECTORS=$(fdisk -l $DEVICE | head -1 | awk '{print $7}')

function RealocarSectorDefeituoso()
{
	sectors=$(dmesg | grep $hd | grep sector | awk '{print $9}')
	for s in $sectors
	do
		hdparm --yes-i-know-what-i-am-doing --write-sector $s /dev/$hd
	done
}

function WriteOneBadSector()
{
	sector=$1
	hdparm --yes-i-know-what-i-am-doing --write-sector $sector $DEVICE
}

function VerifyOneBadSector()
{
	for count in $(seq 1 100)
	do
	   sector=$1
		if ! hdparm --read-sector $sector $DEVICE &> /dev/null; then
			echo "Failure at sector $sector"
			echo "To fix (relocate) try the following:"
			hdparm --yes-i-know-what-i-am-doing --write-sector $sector $DEVICE
		fi
	   printf "#Pass #$count DEVICE: $DEVICE - READING SECTOR FOR ERRORS : $sector/$sector\r"
	done
}

function VerifyAllBadSector(){
	#for dir in $(seq 1 100)
	#do
	   sector=1
	   while [[ $sector != $MAX_SECTORS ]]  # but it errors if you try and read the last one, so 586072368-1
		do
			if ! hdparm --read-sector $sector $DEVICE &> /dev/null; then
				echo "Failure at sector $sector"
				echo "To fix (relocate) try the following:"
		      echo "sudo hdparm --write-sector $sector --yes-i-know-what-i-am-doing $DEVICE"
				hdparm --yes-i-know-what-i-am-doing --write-sector $sector $DEVICE
			fi
		   printf "DEVICE: $DEVICE - READING SECTOR FOR ERRORS : $sector/$MAX_SECTORS\r"
		   ((++sector))
		done
	#done
}

WriteOneBadSector $*
#VerifyOneBadSector $*
#VerifyAllBadSector

