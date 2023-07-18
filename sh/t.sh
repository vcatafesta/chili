#!/bin/bash
source /etc/bashrc

cfiles=$(ls -1 *.zst)
for var in $cfiles
do
		temp=$(echo $var|sed 's/\(.*\)-\(.*-\)/\1*\2/' |cut -d* -f1)
		echo $temp
done
