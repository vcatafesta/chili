#!/usr/bin/env bash
source /etc/bashrc

dep=('qt5_base' 'qt5_declarative' 'pulseaudio' 'gst_plugin_base')

echo "############################################################################"
echo ${dep[*]}
echo "############################################################################"
echo "Qtde Elementos: " ${#dep[*]}
echo "############################################################################"
echo "Ultimo elemento: " ${dep[@]: -1}
echo "############################################################################"

for i in ${dep[*]}
do
	echo $i
done

deps=$(grep ^depend -i .PKGINFO | cut -d= -f2 | sed "s/\"//g")
#info $deps

for i in ${deps[*]}
do
	echo $i
done
