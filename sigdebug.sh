#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  sidebug.sh
#  Created: 2024/07/17 - 20:12
#  Altered: 2024/07/19 - 10:04
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
export TEXTDOMAIN=chili-makebash

#debug
export PS4='${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset}'
#set -x
#set -e
shopt -s extglob

#system
APP="${0##*/}"
_VERSION_='1.0.0-20240719'
distro=chililinux
DEPENDENCIES=(grep)
source /usr/share/fetch/core.sh

function MostraErro {
	read -r -p "${red}$1${reset} => comando: ${cyan}'$2'${reset} => result=${yellow}$3${reset}"
}

function GeraErro {
	echo == Passou por aqui --
	ls xpto		# erro aqui, mas mas podemos usar o return para status do erro
#	return 0	# Se não usarmos o return, o status da função é o do seu último comando, senão o do return
}

#trap 'MostraErro "$APP[$FUNCNAME][$LINENO]" "$BASH_COMMAND" "$?"; exit 1' ERR
trap 'MostraErro "$APP[$FUNCNAME][$LINENO]" "$BASH_COMMAND" "$?";' DEBUG
GeraErro
echo Alô | grep Olá
echo == Uma linha após o erro ==

