#!/bin/bash
source /usr/share/fetch/core.sh

#output='VGA-1'
#output='DVI-1'
output='DP-1'
#output='HDMI-1'

hmode=('2560' '2560' '1920')
vmode=('1080' '1440' '1440')
ncounter=0

for x in "${hmode[@]}"
do
	modeline=$(cvt "${hmode[ncounter]}" "${vmode[ncounter]}" | grep Modeline | sed 's/Modeline //')
	mode=$(echo "${modeline}" | awk '{print $1}')
   printf "${modeline}\n"
	printf "${mode}\n"
	xrandr --verbose --newmode ${modeline}
	xrandr --verbose --addmode $output $mode
	(( ncounter++ ))
done
