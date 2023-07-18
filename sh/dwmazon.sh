#!/usr/bin/env bash
source /etc/bashrc

array=('base-devel' 'base' 'dev-tools' 'extras' 'fonts' 'games' 'i3' 'libs' 'multimedia' 'net' 'qt5' 'sec' 'themes' 'wayland' 'wm' 'xapp' 'xfce4' 'xorg-drivers' 'xorg')

for index in "${array[@]}"
do
	pkg=$(curl http://mazonos.com/packages/$index/ | cut -d'"' -f2 | grep ".mz$"| cut -d- -f1)
	for i in $pkg
	do
		dw $i
	done
done
