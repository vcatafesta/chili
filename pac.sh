#!/bin/bash
source /usr/share/fetch/core.sh

pkgfilter() {
	IFS=$'\n' read -r -d '' -a cand < \
		<(if ((min_atime || min_mtime)); then
			find "$PWD" -name '*.pkg.tar*.sig' -prune -o \( -name '*.pkg.tar*' -printf '%A@ %T@ %p\n' \) |
				pacsort --files --key 3 --separator ' '
		else
			printf '%s\n' "$PWD"/*.pkg.tar!(*.sig) |
				pacsort --files
		fi |
			pkgfilter "$keep" "$scanarch" "$min_atime" "$min_mtime" \
				"${#whitelist[*]}" "${whitelist[@]}" \
				"${#blacklist[*]}" "${blacklist[@]}")

	candidates+=("${cand[@]}")
}

split() {
	#	str="python-zope-proxy-4.3.5-1-x86_64.chi.zst"
	str="$1"

	block1="${str//-[0-9].*/}"
	block2="${str//${block1}-/}"
	block2="${block2%-*}"
	block3="${block2%%-*}"
	block4="${block2#*-}"
	block5="${str//${block1}-${block2}-/}"
	block5="${block5%%.*}"

	echo "block1:${block1}:"
	echo "block2:${block2}:"
	echo "block3:${block3}:"
	echo "block4:${block4}:"
	echo "block5:${block5}:"
}

while IFS=, read -r fld1 fld2 fld3 fld4 fld5 fld6 fld7 fld8; do
	pkg_name+=("${fld1}")
	pkg_version+=("${fld2}")
	pkg_build+=("${fld3}")
	pkg_fullname+=("${fld4}")
	pkg_dir_fullname+=("${fld5}")
	pkg_name_version+=("${fld6}")
	pkg_size+=("${fld7}")
	pkg_site+=("${fld8}")
done < <(cat /var/cache/fetch/search/packages-installed-split.csv)

info "${pkg_name[*]}"
