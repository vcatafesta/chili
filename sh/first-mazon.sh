#!/bin/bash
###############################################
#  first login Mazon OS - version 1.0         #
#                                             #
#  @utor: Diego Sarzi <diegosarzi@gmail.com>  #
#  created: 2019/02/26 licence: MIT           #
###############################################

#var=`find /usr/share/keymaps/ -name "*.map.gz"`
#keymaps=($var)
#keymaps=($(cat temp))
#echo ${keymaps[0]}
#sleep 10

keymaps=(a '' b '' c '' d '')
char=('' '' '' '')

keyboard=$(dialog --clear \
			--backtitle 'Ajust keyboard layout:' \
			--menu 'Choose you keyboard:' 0 0 0 \
			"${keymaps[@]}" 2>&1 >/dev/tty  )

if [ ! -z "$keyboard" ]; then
	loadkeys $keyboard
fi

# echo first login
echo -e "\n*****************************"
echo -e "First Login: \nuser: root password: root \n" 


# remove script
# rm -f /etc/rc.d/rc3.d/S1000first


