#!/usr/bin/env bash

# see http://wiki.bitplan.com/index.php/Bad_Block_Howto
# see https://github.com/hradec/fix_smart_last_bad_sector/blob/master/fix_smart_last_bad_sector.sh
# see https://www.thomas-krenn.com/de/wiki/Analyse_einer_fehlerhaften_Festplatte_mit_smartctl
# WF 2020-10-04
disk=/dev/sdd
mode=short
# verbose
verbose=true
# should commands only be shown?
dry=false
# should write fixes be performed?
fix=false
# range of sectors to modify after bad sector
range=8
# set to sudo if sudo is needed
sudo=sudo
# serial number
serial="-?-"

#ansi colors
#http://www.csc.uvic.ca/~sae/seng265/fall04/tips/s265s047-tips/bash-using-colors.html
blue='\033[0;34m'
red='\033[0;31m'
green='\033[0;32m' # '\e[1;32m' is too bright for white bg.
endColor='\033[0m'

#
# a colored message
#   params:
#     1: l_color - the color of the message
#     2: l_msg - the message to display
#
color_msg() {
	local l_color="$1"
	local l_msg="$2"
	echo -e "${l_color}$l_msg${endColor}"
}

#
# error
#
#   show an error message and exit
#
#   params:
#     1: l_msg - the message to display
error() {
	local l_msg="$1"
	# use ansi red for error
	color_msg $red "Error: $l_msg" 1>&2
	exit 1
}

#
# show the usage
#
usage() {
	echo "usage: $0 [disk]"
	echo "   [-c|--check]"
	echo "   [-d|--dry]"
	echo "   [-h|--help]"
	echo "   [-i|--info]"
	echo "   [[-m|--mode] mode]"
	echo "   [[-r|--range] range]"
	echo "   [[-s|--serial [serial]]"
	echo "   [-t|--test]"
	echo "   [[-w|--wait [type]]"
	echo "   [-v|--verbose]"
	echo
	echo "  -h|--help: show this usage"
	echo "  -c|--check: check the disk"
	echo "  -d|--dry:  dry run - show commands only"
	echo "  -i|--info: show info about the given disk"
	echo "  -m|--mode: set mode: default=short"
	echo "  -r|--range: range of sectors to modify after bad sector"
	echo "  -s|--serial: get serial number of confirm serial number"
	echo "  -t|--test: run test for the given type e.g. selective selftest"
	echo "  -w|--wait: wait for the result of the given testype e.g. selective selftest"
	echo "  -v|--verbose: set verbose mode"
	echo ""
	echo "example:"
	echo "   $0 /dev/sdb -i"
	echo ""
	echo "for any write operation you need to confirm the serial number"
	echo "to get serial number: "
	echo "   $0 disk -s "
	exit 1
}

#
# get a number range from 0 to the given n-1
#
# params
#   1: n
getRange() {
	local l_n="$1"
	range=$(python -c "for i in range($l_n): print i,")
	echo $range
}

#
# read the result of the smartctl test for the given disk
#
# params
#   1: l_disk: the disk under test e.g. /dev/sdb
#   2: l_type: the type of the test e.g. selective
function readResult() {
	local l_disk="$1"
	local l_type="$2"
	$sudo smartctl -l $l_type $l_disk | egrep "^#?[[:space:]]*[0-9]"
}

#
# show the Result
#
function showResult() {
	local l_logline="$1"
	local l_logstatus="$2"
	if [ "$verbose" == "true" ]; then
		echo $l_logstatus:$l_logline
	else
		echo $l_logline | gawk '
    /#/ {
      print $0; exit
    }
    { 
       status=substr($4,1,9)
       progress=$5;
       gsub("\\[","",progress);
       range=$7 
       printf("\r%s",progress);
     }'
	fi
}

#
# wait for the result of a running selftest
#
# param 1: l_disk: the disk under test e.g. /dev/sdb
# param 2: l_type: the type of the test e.g. selective
# param 3: l_wait: number of seconds to wait
#
function waitForResult() {
	# example
	#=== START OF READ SMART DATA SECTION ===
	#SMART Selective self-test log data structure revision number 1
	#SPAN  MIN_LBA     MAX_LBA  CURRENT_TEST_STATUS
	#         1  7814037167  Self_test_in_progress [90% left] (2564632-2630167)
	local l_disk="$1"
	local l_type="$2"
	local l_wait="$3"
	local l_logline=""
	local l_logstatus=""
	color_msg $blue "Waiting for $l_type test of $l_disk to stop (each dot is $l_wait sec)"
	while [ "$l_logstatus" != "Completed" ]; do
		l_logline=$(readResult "$l_disk" "$l_type" | egrep "^#?[[:space:]]*1")
		l_logstatus=$(echo $l_logline | gawk ' /Completed/ { print "Completed"; }')
		showResult "$l_logline" "$l_logstatus"
		sleep $l_wait
	done
}

#
# get the serial number of the device
#
function getSerialNumber() {
	local l_disk="$1"
	serial=$($sudo smartctl -i $l_disk | grep "Serial Number" | cut -f 2 -d':')
	echo $serial
}

#
# get the blocksize of the given file system
#
function getBlockSize() {
	local l_fs="$1"
	blocksize=$($sudo tune2fs -l $l_fs | grep "Block size:" | cut -f2 -d':')
	echo $blocksize
}

#
# get the partition for the given disk
#
function getPartition() {
	local l_disk="$1"
	fs=$(mount | grep $l_disk | cut -f1 -d' ')
	echo $fs
}

#
# get the start sector for the given disk
#
function getStartSector() {
	local l_disk="$1"
	local l_fs="$2"
	startsector=$($sudo fdisk -l $l_disk | grep $l_fs | cut -f4 -d' ')
	echo $startsector
}

#
# get Info about the given disk
#
function getInfo() {
	local l_disk="$1"
	$sudo smartctl -i $l_disk | egrep "(Model|Serial|Rotation|Sector|Capacity)"
	$sudo hdparm -I $l_disk | egrep "(Serial Number|Model)"
	fs=$(getPartition $l_disk)
	if [ "$fs" != "" ]; then
		color_msg $blue "Partition:        $fs"
		blocksize=$(getBlockSize $fs)
		color_msg $blue "Blocksize:        $blocksize"
	else
		color_msg $red "couldn't find mounted partition for $l_disk"
	fi
}

#
# geh the current pending sector for the given disk
#
function getCurrentPendingSector() {
	local l_disk="$1"
	# if msg is empty don't show message but only return the current pending sector count
	local l_msg="$2"
	psectorline=$($sudo smartctl -A $l_disk | grep Current_Pending_Sector)
	psector=0
	if [ $? -eq 0 ]; then
		if [ "$l_msg" != "" ]; then color_msg $green "$psectorline"; fi
		psector=$(echo $psectorline | cut -f 10 -d ' ')
		if [ $psector -gt 0 ]; then
			if [ "$l_msg" != "" ]; then color_msg $red "Current_Pending_Sector is not zero but $psector"; fi
		else
			if [ "$l_msg" != "" ]; then color_msg $green "Current_Pending_Sector is zero!"; fi
		fi
	else
		if [ "$l_msg" != "" ]; then color_msg $red "smartctl -A did not output Current_Pending_Sector"; fi
		psector=-1
	fi
	if [ "$l_msg" == "" ]; then echo $psector; fi
}

#
# fix the given bad sector on the given disk with the given range of sectors to fix
#
# param 1: disk e.g. /dev/sdb1
# param 2: defect sector to repair
# param 3: range - range of sectors to repair e.g. 8
#
fixBad() {
	local l_disk="$1"
	local l_sector="$2"
	local l_range="$3"
	color_msg $blue "repairing sector $l_sector to $l_sector+$l_range on $l_disk ..."
	r=$(getRange $l_range)
	for i in $r; do
		let b1=$l_sector+$i
		if [ "$dry" == "true" ]; then
			echo hdparm --repair-sector $b1 --yes-i-know-what-i-am-doing $l_disk
		else
			$sudo hdparm --repair-sector $b1 --yes-i-know-what-i-am-doing $disk >>/tmp/smart_repaired.log
		fi
	done
	#tail -n 60 /tmp/smart_repaired.log | grep writing | tail -n 20
	#grep '#' /tmp/smart | head -5
	#hdparm -I $disk > /tmp/hdparm
}

#
# check the needed software
#
checkSoftware() {
	for sw in gawk debugfs fdisk hdparm smartctl tune2fs python $sudo; do
		bin=$(which $sw)
		if [ $? -eq 0 ]; then
			if [ "$verbose" == "true" ]; then
				color_msg $green "will use $bin as $sw"
			fi
		else
			error "$0 needs $sw to work please install it"
		fi
	done
}

#
# run a test for the given disk in the given mode
#
# params
#   1: l_disk: the disk under test e.g. /dev/sdb
#   2: l_mode: the mode of the self test e.g. short/long
function runTest() {
	local l_disk="$1"
	local l_mode="$2"
	color_msg $blue "running $l_mode smartctl test for $l_disk ..."
	$sudo smartctl -t $l_mode $l_disk >/tmp/null
}

#
# check the given disk in the given mode
#
function checkDisk() {
	local l_disk="$1"
	local l_mode="$2"
	local l_serial="$3"
	fs=$(getPartition $l_disk)
	blocksize=$(getBlockSize $fs)
	startsector=$(getStartSector $l_disk $fs)
	color_msg $blue "checking Current_Pending_Sector count for $l_disk partition $fs blocksize $blocksize startsector $startsector"
	getCurrentPendingSector "$l_disk" show
	psector=$(getCurrentPendingSector "$l_disk")
	if [ $psector -gt 0 ]; then
		runTest $l_disk $l_mode
	fi
}

#
# check the lba block
#
function lbaCheck() {
	local l_disk="$1"
	fs=$(getPartition $l_disk)
	blocksize=$(getBlockSize $fs)
	startsector=$(getStartSector $l_disk $fs)
	diskserial=$(getSerialNumber $l_disk)
	readResult "$l_disk" selftest | while read line; do
		echo $line | grep "read failure" >/dev/null
		if [ $? -eq 0 ]; then
			if [ "$verbose" == "true" ]; then
				echo $line
			fi
			index=$(echo $line | cut -f2 -d' ')
			state=$(echo $line | cut -f3-4 -d ' ')
			progress=$(echo $line | cut -f8 -d ' ')
			lba=$(echo $line | cut -f10 -d ' ')
			if [ "$lba" == "" ]; then
				lba=0
			fi
			if [ "$lba" -gt 0 ]; then
				echo $index $state
				echo "progress:  $progress"
				echo "lba: $lba"
				# calculate the file system block
				fsb=$(gawk -v L=$lba -v S=$startsector -v B=$blocksize 'BEGIN {printf ("%.0f",((L-S)*512/B))}')
				echo "file system block: $fsb"
				if [ "$fix" == "true" ]; then
					if [ "$serial" != "$diskserial" ]; then
						color_msg $red "you need to provide the serial number of $l_disk to perform fix operations"
					else
						fixBad $l_disk $lba $range
					fi
				fi
			fi
		fi
	done
}

#
# try Fixing bad sectors
#
function tryFix() {
	local l_disk="$1"
	badsect=$($sudo smartctl -l selective ${baddrive} | gawk '/# 1  Selective offline   Completed: read failure/ {print $10}')
	[ $badsect = "-" ] && exit 0

	echo Attempting to fix sector $badsect on $baddrive
	echo hdparm --repair-sector ${badsect} --yes-i-know-what-i-am-doing $baddrive
}

#
# start a check loop on the given drive
#
function checkLoop() {
	local baddrive="$1"
	badsect=1
	while true; do
		color_msg $blue "Testing $baddrive from LBA $badsect"
		$sudo smartctl -t select,${badsect}-max ${baddrive} 2>&1 >>/dev/null
		waitForResult $baddrive selective 5
		tryFix $baddrive
		color_msg $blue "running next test"
	done
}

# make sure the needed software is available
checkSoftware
# commandline option
while [ "$1" != "" ]; do
	option=$1
	shift
	case $option in
	-h | --help)
		usage
		;;
	-i | --info)
		getInfo $disk
		;;
	-m | --mode)
		if [ $# -lt 1 ]; then
			usage
		else
			mode=$1
			shift
		fi
		;;
	-c | --check)
		checkDisk $disk $mode $serial
		;;
	-d | --dry)
		dry=true
		;;
	-l | --loop)
		checkLoop $disk
		;;
	-f | --fix)
		fix=true
		;;
	-r | --range)
		if [ $# -lt 1 ]; then
			usage
		else
			range=$1
			shift
		fi
		;;
	-s | --serial)
		if [ $# -lt 1 ]; then
			getSerialNumber $disk
			exit 1
		else
			serial=$1
			shift
		fi
		;;
	-t | --test)
		runTest $disk $mode
		;;
	-v | --verbose)
		verbose=true
		;;
	-w | --wait)
		if [ $# -lt 1 ]; then
			usage
		else
			type=$1
			shift
			waitForResult $disk $type 5
		fi
		;;
	-x)
		lbaCheck $disk $serial
		;;
	*)
		disk=$option
		;;
	esac
done
