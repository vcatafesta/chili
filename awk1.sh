#!/usr/bin/bash

awk '{ print }' /etc/passwd
awk '{ print $0 }' /etc/passwd
awk '{ print "Vilmar" }' /etc/passwd
awk -F":" '{ print $1 }' /etc/passwd
awk -F":" '{ print $1 " " $3 }' /etc/passwd
awk -F":" '{ print "username: " $1 "\t\tuid:" $3 }' /etc/passwd

awk 'BEGIN { OFS = "|" ; ORS = "\n" } { print $1, $2 }' marks.txt
awk '{ printf "%-10s %s\n", $1, $2 }' marks.txt

size_to_human() {
	awk -v size="$1" '
	BEGIN {
		suffix[1] = "B"
		suffix[2] = "KiB"
		suffix[3] = "MiB"
		suffix[4] = "GiB"
		suffix[5] = "TiB"
		suffix[6] = "PiB"
		suffix[7] = "EiB"
		count = 1

		while (size > 1024) {
			size /= 1024
			count++
		}

		sizestr = sprintf("%.2f", size)
		sub(/\.?0+$/, "", sizestr)
		printf("%s %s", sizestr, suffix[count])
	}'
}

totalsaved=10240000000000
echo "$(size_to_human "$totalsaved")"

awk 'BEGIN {
	x="1.01"
	x=x+1
	print x
	{ print ($1^2)+1 }
}'

