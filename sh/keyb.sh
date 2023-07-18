#!/bin/bash

#keymaps=$(find /usr/share/kbd/keymaps/ -iname "*.map.gz" | cut -d/ -f7 | sed 's/.map.gz//g'| sort)
keymaps=$(localectl list-keymaps)
array=()
for i in ${keymaps[@]}
      do
         array[((n++))]="$i"
         array[((n++))]="$i"
      done

keyboard=$(dialog \
	--title     'Ajust keyboard layout:' \
	--colors \
	--backtitle 'Ajust keyboard layout:' \
	--menu      'Choose you keyboard:' 0 0 20 \
	"${array[@]}" 2>&1 >/dev/tty)

if [ -n "$keyboard" ]; then
	echo "teclado carregado: $keyboard"
#	loadkeys $keyboard
	localectl set-keymap $keyboard
fi
printf "$(localectl status)\n"

