#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  make-repo-testing.sh
#  Created: 2024/08/21 - 19:07
#  Altered: 2024/08/21 - 19:07
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
export TEXTDOMAIN=make-testing.sh

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
declare _VERSION_="1.0.0-20240821"
declare distro="$(uname -n)"
declare DEPENDENCIES=(tput)
source /usr/share/fetch/core.sh

MostraErro() {
  echo "erro: ${red}$1${reset} => comando: ${cyan}'$2'${reset} => result=${yellow}$3${reset}"
}
trap 'MostraErro "$APP[$FUNCNAME][$LINENO]" "$BASH_COMMAND" "$?"; exit 1' ERR

#cd /github/ChiliOS/packages/core/testing/x86_64/ || exit 1
#sudo repo-add chili-testing.db.tar.gz ./*.zst

branch='testing'
secret_PORT='65002'
secret_USER='u537062342@154.49.247.66'
secret_IP='154.49.247.66'
secret_PATH='/home/u537062342/public_html/repo'

# Determine the database name based on the branch type
if [ "$branch" == "testing" ]; then
	db_name="chili-testing"
elif [ "$branch" == "stable" ]; then
	db_name="chili-stable"
else
	echo "Error: Unknown branch type: $branch"
	exit 1
fi

repo-add -n -R $db_name.db.tar.gz *.pkg.tar.zst
ssh-keyscan -t rsa -p 65002 154.49.247.66 | sudo tee -a /root/.ssh/known_hosts
rsync --progress -Cravzp --rsh='ssh -l u537062342 -p 65002' $PWD/ ${secret_USER}:${secret_PATH}/${branch,,}/x86_64/

## Upload the package files
#for i in *.zst; do
#	pkgname=$(basename $i)
#	if rsync -vapz -e "ssh -p ${secret_PORT}" $i ${secret_USER}:${secret_PATH}/${branch,,}/x86_64/; then
#		echo "✅ Pacote $pkgname enviado com sucesso para o repositório $branch"
#	else
#		exit
#		echo "❌ Falha ao enviar o pacote $pkgname para o repositório $branch"
#	fi
#done
#for i in *.sig *.md5; do
#	rsync -vapz -e "ssh -p ${secret_PORT}" $i ${secret_USER}@${secret_IP}:${secret_PATH}/${branch,,}/x86_64/
#done

#ssh -v "$secret_USER" -p "$secret_PORT" << EOF
#set -x
#cd $secret_PATH/${branch,,}/x86_64
#repo-add -n -R $db_name.db.tar.gz *.pkg.tar.zst
#exit_code=\$?
#echo "Comando repo-add concluído com código de saída: \$exit_code"
#exit \$exit_code
#EOF

