#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

function ccp0() {
	local filepath="$1"
	local diretorio_destino="$2"
	local resultado

	if [ $# -eq 0 ]; then
		echo "Uso: ccp <padrão_do_arquivo> <diretório_destino>"
		return 1
	fi

	if [ -z "$filepath" ]; then
		filepath='*.*'
	fi

	local find_command="find . -type d -iname .git -prune -o -type f -iname '$filepath'"
	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	find_command+=" -exec cp {} \"$diretorio_destino\" \\;"
	find_command+=" -printf \"$format_string\""

	resultado=$(eval "$find_command")
	echo "=== Resultado ==="
	echo -e "$resultado" | nl
	echo "=== Parâmetros informados ==="
	echo "Padrão (\$1): ${filepath}"
	echo "Diretório de Destino (\$2): ${diretorio_destino}"
	echo "Uso: ccp \"*.c\" /tmp"
}

function ccp1() {
	local filepath="$1"
	local diretorio_destino="$2"
	local resultado
	local total_bytes=0

	if [ $# -eq 0 ]; then
		echo "Uso: ccp <padrão_do_arquivo> <diretório_destino>"
		return 1
	fi

	if [ -z "$filepath" ]; then
		filepath='*.*'
	fi

	local find_command="find . -type d -iname .git -prune -o -type f -iname '$filepath'"
	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	find_command+=" -exec cp {} \"$diretorio_destino\" \\;"
	find_command+=" -exec du -sb {} \\;"
	find_command+=" -printf \"$format_string\""

	resultado=$(eval "$find_command")

	while read -r line; do
		if [[ $line =~ ^[0-9]+ ]]; then
			total_bytes=$((total_bytes + ${BASH_REMATCH[0]}))
		fi
	done <<<"$resultado"

	echo "=== Resultado ==="
	echo -e "$resultado" | nl
	echo "=== Total de Bytes Copiados ==="
	echo "$total_bytes bytes"
	echo "=== Parâmetros informados ==="
	echo "Padrão (\$1): ${filepath}"
	echo "Diretório de Destino (\$2): ${diretorio_destino}"
	echo "Uso: ccp \"*.c\" /tmp"
}

function ccp3() {
	local filepath="$1"
	local diretorio_destino="$2"
	local resultado
	local total_bytes=0

	if [ $# -eq 0 ]; then
		echo "Uso: ccp <padrão_do_arquivo> <diretório_destino>"
		return 1
	fi

	if [ -z "$filepath" ]; then
		filepath='*.*'
	fi

	local find_command="find . -type d -iname .git -prune -o -type f -iname '$filepath'"
	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	find_command+=" -exec cp {} \"$diretorio_destino\" \\;"
	find_command+=" -exec du -sb {} \\;"
	find_command+=" -printf \"$format_string\""

	resultado=$(eval "$find_command")

	while read -r line; do
		if [[ $line =~ ^[0-9]+ ]]; then
			total_bytes=$((total_bytes + ${BASH_REMATCH[0]}))
		fi
	done <<<"$resultado"

	total_human_readable=$(numfmt --to=iec --format='%3.f' $total_bytes)

	echo "=== Resultado ==="
	echo -e "$resultado" | nl
	echo "=== Total de Bytes Copiados ==="
	echo "$total_bytes bytes ($total_human_readable)"
	echo "=== Parâmetros informados ==="
	echo "Padrão (\$1): ${filepath}"
	echo "Diretório de Destino (\$2): ${diretorio_destino}"
	echo "Uso: ccp \"*.c\" /tmp"
}

function ccp() {
	local filepath="$1"
	local diretorio_destino="$2"
	local total_bytes=0

	if [ $# -eq 0 ]; then
		echo "Uso: ccp <padrão_do_arquivo> <diretório_destino>"
		return 1
	fi

	if [ -z "$filepath" ]; then
		filepath='*.*'
	fi

	local find_command="find . -type d -iname .git -prune -o -type f -iname '$filepath' -exec cp {} \"$diretorio_destino\" \\; -exec du -sb {} +"
	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	find_command+=" -printf \"$format_string\""
	resultado=$(eval "$find_command" 2>&1)

	while read -r line; do
		if [[ $line =~ ^[0-9]+ ]]; then
			total_bytes=$((total_bytes + ${BASH_REMATCH[0]}))
		fi
	done <<<"$resultado"

	total_human_readable=$(numfmt --to=iec --format='%3.f' $total_bytes)

	echo "=== Resultado ==="
	echo "$resultado" | grep -vE '^[0-9]+[[:space:]]+'
	echo -e "=== Total Bytes Copiados === \033[1;31m$total_bytes bytes ($total_human_readable)\033[0m"
	echo "=== Parâmetros informados ==="
	echo -e "Padrão (\$1)               : \033[1;34m${filepath}\033[0m"
	echo -e "Diretório de Destino (\$2) : \033[1;34m${diretorio_destino}\033[0m"
	echo -e "Uso : \033[1;36mccp \"*.c\" /tmp\033[0m"
}

ccp "$1" "$2"
