#!/usr/bin/bash

source /chili/core.sh

function sh_splitpkgawk()
{
	static_pkg_base=($(awk -F'#' '{ print $1 }' /var/cache/fetch/search/packages-split))
	static_pkg_version=($(awk -F'#' '{ print $2 }' /var/cache/fetch/search/packages-split))
	static_pkg_build=($(awk -F'#' '{ print $3 }' /var/cache/fetch/search/packages-split))
	static_pkg_fullname=($(awk -F'#' '{ print $4 }' /var/cache/fetch/search/packages-split))
	static_pkg_dirfullname=($(awk -F'#' '{ print $5 }' /var/cache/fetch/search/packages-split))
	static_pkg_size=($(awk -F'#' '{ print $6 }' /var/cache/fetch/search/packages-split))

	main_arr=(
		static_pkg_base[@]
		static_pkg_version[@]
		static_pkg_build[@]
		static_pkg_fullname[@]
		static_pkg_dirfullname[@]
		static_pkg_size[@]
	)
	lenarray=${#main_arr[*]}
	count=${#static_pkg_base[*]}

#	info $lenarray
#	echo "${!main_arr[0]}"
#	echo "${!main_arr[1]}"
#	echo "${!main_arr[2]}"
	for ((i=0; i<=$count; i++))
	do
		for ((x=0; x<=$lenarray; x++))
		do
			printf ":${!main_arr[x]:$i:1}"
		done
		echo
	done
}

sh_splitpkgawk
