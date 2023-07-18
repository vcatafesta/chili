#!/bin/sh
source /etc/bashrc

function RemoveOldPackages()
{
	local nfiles=0
	#pkgtar=$(ls -1 |sed 's/\// /g'|awk '{print $NF}'|sed 's/.chi.\|zst\|xz//g'|sed 's/1://g'|sed 's/2://g')
	AllFilesPackages=$(ls -1 *.zst)

	for pkgInAll in $AllFilesPackages
	do
		FilteredPackages=$(echo $pkgInAll | cut -d\- -f1)
		AllFilteredPackages=$(ls -1 $FilteredPackages*.zst)
		nfiles=0

		for y in ${AllFilteredPackages[*]}
		do
			((nfiles++))
		done

		log_info_msg "Verifying package $pkgInAll"
		if [[ $nfiles > 1 ]]; then
			for pkg in $AllFilteredPackages
			do
				if [[ "$(vercmp $pkgInAll $pkg)" -lt 0 ]]; then
					rm $pkgInAll*
				elif [[ "$(vercmp $pkgInAll $pkg)" -gt 0 ]]; then
					continue
				elif [[ "$(vercmp $pkgInAll $pkg)" -eq 0 ]]; then
					continue
				fi
			done
		fi
		evaluate_retval
	done
}

RemoveOldPackages
