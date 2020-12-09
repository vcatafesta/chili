#!/usr/bin/bash

if [ -p /dev/stdin ]; then
	#for FILE in "$@" /dev/stdin
	for FILE in /dev/stdin
	do
		while IFS= read -r LINE
		do
			echo "$@" "$LINE"   #print line argument and stdin
		done < "$FILE"
	done
else
	printf "[ -p /dev/stdin ] is false\n"
	#dosomething
fi

