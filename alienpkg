#!/bin/bash

 # alienpkg
 #
 # Created: 2019/07/11
 # Altered: 2019/07/13
 #
 # Copyright (c) 2019 - 2019, Vilmar Catafesta <vcatafesta@gmail.com>
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
_VERSION_="0.0.13.20190713"

function sh_init(){
	source /chili/core.sh
	unset BUILDDIR
	unset size
}

function sh_pkgsize(){
	size="$(/usr/bin/du -sk --apparent-size)"
    size="$(( ${size%%[^0-9]*} * 1024 ))"
}

function sh_initvars(){
	#pkgs=$(ls -1 *.xz)
	ALIEN_CACHE_DIR=/var/cache/pacman/pkg
	PKGS=$@
#	EXT="${EXT:-.pkg.tar.xz}"
	BUILDDIR="${PKGDIR:-/lfs/arch}"
}

function sh_main(){
	for package in $ALIEN_CACHE_DIR/$*
	do
		echo
#		packagedir=${package%$EXT}
		packagedir=${package}
		FULLDIR=$BUILDDIR/$packagedir

		pkg=$(echo $FULLDIR |sed 's/\// /g'|awk '{print $NF}'|sed 's/-x86_64.pkg.tar.xz//g'|sed 's/-any.pkg.tar.xz//g'|sed 's/1://g'|sed 's/2://g')
#		pkg=$(echo $FULLDIR |sed 's/\// /g'|awk '{print $NF}'|sed 's/-x86_64.pkg.tar.xz//g'|sed 's/-any.pkg.tar.xz//g'|sed 's/\(.*\)_/\1 /'|sed 's/1://g'|sed 's/2://g')
#		pkg=$(echo $FULLDIR | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/_/g'| sed 's/\(.*\)_/\1 /')
#		arr=($pkg)
#	    pkg="${arr[0]}-${arr[1]} ${arr[2]}"

		destdir=$BUILDDIR/$pkg
		log_info_msg "Criando diretorio $destdir"
		mkdir -p $destdir
		evaluate_retval

		log_info_msg "Descompactando pacote $package at $destdir"
		tar -xf $package -C $destdir >/dev/null 2>&1
		evaluate_retval

		case $packagedir in
			luit-[0-9]* )
			sed -i -e "/D_XOPEN/s/5/6/" configure
			;;
		esac

#		CFG_FILE=$destdir/.PKGINFO
#		CFG_CONTENT=$(cat $CFG_FILE | sed -r '/[^=]+=[^=]+/!d' | sed -r 's/\s+=\s/=/g')
#		eval "$CFG_CONTENT"
#		sh_info $CFG_CONTENT

#		while read var value
#		do
#		    export "$var" "$value"
#		done < $destdir/.PKGINFO

		sed -i 's/ = /="/g' $destdir/.PKGINFO
		sed -i 's/$/"/g' $destdir/.PKGINFO
		source "$destdir/.PKGINFO"

		export ALIEN_DESC_BUILD="${pkg: -1}"
		export ALIEN_SITE="$url"
		export ALIEN_LICENSE="$license"
		export ALIEN_ARCH="$arch"
		export ALIEN_SIZE="$size"
		export ALIEN_DESC="$pkgdesc"
		export ALIEN_DEP="$depend"
		export ALIEN_DESC_PACKNAME="$pkgname"
		export ALIEN_DESC_VERSION=$( echo $pkgver|cut -d '-' -f1)
		export ALIEN_DESC_BUILD=$( echo $pkgver|cut -d '-' -f2)

	    log_info_msg "Gerando DESC pacote $destdir"
		pushd $destdir	>/dev/null 2>&1

		as_root genalien $pkg >/dev/null 2>&1
		evaluate_retval

#		mv $destdir/.BUILDINFO $destdir/info/ >/dev/null 2>&1
#		mv $destdir/.MTREE     $destdir/info/ >/dev/null 2>&1
#		mv $destdir/.PKGINFO   $destdir/info/ >/dev/null 2>&1

		rm -f $destdir/.BUILDINFO >/dev/null 2>&1
		rm -f $destdir/.MTREE     >/dev/null 2>&1
		rm -f $destdir/.PKGINFO   >/dev/null 2>&1

		log_info_msg "Construindo pacote $destdir"
#		as_root bcpalien  >/dev/null 2>&1
		as_root bcpalien
		evaluate_retval

		sh_pkgsize
		popd >/dev/null 2>&1
		unset size
	done
}

#figlet
function logo()
{
    _CAT << 'EOF'
       _ _                  _
  __ _| (_) ___ _ __  _ __ | | ____ _
 / _` | | |/ _ \ '_ \| '_ \| |/ / _` |
| (_| | | |  __/ | | | |_) |   < (_| |
 \__,_|_|_|\___|_| |_| .__/|_|\_\__, |
                     |_|        |___/
EOF
    sh_version
}

sh_init
setvarcolors
logo
sh_checkroot
if [ $# -lt 1 ]; then
	echo "uso: $0 <package-alienigena-versao>"
   exit 1
fi
sh_initvars $*
sh_main $*
