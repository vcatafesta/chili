#!/usr/bin/bash

aPKGSPLIT=()
pkg_ext='.chi.zst'
pkg_re='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst'
: ${aPKGSPLIT=()}
: ${aPKGLIST=}
: ${PKG_FOLDER_DIR=0}
: ${PKG_FULLNAME=1}
: ${PKG_ARCH=2}
: ${PKG_BASE=3}
: ${PKG_BASE_VERSION=4}
: ${PKG_VERSION=5}
: ${PKG_BUILD=6}

function die(){
	local msg=$1; shift
   printf "%s %s\n" "$msg" "$@" >&2
	exit 1
}

sh_splitpkg(){
	local file=${1}
	local pkg_folder_dir=$(echo ${file%/*})
	local pkg_fullname=$(echo ${file##*/})
	local	pkg_base=
	local	pkg_version_build=
	local	pkg_version=
	local	pkg_build=
	local	pkg_arch=
	local	pkg_base_version=

	[[ $pkg_fullname =~ $pkg_re ]] &&
		pkg_fullname=${BASH_REMATCH[0]}
		pkg_base=${BASH_REMATCH[1]}
		pkg_version_build=${BASH_REMATCH[2]}
		pkg_version=${BASH_REMATCH[3]}
		pkg_build=${BASH_REMATCH[4]}
		pkg_arch=${BASH_REMATCH[5]}
		pkg_base_version=${pkg_base}-${pkg_version_build}

	aPKGSPLIT=($pkg_folder_dir $pkg_fullname $pkg_arch $pkg_base $pkg_base_version $pkg_version $pkg_build)
	return $?
}

init(){
	local AllFilesPackages=
	local AllFilteredPackages=
	local arr=
	local array=
	local nfiles=0
	local	pkgNumber=0
	local pkg=
	local pkgInAll=
	local pkg_base=
	local pkg_search=
	local candidates=()
	local cachedirs=("/var/cache/fetch/archives")
	local cachedir

	for cachedir in "${cachedirs[@]}"
	do
		[[ -d $cachedir ]]            || die "Error: cachedir '$cachedir' does not exist or is not a directory"
		pushd "$cachedir" &>/dev/null || die "Error: failed to chdir to $cachedir"

		AllFilesPackages=$(find "$PWD" -type f -name "*.chi.zst" | sort)
		arr=(${AllFilesPackages[*]})

		if [[ ${#arr[*]} -lt 1 ]]; then
			die "NO candidate packages found for pruning"
		fi

		for pkgInAll in $AllFilesPackages
		do
			((pkgNumber++))
			sh_splitpkg ${pkgInAll}
			pkg_base=${aPKGSPLIT[$PKG_BASE]}
			AllFilteredPackages=$(find "$PWD" -type f -name "$pkg_base*.zst" | grep -E "*$pkg_base-([0-9])" | sort)

 			arr=(${AllFilteredPackages[*]})
 			array=("${AllFilteredPackages[*]}")
		  	nfiles=${#arr[*]}

			if [[ $nfiles -gt 1 ]]; then
				while read -r pkg; do
					sh_splitpkg ${pkg}
					pkg_search=${aPKGSPLIT[$PKG_BASE]}

					if [[ "${pkg_search:1:1}" > "${pkg_base:1:1}" ]]; then
						break
					fi

					if [[ "${pkg_base}" =~ "${pkg_search}" ]] && [[ "$(vercmp $pkgInAll $pkg)" -lt 0 ]]; then
						printf "%s\n" "${pkgInAll}"
						candidates+=("${pkgInAll}")
					fi
				done < <(printf '%s\n' "$array")
			fi
		done
		popd >/dev/null 2>&1
	done

	if (( ! ${#candidates[*]} )); then
		die "NO packages found for pruning\n"
	fi
}

init $*
