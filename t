#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  t
#  Created: 2025/03/03 - 18:35
#  Altered: 2025/03/03 - 18:35
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
export TEXTDOMAIN=t

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
declare _VERSION_="1.0.0-20250303"
declare APPDESC="bash - Wraper for "
declare distro="$(uname -n)"
declare DEPENDENCIES=(tput)
declare dialogRcFile="/home/vcatafesta/.dialogrc"

cleanup() { rm -f ""; }
#trap cleanup EXIT
MostraErro() { echo "erro: ${red}$1${reset} => comando: ${cyan}'$2'${reset} => result=${yellow}$3${reset}";}
trap 'MostraErro "$APP[$FUNCNAME][$LINENO]" "$BASH_COMMAND" "$?"; exit 1' ERR

sh_create_dialogrc() {
  cat > "$dialogRcFile" <<EOF_DIALOGRC
screen_color = (white,black,off)
dialog_color = (white,black,off)
title_color = (cyan,black,on)
border_color = dialog_color
shadow_color = (black,black,on)
button_inactive_color = dialog_color
button_key_inactive_color = dialog_color
button_label_inactive_color = dialog_color
button_active_color = (white,cyan,on)
button_key_active_color = button_active_color
button_label_active_color = (black,cyan,on)
tag_key_selected_color = (white,cyan,on)
item_selected_color = tag_key_selected_color
form_text_color = (BLUE,black,ON)
form_item_readonly_color = (green,black,on)
itemhelp_color = (white,cyan,off)
inputbox_color = dialog_color
inputbox_border_color = dialog_color
searchbox_color = dialog_color
searchbox_title_color = title_color
searchbox_border_color = border_color
position_indicator_color = title_color
menubox_color = dialog_color
menubox_border_color = border_color
item_color = dialog_color
tag_color = title_color
tag_selected_color = button_label_active_color
tag_key_color = button_key_inactive_color
check_color = dialog_color
check_selected_color = button_active_color
uarrow_color = screen_color
darrow_color = screen_color
form_active_text_color = button_active_color
gauge_color = title_color
border2_color = dialog_color
searchbox_border2_color = dialog_color
menubox_border2_color = dialog_color
separate_widget = ''
tab_len = 0
visit_items = off
use_shadow = off
use_colors = on
EOF_DIALOGRC
  export DIALOGRC="$dialogRcFile"
}

# Testa se o terminal suporta caracteres gráficos estendidos
sh_ascii_lines() {
  #Isso força o dialog a usar caracteres ASCII básicos para as bordas.
  #if [[ "$LANG" =~ 'UTF-8' ]]; then
  if [[ "$(printf '\u250C')" =~ "┌" ]]; then
    export NCURSES_NO_UTF8_ACS=1  # Terminal suporta ACS
  else
    export NCURSES_NO_UTF8_ACS=0  # Terminal NÃO suporta ACS
  fi
  }

sh_setEnvironment() {
  [[ ! -e "$dialogRcFile" ]] && sh_create_dialogrc
  sh_ascii_lines
}

check_uefi() {
  if [ -d "/sys/firmware/efi" ]; then
    echo "true"  # Saída capturada
    return 0     # Código de saída
  else
    echo "false" # Saída capturada
    return 1     # Código de saída
  fi
}

if LEFI=$(check_uefi); then
  echo "LEFI: $LEFI"  # Exibe "true" ou "false"
  echo "O sistema está em UEFI."
else
  echo "LEFI: $LEFI"
  echo "O sistema está em BIOS (Legacy)."
fi

if $LEFI; then
  echo ok
fi

_WINDOWMANAGER='tty wmaker mate'

# Remove "tty" se estiver presente
_WINDOWMANAGER="${_WINDOWMANAGER//tty /}"

echo "$_WINDOWMANAGER"
