#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

ffb() {
	local filepath="${1:-.}"      # Caminho a ser pesquisado (padrão: diretório atual)
	local num_arquivos="${2:-10}" # Número de arquivos a exibir (padrão: 10)
	local resultado

	# Formatação de cores
	local green="\033[1;32m"
	local blue="\033[1;34m"
	local reset="\033[0m"

  # Comando find para localizar os maiores arquivos
  resultado=$(find "$filepath" -type d -name .git -prune -o -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n "$num_arquivos")

	# Exibir o resultado formatado
	echo -e "=== Resultado ==="
	echo "$resultado" | nl

	# Exibir os parâmetros utilizados
	echo -e "=== Parâmetros informados ==="
	echo -e "Caminho               : ${green}${filepath}${reset}"
	echo -e "Número de arquivos    : ${green}${num_arquivos}${reset}"
	echo -e "Uso: ${blue}ffb \"*.c\"${reset}, ${blue}ffb \"*.c\" 10${reset}"
	echo -e "     ${blue}ffb . ${reset}"
	echo -e "     ${blue}ffb /var/log 20 ${reset}"
	echo -e "     ${blue}ffb "*.log" ${reset}"
}
export -f ffb
