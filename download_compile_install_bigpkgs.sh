#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  download_compile_install_bigpkgs.sh
#  Created: 2024/07/22 - 22:33
#  Altered: 2024/07/22 - 22:33
#
#  Copyright (c) 2024-2024, Vilmar Catafesta <vcatafesta@gmail.com>
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
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##############################################################################
#export LANGUAGE=pt_BR
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=download_compile_install_bigpkgs.sh

# Definir a variável de controle para restaurar a formatação original
reset=$(tput sgr0)

# Definir os estilos de texto como variáveis
bold=$(tput bold)
underline=$(tput smul)   # Início do sublinhado
nounderline=$(tput rmul) # Fim do sublinhado
reverse=$(tput rev)      # Inverte as cores de fundo e texto

# Definir as cores ANSI como variáveis
black=$(tput bold)$(tput setaf 0)
red=$(tput bold)$(tput setaf 196)
green=$(tput bold)$(tput setaf 2)
yellow=$(tput bold)$(tput setaf 3)
blue=$(tput setaf 4)
pink=$(tput setaf 5)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
gray=$(tput setaf 8)
orange=$(tput setaf 202)
purple=$(tput setaf 125)
violet=$(tput setaf 61)
light_red=$(tput setaf 9)
light_green=$(tput setaf 10)
light_yellow=$(tput setaf 11)
light_blue=$(tput setaf 12)
light_magenta=$(tput setaf 13)
light_cyan=$(tput setaf 14)
bright_white=$(tput setaf 15)

#debug
export PS4='${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset}'
#set -x
#set -e
shopt -s extglob

#system
declare APP="${0##*/}"
declare _VERSION_="1.0.0-20240722"
declare distro="$(uname -n)"
declare pkg
declare -a DEPENDENCIES=(grep sed wget makepkg)
declare -a aPackages=(
	'bigcontrolcenter-base'
	'biglinux-webapps'
	'biglinux-config'
	'auto-tweaks-browser'
	'big-store'
)

function MostraErro {
	echo "erro: ${red}$1${reset} => comando: ${cyan}'$2'${reset} => result=${yellow}$3${reset}"
}
#trap 'MostraErro "$APP[$FUNCNAME][$LINENO]" "$BASH_COMMAND" "$?"; exit 1' ERR

for pkg in "${aPackages[@]}"; do
	if mkdir -p /tmp/$pkg-install; then
		cd /tmp/$pkg-install || exit 1
		[[ -e PKGBUILD ]] && rm PKGBUILD
		if wget https://raw.githubusercontent.com/vcatafesta/$pkg/main/pkgbuild/PKGBUILD; then
			sed -i 's|url="https://github.com/biglinux/$pkgname"|url="https://github.com/vcatafesta/$pkgname"|'g PKGBUILD
			if ! makepkg --force --install --clean --cleanbuild --syncdeps --noconfirm; then
				mapfile -t aPacknames <<<"$(find /tmp/$pkg-install -iname "$pkg-*pkg.tar*")"
				for pkginstall in "${aPacknames[@]}"; do
					sudo pacman -U $pkginstall --noconfirm --overwrite \*
				done
			fi
		fi
	fi
done
