#!/usr/bin/awk -f

BEGIN {
	a= "Gnu/Linux Darwin/macOS Microsoft/Windows"
	split(a, array, " ")
	print array[0]
	print array[1]
	print array[2]
}
