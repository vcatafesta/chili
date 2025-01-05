#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  fr.sh
#  Created: 2025/01/05 - 00:00
#  Altered: 2025/01/05 - 00:00
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
export TEXTDOMAIN=fr.sh

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

MostraErro() {
	echo "erro: ${red}$1${reset} => comando: ${cyan}'$2'${reset} => result=${yellow}$3${reset}"
}
#trap 'MostraErro "$APP[$FUNCNAME][$LINENO]" "$BASH_COMMAND" "$?"; exit 1' ERR

supports_uefi() {
	fdisk -l "$1" 2>/dev/null | grep -q "EFI"
}

detect_audio_server() {
	if pgrep -x pipewire >/dev/null; then
		echo "pipewire"
	elif pgrep -x pulseaudio >/dev/null; then
		echo "pa"
	elif pgrep -x jackd >/dev/null; then
		echo "jack"
	else
		echo "none"
	fi
}

fr() {
	local force_uefi=false
	local img=""

	# Processar argumentos
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-u | --force-uefi)
			force_uefi=true
			shift
			;;
		-*)
			msg_warn "Erro: Opção desconhecida: $1"
			return 1
			;;
		*)
			img="$1"
			shift
			;;
		esac
	done

	if test $# -ge 1; then
		[[ -e "$img" ]] || {
			msg_warn "Imagem/Device $img não encontrada!"
			return 1
		}
	else
		cat <<-EOF
			usage:
			   fr file.img
			   fr file.qcow2
		EOF
	fi

	# Verificar se a imagem foi especificada
	[[ -z "$img" ]] && {
		msg_warn "Erro: Imagem/Device não especificada!"
		return 1
	}
	[[ ! -e "$img" ]] && {
		msg_warn "Erro: Imagem/Device ${img} não encontrada!"
		return 1
	}

	# Informar as portas usadas
	local random_port="$(shuf -i 4444-45000 -n 1)"
	local random_spice_port="$(shuf -i 5900-5910 -n 1)"
	msg_info "spice running on port: $random_spice_port"
	msg_info "remote-viewer spice://localhost:$random_spice_port"

#	#sudo pacman -S edk2-ovmf
#	# Verificar suporte a UEFI
#	if supports_uefi "$img"; then
#		msg_info "Ativando suporte a UEFI com OVMF"
#		qemu_options+=(-drive file=/usr/share/edk2/x64/OVMF.4m.fd,if=pflash,format=raw,readonly=on)
#	else
#		msg_warning "Imagem não suporta UEFI, utilizando BIOS Legacy"
#	fi

  # Forçar UEFI, se solicitado
  if $force_uefi; then
    msg_info "Forçando inicialização UEFI..."
    qemu_options+=(-drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF.4m.fd)
  else
    msg_warn "Parametro -u não informado, usando BIOS Legacy (padrão)..."
  fi

	# Adicionar opções padrão do QEMU
	declare -a qemu_options=()
	qemu_options+=(-no-fd-bootchk)
	qemu_options+=(-machine accel=kvm)
	qemu_options+=(-cpu host)
	qemu_options+=(-smp "$(nproc)")
	qemu_options+=(-m 8G)
	qemu_options+=(-k pt-br)
	qemu_options+=(-drive file=${img},if=none,id=disk1,format=raw)
	qemu_options+=(-device ide-hd,drive=disk1,bootindex=1)
	msg_info "Ativando hd /archlive/qemu/hda.img"
	qemu_options+=(-drive file=/archlive/qemu/hda.img,format=raw)
	qemu_options+=(-name "chili-qemurunfile $*",process=archiso_0)
	qemu_options+=(-device virtio-scsi-pci,id=scsi0)
	qemu_options+=(-audiodev "$(detect_audio_server)",id=snd0)
	qemu_options+=(-rtc base=localtime,clock=host)
	qemu_options+=(-device ich9-intel-hda)
	qemu_options+=(-device hda-output,audiodev=snd0)
	qemu_options+=(-global ICH9-LPC.disable_s3=1)
	qemu_options+=(-machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0)

	# Configurar SPICE e rede
	qemu_options+=(-spice port=$random_spice_port,disable-ticketing=on)
	qemu_options+=(-monitor tcp:localhost:$random_port,server,nowait)
	qemu_options+=(-device virtio-serial)
	qemu_options+=(-chardev spicevmc,id=vdagent,debug=0,name=vdagent)
	qemu_options+=(-device virtserialport,chardev=vdagent,name=com.redhat.spice.0)
	qemu_options+=(-netdev user,id=net0)
	qemu_options+=(-device e1000,netdev=net0)
	{

		# Executar o QEMU
		sudo env XDG_RUNTIME_DIR=/run/user/$(id -u) qemu-system-x86_64 "${qemu_options[@]}" &
		qemu_pid=$!
		remote-viewer spice://localhost:$random_spice_port &
		viewer_pid=$!

		# Aguardar o remote-viewer e encerrar o QEMU quando ele fechar
		wait $viewer_pid
		kill $qemu_pid
	}
}
