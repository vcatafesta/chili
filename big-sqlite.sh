#!/usr/bin/env bash

# Nome do banco de dados
DB_NAME="bigstore.db"

# Arquivo de saída para os dados do array
OUTPUT_FILE="/tmp/array.txt"

# Função para criar a tabela no banco de dados
function sh_create_table() {
	local create_table_sql="CREATE TABLE IF NOT EXISTS flatpak (id INTEGER PRIMARY KEY, package TEXT, desc TEXT, summary TEXT);"
	sqlite3 "$DB_NAME" "$create_table_sql"
	echo "Tabela 'flatpak' criada com sucesso."
}

# Função para inserir dados na tabela
function sh_insert_data() {
	local desc_file="$1"
	local summary_file="$2"
	local package="$3"
	local desc_content=$(<"$desc_file")
	local summary_content=$(<"$summary_file")
	local insert_data_sql="INSERT INTO flatpak (package, desc, summary) VALUES ('$package', '$desc_content', '$summary_content');"

	sqlite3 "$DB_NAME" "$insert_data_sql"
#	echo "Dados inseridos na tabela 'flatpak' para o pacote '$package' com sucesso."
}

# Função para verificar se um pacote já existe na tabela
function sh_check_package_exists() {
	local package="$1"
	local query="SELECT package FROM flatpak WHERE package='$package';"
	local result=$(sqlite3 "$DB_NAME" "$query")

	if [ -n "$result" ]; then
		return 0 # Pacote existe na tabela
	else
		return 1 # Pacote não existe na tabela
	fi
}

# Função para listar dados da tabela com base em colunas específicas
function sh_list_table() {
	local columns="$1" # Parâmetro para especificar as colunas a serem exibidas
	local query="SELECT $columns FROM flatpak;"
	sqlite3 "$DB_NAME" "$query"
}

# Função principal
function sh_main() {
	local base_directory="/github/bcc/big-store/big-store/usr/share/bigbashview/bcc/apps/big-store/description/"

	# Associative array para armazenar dados dos pacotes
	declare -A package_data

	rm -f $OUTPUT_FILE
	cat >> $OUTPUT_FILE <<-EOF
#!/usr/bin/env bash
#shellcheck disable=SC2155,SC2034
#shellcheck source=/dev/null

#  hardware-info.sh.htm
#  Description: Control Center to help usage of BigLinux
#
#  Created: 2022/02/28
#  Altered: 2023/08/19
#
#  Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
#                2022-2023, Bruno Gonçalves <www.biglinux.com.br>
#                2022-2023, Rafael Ruscher <rruscher@gmail.com>
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

APP="${0##*/}"
_VERSION_="1.0.0-20230819"
declare -gA package_data

EOF

	# Percorrer diretórios base
	for package_dir in "$base_directory"/*; do
		if [ -d "$package_dir/pt_BR" ]; then
			local package=$(basename "$package_dir")
			local pt_br_dir="$package_dir/pt_BR"
			local summary_file="$pt_br_dir/summary"
			local desc_file="$pt_br_dir/desc"

			# Verificar se os arquivos existem
			if [ -f "$desc_file" ] && [ -f "$summary_file" ]; then
				sh_check_package_exists "$package"
				if [ $? -eq 1 ]; then
#					sh_insert_data "$desc_file" "$summary_file" "$package"
#					echo "$summary_content|$desc_content"
#					package_data["$package"]="$summary_content|$desc_content"
					summary=$(cat $summary_file)
					desc=$(cat $desc_file)
#					echo "package_data[$package]='$summary|$desc'" | tee -a "$OUTPUT_FILE"
					((++count))
					echo "$count $package"
#					echo "package_data[$package]='$summary|$desc'" >> "$OUTPUT_FILE"
					echo "package_data[$package]=\"\$(gettext \$\"$summary\")|\$(gettext \$\"$desc\")\"" >> "$OUTPUT_FILE"

#					if [[ $count -eq 10 ]]; then
#						exit
#					fi
				else
					#          echo "Pacote '$package' já existe na tabela. Pular..."
					:
				fi
			else
				echo "Arquivos desc e/ou summary não encontrados para o pacote '$package'. Pular..."
			fi
		fi
	done
}

function sh_write_array {
	# Escrever dados dos pacotes no arquivo de saída
	echo "Escrevendo dados dos pacotes no arquivo: $OUTPUT_FILE"
	for package in "${!package_data[@]}"; do
		data="${package_data[$package]}"
		echo "package_data[\"$package\"]=\"$data\"" >>"$OUTPUT_FILE"
	done
}

# Chamar a função para criar a tabela
sh_create_table

# Chamar a função principal
sh_main

# Listar a tabela com as colunas específicas (id, package, desc, summary)
echo "Dados da tabela 'flatpak' (colunas específicas):"
sh_list_table "id, package, desc, summary"

# Exibir mensagem de conclusão
echo "Processo concluído. Dados escritos em $OUTPUT_FILE."
