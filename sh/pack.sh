#!/usr/bin/bash

#########################################################################
 # fetchpack - A flexible cache cleaning utility in ChiliOS
 #
 # Created: 2020/10/05
 # Altered: 2020/12/07
 #
 # Copyright (c) 2019 - 2020, Vilmar Catafesta <vcatafesta@gmail.com>
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions
 # are met:
 # 1. Redistributions of source code must retain the above copyright
 #    notice, this list of conditions and the following disclaimer.
 # 2. Redistributions in binary form must reproduce the above copyright
 #    notice, this list of conditions and the following disclaimer in the
 #    documentation and/or other materials provided with the distribution.
 # 3. The name of the copyright holders or contributors may not be used to
 #    endorse or promote products derived from this software without
 #    specific prior written permission.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 # ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 # LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 # PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
 # HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 # SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 # LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 # DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 # THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#########################################################################

export LC_ALL="pt_BR.utf8"
declare -r myname='fetchpack'
declare -r myver='1.0.9-20201207'
declare    delim=$'\n' keep=3 movedir= scanarch=
declare    USE_COLOR='y'
declare -a cachedirs=()
declare -a candidates=() cmdopts=() candesc=()
declare -i delete=0 dryrun=0 filecount=0 move=0 totalsaved=0
declare -i verbose=0
declare -i ctime=0
declare -i LTIME=0
declare -i true=1
declare -i false=0
declare -i QUIET=0
declare    IFS=$' \t\n'
declare    SAVEIFS=$IFS
declare    BOOTLOG=/tmp/fetchlog-$USER
readonly DEPENDENCIES=(which find sed grep sort cat awk tput dialog)

# Expand to nothing if there are no matches
shopt -s nullglob
shopt -s extglob

# Import libs
#LIBRARY=${LIBRARY:-'/usr/share/makepkg'}
LIBRARY=${LIBRARY:-'/usr/share/fetch'}
source /etc/fetch/fetch.conf &> /dev/null
source "$LIBRARY"/core.sh
#source "$LIBRARY"/util/message.sh
#source "$LIBRARY"/util/parseopts.sh

# flag's para split package
: ${aPKGSPLIT=()}
: ${aPKGLIST=}
: ${PKG_FOLDER_DIR=0}
: ${PKG_FULLNAME=1}
: ${PKG_ARCH=2}
: ${PKG_BASE=3}
: ${PKG_BASE_VERSION=4}
: ${PKG_VERSION=5}
: ${PKG_BUILD=6}

function sh_splitpkg()
{
	file=${1}
	#pkg_re='^([a-z-]+)(-)([0-9\\.]+)(-)([0-9])(-)(.*)(.chi.zst)$'
	#pkg_re='([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*)-(([0-9]+(\.[0-9]+)*)(-([0-9]+))?)-([^.]+).*'
	pkg_re='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst' 	#SOEN
	aPKGSPLIT=()

	pkg_folder_dir=$(echo ${file%/*})							#remove arquivo deixando somente o diretorio/repo
	pkg_fullname=$(echo ${file##*/})    						#remove diretorio deixando somente nome do pacote

	arr=($(echo $pkg_fullname | awk 'match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array) {
			print array[0]
			print array[1]
			print array[2]
		   print array[3]
		   print array[4]
    		print array[5]
    		print array[6]
			}'))
	pkg_fullname="${arr[0]}"
	pkg_base="${arr[1]}"
	pkg_version_build="${arr[2]}"
	pkg_version="${arr[3]}"
	pkg_build="${arr[4]}"
	pkg_arch="${arr[5]}"
	pkg_base_version="${arr[0]}-${arr[4]}"
	aPKGSPLIT=($pkg_folder_dir $pkg_fullname $pkg_arch $pkg_base $pkg_base_version $pkg_version $pkg_build)
	return $?
}

#figlet
function logo()
{
	setvarcolors
	cat <<'EOF'
  __      _       _                      _
 / _| ___| |_ ___| |__  _ __   __ _  ___| | __  Copyright (C) 2019-2020 Vilmar Catafesta <vcatafesta@gmail.com>
| |_ / _ \ __/ __| '_ \| '_ \ / _` |/ __| |/ /
|  _|  __/ || (__| | | | |_) | (_| | (__|   <   Este programa pode ser redistribuído livremente
|_|  \___|\__\___|_| |_| .__/ \__,_|\___|_|\_\  sob os termos da Licença Pública Geral GNU.
                       |_|
EOF
	echo $yellow
   version
	echo $reset
	unsetvarcolors
}

function version()
{
	printf "%s %s\n"	"$myname" "$myver"
	printf "%s\n"		"Copyright (C) 2020 Vilmar Catafesta <vcatafesta@gmail.com>"
}

function init()
{
	local arr=
	local cdir=
	local nfiles=
	local pkg=
	local cOldDir=
	local AllFilesPackages=
	local pkg=
	local pkgInAll=
	local FilteredPackages=
	local AllFilteredPackages=
	local pkg_re='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst' 	#SOEN

	for cachedir in "${cachedirs[@]}"
	do
		[[ -d $cachedir ]] ||
			die "cachedir '%s' does not exist or is not a directory" "$cachedir"

		if (( move || delete )); then
			[[ ! -w $cachedir ]] && needsroot=1
		fi
		pushd "$cachedir" &>/dev/null || die "failed to chdir to $cachedir"

		cOldDir=$PWD
		pkgInAll=
		FilteredPackages=
		AllFilesPackages=
		AllFilteredPackages=
		candidates=()
		candesc=()
		pkgNumber=0

		if [ $# -lt 1 ]; then
			#AllFilesPackages=$(find "$PWD" -maxdepth 100 -name '*.chi.zst' -type f)
			AllFilesPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort )
			#AllFilesPackages=$(printf '%s\n' "$PWD"/*.chi.zst | sort -r)
		else
			#AllFilesPackages=$(find "$PWD" -type f -name '*.chi' -prune -o \( -name '*.chi.zst' \) | grep ^$1)
			AllFilesPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort)
			#AllFilesPackages=$(printf '%s\n' "$PWD"/*.chi.zst | grep $1 | sort -r )
		fi

		arr=(${AllFilesPackages[*]})
	  	nfiles=${#arr[*]}

#		if (( !${#arr[*]} )); then
#			printf "${red}  E  no candidate packages found for pruning\n"
#			exit 0
#		fi

		log_wait_msg "${reset}wait, searching ${red}($nfiles) ${reset}candidates for pruning in ${green}$cachedir"
		for pkgInAll in $AllFilesPackages
		do
			((pkgNumber++))
			pkgInFullName=${pkgInAll}
			#pkgInAll=$(echo "${pkgInAll##*/}") 		# remove directory
			sh_splitpkg ${pkgInAll}
			FilteredPackages=${aPKGSPLIT[$PKG_BASE]}
			#FilteredPackages=$(echo $pkgInAll | sed 's/-[[:digit:]].*$//')
			#AllFilteredPackages=$(find "$PWD" -type f -iname "$FilteredPackages*.zst" | sed 's/^.*\///' | sed 's/-[[:digit:]].*$//' | grep $FilteredPackages$ | sort)
			AllFilteredPackages=$(find "$PWD" -type f -iname "$FilteredPackages*.zst" | grep -E "*$FilteredPackages-([0-9])" | sort)
			#AllFilteredPackages=$(printf '%s\n' "$PWD"/$FilteredPackages*.chi.zst)

#			debug " #-$pkgNumber\n 1-$pkgInAll\n 2-$FilteredPackages\n 3-$AllFilteredPackages"

			pkg=
 			arr=(${AllFilteredPackages[*]})
 			array=("${AllFilteredPackages[*]}")
		  	nfiles=${#arr[*]}

			if (( verbose )); then
				printf "     ${white}verifying package ${purple}(%04d) ${green}[%40s]${purple}(%04d)${green} => %s\n" "$pkgNumber" "$FilteredPackages" "$nfiles" "${pkgInFullName}"
			fi

			if [[ $nfiles -gt 1 ]]; then
				while read -r pkg; do
					sh_splitpkg ${pkg}
					SearchPkg=${aPKGSPLIT[$PKG_BASE]}

					first="${FilteredPackages:1:1}"
					last="${SearchPkg:1:1}"

					if [[ ${last} > ${first} ]]; then
						break
					fi

					if [[ $FilteredPackages =~  $SearchPkg ]]; then
						if [[ "$(vercmp $pkgInFullName $pkg)" -lt 0 ]]; then
							candidates+=("${pkgInFullName}")
							canddesc+=("${pkgInFullName}.desc")
							canddesc+=("${pkgInFullName}.sha256")
							if (( verbose >= 3 )); then
								[[ $pkg =~ $pkg_re ]] && name=${BASH_REMATCH[1]} arch=${BASH_REMATCH[2]}
								if [[ -z $seen || $seenarch != "$arch" || $seen != "$name" ]]; then
									seen=$name seenarch=$arch
									printf '%s (%s):\n' "${name##*/}" "$arch"
								fi
								printf '  %s\n' "${pkg##*/}"
							elif (( verbose >= 2 )); then
								printf "%s$delim" "$pkg"
							fi
						fi
					fi
				done < <(printf '%s\n' "$array")
			fi
		done
		popd >/dev/null 2>&1
	done

	if (( ! ${#candidates[*]} )); then
#		printf "${red}  E  NO packages found for pruning\n"
		die "NO packages found for pruning"
#		exit 1
	fi

	pkgcount=${#candidates[*]}
	totalsaved=$(printf '%s\0' "${candidates[@]}" | xargs -0 stat -c %s | awk '{ sum += $1 } END { print sum }')
	set -o errexit # Exit immediately if a pipeline returns non-zero.

	(( verbose )) && cmdopts+=(-v)
	(( verbose )) && cmdopts+=(-f)
	if (( delete )); then
		printf '%s\0' "${candidates[@]}" | runcmd xargs -0 rm "${cmdopts[@]}"
		printf '%s\0' "${canddesc[@]}"   | runcmd xargs -0 rm "${cmdopts[@]}"
	elif (( move )); then
		printf '%s\0' "${candidates[@]}" | runcmd xargs -0 mv "${cmdopts[@]}" -t "$movedir"
	fi
	echo
	msg "$output (disk space saved: %s)" "$(size_to_human "$totalsaved")"
}

function cleanup()
{
	msg "Exiting.."
	exit
}
trap cleanup SIGINT SIGTERM

function main()
{
	local nfiles=0
	local pkg=
	local pkgInAll=
	local pkg_base=
	local pkg_search=
	local candidates=()
	local cachedir

	if (( QUIET )); then
		verbose=0
	else
		if (( verbose )); then
			if (( dryrun )); then
		   	log_msg "${white}running mode => ${red}DRY-RUN"
			elif (( delete )); then
		   	log_msg "${white}running mode => ${red}DELETE"
			elif (( move )); then
		   	log_msg "${white}running mode => ${red}MOVE"
			fi
		fi
	fi

	for cachedir in "${cachedirs[@]}"
	do
		[[ -d $cachedir ]]            || die "Error: cachedir '$cachedir' does not exist or is not a directory"
		pushd "$cachedir" &>/dev/null || die "Error: failed to chdir to $cachedir"

		#E eventualmente pode trocar a regex por umas dessas versões, se ainda quiser seguir com awk
		#'[0-9]+([.][0-9]+)+'
		#'-[0-9]+(.[0-9]+)+'
		#'-[0-9]+([.][0-9]+)+'

		if [ $# -lt 1 ]; then
			#AllFilesPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort )
			#AllNewPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort -Vr | sed -r 's/([^0-9])-([^0-9])/\1§\2/g' | sort -t- -k1,1 -u | sed 's/§/-/g')
  			#AllOldPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort -Vr | awk -F '[0-9]+(.[0-9]+)+' 'lista[$1]++')
			#using awk
  			AllOldPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort -Vr  | awk -F '[0-9]+([.][0-9]+)+' 'lista[$1]++') 		#OK
  			#AllNewPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort -V | awk -F '[0-9]+(.[0-9]+)+' '!lista[$1]++')
			#using sort
			#AllOldPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort -V | rev | tr - '\t' | uniq -f3 -df3 | tr '\t' - | rev)
			#AllNewPackages=$(find "$PWD" -type f -iname "*.chi.zst" | sort -Vr | rev | tr - '\t' | uniq -f3 | tr '\t' - | rev | tac)
		else
			#AllFilesPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort)
		   #AllNewPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort -Vr | sed -r 's/([^0-9])-([^0-9])/\1§\2/g' | sort -t- -k1,1 -u | sed 's/§/-/g')
			#AllOldPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort -Vr | awk -F '[0-9]+(.[0-9]+)+' 'lista[$1]++')
			#using awk
			AllOldPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort -Vr | awk -F '[0-9]+([.][0-9]+)+' 'lista[$1]++')   #OK
			#AllNewPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort -V | awk -F '[0-9]+(.[0-9]+)+' '!lista[$1]++')
			#using sort
			#AllOldPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort -V | rev | tr - '\t' | uniq -f3 | tr '\t' - | rev)
			#AllNewPackages=$(find "$PWD" -type f -iname "*.chi.zst" | grep $1 | sort -Vr | rev | tr - '\t' | uniq -f3 | tr '\t' - | rev | tac)
		fi
		#arrayfull=("${AllFilesPackages[@]}")
		arrayfull=("${AllOldPackages[@]}")
		#arr=(${AllOldPackages[*]})
		#nfiles=${#arr[*]}

		while read -r pkgInAll;do
			sh_splitpkg ${pkgInAll}
			pkg_base=${aPKGSPLIT[$PKG_BASE]}
			[[ -z "$pkg_base" ]] &&	continue
			(( pkgNumber++ ))

			if (( verbose >= 3 )); then
				printf "     ${white}candidate package ${purple}(%04d) ${green}[%42s]${purple}(%04d)${blue} => %s\n" "$pkgNumber" "$pkg_base" "$pkgNumber" "${pkgInAll}"
			fi

			candidates+=("${pkgInAll}")
			candesc+=("${pkgInAll}.desc")
		done < <(printf '%s\n' "$arrayfull")
		popd >/dev/null 2>&1
	done

	if (( ! ${#candidates[*]} )); then
		if (( verbose )); then
			die "NO packages found for pruning"
		fi
		exit 1
	fi

	if (( verbose )); then
		nfiles=0
		while read -r pkg
		do
			sh_splitpkg ${pkg}
			pkg_base=${aPKGSPLIT[$PKG_BASE]}
			if (( verbose >= 2 )); then
				(( nfiles++ ))
				printf "     ${white}    found package ${purple}(%04d) ${green}[%42s]${purple}(%04d)${red} => %s\n" "$nfiles" "$pkg_base" "$nfiles" "${pkg}"
			fi
		done < <(printf '%s\n' "${candidates[@]}")
	fi

	if (( verbose )); then
		nfiles=0
		while read -r pkg
		do
			printf "${red}%-79s\t${green} => %s\n" "${pkg}" "${candesc[nfiles]}"
			(( nfiles++ ))
		done < <(printf '%s\n' "${candidates[@]}")
	fi

	pkgcount=${#candidates[*]}
	totalsaved=$(printf '%s\0' "${candidates[@]}" | xargs -0 stat -c %s >/dev/null 2>&1 | awk '{ sum += $1 } END { print sum }')
	#totalsaved+=$(printf '%s\0' "${candesc[@]}"   | xargs -0 stat -c %s >/dev/null 2>&1 | awk '{ sum += $1 } END { print sum }')
	set -o errexit # Exit immediately if a pipeline returns non-zero.

	(( verbose )) && cmdopts+=(-v)
	(( verbose )) && cmdopts+=(-f)
	if (( delete )); then
		printf '%s\0' "${candidates[@]}" | runcmd xargs -0 rm "${cmdopts[@]}"
		printf '%s\0' "${candesc[@]}"    | runcmd xargs -0 rm "${cmdopts[@]}"
	elif (( move )); then
		printf '%s\0' "${candidates[@]}" | runcmd xargs -0 mv "${cmdopts[@]}" -t "$movedir"
		printf '%s\0' "${candesc[@]}"    | runcmd xargs -0 mv "${cmdopts[@]}" -t "$movedir"
	fi

	if (( !QUIET )); then
		if (( dryrun )); then
			msg "${yellow}$output finish dry-run (files found: $pkgcount) (disk space saved: %s)" "$(size_to_human "$totalsaved")"
		else
			msg "$output (files found: $pkgcount) (disk space saved: %s)" "$(size_to_human "$totalsaved")"
		fi
	fi
	return 0
}

function usage(){
	cat <<EOF
A flexible cache cleaning utility.
Usage: ${myname} <operation> [options] [targets...]

  Operations:
    -d, --dryrun          perform a dry run, only finding candidate packages.
    -m, --move <dir>      move candidate packages to "dir".
    -r, --remove          remove candidate packages.

  Options:
    -c, --cachedir <dir>  scan "dir" for packages. can be used more than once.
                          (default: read from /etc/fetch/fetch.conf).
    -f, --force           apply force to mv(1) and rm(1) operations.
    -h, --help            display this help message and exit.
        --nocolor         remove color from output.
    -q, --quiet           quiet output.
    -v, --verbose         increase verbosity. specify up to 3 times ([-v][-vv][-vvv]).
EOF
}

sh_checkroot
checkDependencies

OPT_SHORT=':a:c:dfhi:k:m:qrsuVvzt:'
OPT_LONG=('arch:' 'cachedir:' 'dryrun' 'force' 'help' 'ignore:' 'keep:' 'move:'
          'nocolor' 'quiet' 'remove' 'uninstalled' 'version' 'verbose' 'null'
          'ctime:')

if ! parseopts "$OPT_SHORT" "${OPT_LONG[@]}" -- "$@"; then
	exit 1
fi
set -- "${OPTRET[@]}"
unset OPT_SHORT OPT_LONG OPTRET

while :; do
	case $1 in
		-t|--ctime)
			ctime="$2"
			LTIME=$true
			shift ;;
		-c|--cachedir)
			cachedirs+=("$2")
			shift ;;
		-d|--dryrun)
			dryrun=1 ;;
		-f|--force)
			cmdopts=(-f) ;;
		-h|--help)
			usage
			exit 0 ;;
		-m|--move)
			move=1 movedir=$2
			shift ;;
		--nocolor)
			unsetvarcolors
			USE_COLOR='n' ;;
		-q|--quiet)
			unsetvarcolors
			QUIET=1 ;;
		-r|--remove)
			delete=1 ;;
		-V|--version)
			logo
			exit 0 ;;
		-v|--verbose)
			(( ++verbose )) ;;
		-z|--null)
			delim='\0' ;;
		--)
			shift
			break 2 ;;
	esac
	shift
done

# check if messages are to be printed using color
if [[ -t 2 && $USE_COLOR != "n" ]]; then
	setvarcolors
fi

# setting default cachedirs
if [[ -z $cachedirs ]]; then
	cachedirs=("${GITDIR:=/var/cache/fetch/archives}")
	cachedirs+=("/var/cache/fetch/archives")
	#cachedirs+=("/mnt/c/github/ChiliOS/packages")
fi

# sanity checks
case $(( dryrun+delete+move )) in
	0) 	die "no operation specified (use -h for help)" ;;
	[^1]) die "only one operation may be used at a time" ;;
esac

[[ $movedir && ! -d $movedir ]] &&
	die "destination directory '$movedir' does not exist or is not a directory!"

if (( move || delete )); then
	# make it an absolute path since we're about to chdir
	[[ $movedir && ${movedir:0:1} != '/' ]] && movedir=$PWD/$movedir
	[[ $movedir && ! -w $movedir ]] && needsroot=1
fi

main $*
