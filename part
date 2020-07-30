#!/bin/bash

sd=/dev/sdc

function police(){
    echo "................_@@@__"
    echo "..... ___//___?____\________"
    echo "...../--o--POLICE------@} ...."
}

function inkey(){
    #read -rsp $'Press enter to continue...\n'
    #read -rsp $'Press escape to continue...\n' -d $'\e'
    #read -rsp $'Press any key to continue...\n' -n 1 key
    # echo $key
    #read -rp $'Are you sure (Y/n) : ' -ei $'Y' key;
    # echo $key
    #read -rsp $'Press any key or wait 5 seconds to continue...\n' -n 1 -t 5;
    #read -rst 0.5; timeout=$?
    # echo $timeout
    #read -rsp $'' -n 1 -t 5;
    #read -n1 -r -p "" lastkey ; timeout=$?
    read -t "$1" -n1 -r -p "" lastkey
}

function sh_partitions(){
    array=($(fdisk -l $sd           \
    | grep "$sd[0-9]"               \
    | awk '{print $1,$5,$6,$7}'     \
    | sed 's/ /_/'g                 \
    | sed 's/.//10'                 \
    | sed 's/./& /9'))
}

function arraylen(){
    #arraylength=${#array[@]}
    arraylength=${#"$1"[@]}
}

function fontedialog(){
	array=()
	n=0
    y=0
    typesize=($(fdisk -l -o device,type,size | sed -n '/sd[a-z][0-9]/'p | sed 's/ /_/g'))
    devices=($(fdisk -l -o Device|sed -n '/sd[a-z][0-9]/'p))
    partitions=($(fdisk -l |sed -n '/sd[a-z][0-9]/'p|awk '{printf "%0s [%0s]__%0s_%0s\n", $1,$5,$7,$6}'))

     for i in ${devices[@]}
     do
         array[((n++))]=$i
         array[((n++))]=${typesize[((y++))]}
     done

    echo arraylen array
    #inkey 5
    #sh_partitions
	sd=($(dialog     														\
				--backtitle	 	"1"						 					\
				--cancel-label 	"Cancelar"										\
				--menu 			"Escolha a fonte com enter:" 0 65 15 "${array[@]}" 2>&1 >/dev/tty 	))

	exit_status=$?
	case $exit_status in
		1)
			exit 1
			;;
		255)
			exit 0
			;;
	esac
	if [ $sd <> 0 ]; then
		setfont $sd
	fi
}
police
fontedialog
