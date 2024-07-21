#!/bin/sh
# -*- coding: utf-8 -*-

#sh <(curl -s -L https://raw.githubusercontent.com/vcatafesta/chili/main/install-bigwebapps.sh)
#sh <(wget -q -O - https://raw.githubusercontent.com/vcatafesta/chili/main/install-bigwebapps.sh)
#source <(curl -s -L https://raw.githubusercontent.com/vcatafesta/chili/main/install-bigwebapps.sh)
#source <(wget -q -O - https://raw.githubusercontent.com/vcatafesta/chili/main/install-bigwebapps.sh)

#  install-bigwebapps.sh
#  Created: 2024/07/13
#  Altered: 2024/07/13
#
#  Copyright (c) 2023-2024, Vilmar Catafesta <vcatafesta@gmail.com>
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

{
	oops() {
		echo "$0:" "$@" >&2
		exit 1
	}

	umask 0022
	url="https://raw.githubusercontent.com/vcatafesta/chili/main"
	declare -a files_bin=('download_compile_install_bigwebapps.sh')
	tmpDir=~/bigwebapps-install

	[[ ! -d "$tmpDir" ]] && { mkdir -p "$tmpDir" || oops "Unable to create temporary directory to download files"; }

	require_util() {
		command -v "$1" >/dev/null 2>&1 || oops "you do not have '$1' installed, which is needed to $2"
	}

	#require_util tar "descompatar o tarball"

	if command -v curl >/dev/null 2>&1; then
		cmdfetch() { curl --silent --continue-at - --insecure -L "$1" -o "$2"; }
	elif command -v wget >/dev/null 2>&1; then
		cmdfetch() { wget --quiet -c "$1" -O "$2"; }
	else
		require_util curl "downloader"
		require_util wget "downloader"
	fi

	for f in "${files_bin[@]}"; do
		echo "Downloading $f to '$tmpDir'..."
		cmdfetch "$url/$f" "$tmpDir/$f" || oops "download failure '$url/$f'"
	done

	for file in "${files_bin[@]}"; do
		sudo chmod +x $tmpDir/$file
		sudo cp -rfv $tmpDir/$file /usr/bin/
	done

	ls -la --color=auto $tmpDir

	echo
	echo "digite:"
	echo "	sudo download_compile_install_bigwebapps.sh"
	echo "ou entre em: $tmpDir e digite:"
	echo "	sudo ./download_compile_install_bigwebapps.sh"

	exec $tmpDir/download_compile_install_bigwebapps.sh

}

