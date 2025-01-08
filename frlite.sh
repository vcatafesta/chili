#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  frlite.sh
#  Created: 2025/01/05 - 01:34
#  Altered: 2025/01/05 - 01:34
#
#  Copyright (c) 2025-2025, Vilmar Catafesta <vcatafesta@gmail.com>
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
export TEXTDOMAIN=frlite.sh

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
declare _VERSION_="1.0.0-20250105"
declare distro="$(uname -n)"
declare DEPENDENCIES=(tput)
source /usr/share/fetch/core.sh

frlite() {
  local force_uefi=0
  local img=""

  # Processar argumentos
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -u | --force-uefi)
      force_uefi=1
      shift
      ;;
    *)
      img="$1"
      shift
      ;;
    esac
  done

  # Verificar se a imagem foi especificada
  if [[ -z "$img" || ! -e "$img" ]]; then
    echo "Erro: Imagem/Device não encontrada ou não especificada!"
    return 1
  fi

  # Configurar opções básicas do QEMU
  local qemu_options=()
  qemu_options+=(-m 2G)
  qemu_options+=(-cpu qemu64)
  qemu_options+=(-smp 4)
  qemu_options+=(-drive file="$img",format=raw)

  # Adicionar UEFI, se solicitado
  if [[ $force_uefi -eq 1 ]]; then
    qemu_options+=(-drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/OVMF_CODE.fd)
  fi

  # Executar o QEMU
  sudo qemu-system-x86_64 "${qemu_options[@]}"
}

frlite "$@"
