#!/bin/bash

local str="Learn-to-Split-a-String-in-Bash-Scripting"
local str="a52python-zope-component-4.6.2-1"
local str="linux_firmware-20190514-1"
local pkg_base=
local nconta=0
local char
local ra
local re

IFS='-' 								# hyphen (-) is set as delimiter
read -ra ADDR <<< "$str" 		# str is read into an array as tokens separated by IFS
for var in "${ADDR[@]}"; do 	# access each element of array
	re='[a-zA-Z]'
	if [[ "$var" =~ $re ]]; then
		echo "$var: Entered string matches."
		char='-'
		pkg_base="$pkg_base${var}$char"
		echo "${pkg_base%-*}"
	else
		re='[0-9]'
		if [[ "$var" =~ $re ]]; then
			echo "$var: Entered string does not match";
			((nconta++))
			if [[ nconta -eq 1 ]]; then
				pkg_version=$var
				echo "pkg_version: $pkg_version"
			else
				pkg_build=$var
				echo "pkg_build: $pkg_build"
			fi
		fi
	fi
done
IFS=' ' # reset to default value after usage
echo
pkg_base=${pkg_base%-*}
pkg_version="${pkg_version}-${pkg_build}"
pkg_base_version="${pkg_base}-${pkg_version}"
echo "pkg_base         : ${pkg_base}"
echo "pkg_base_version : ${pkg_base_version}"
echo "pkg_version      : ${pkg_version}"
echo "pkg_build        : ${pkg_build}"

