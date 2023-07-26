#!/usr/bin/env bash
fft() {
    local intervalo=$1
    local num_arquivos=$2
    local find_command="find . -type d -name .git -prune -o -type f"
    local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"

    if [[ -n "$intervalo" ]]; then
        find_command+=" -mmin -${intervalo}"
    else
        # Se o intervalo não foi fornecido, use -mtime -1 para listar os arquivos do último dia
        find_command+=" -mtime -1"
    fi

    find_command+=" -printf \"$format_string\" | sort"

    if [[ -n "$num_arquivos" ]]; then
        # Se num_arquivos foi fornecido, use tail -n para exibir somente os últimos arquivos
        find_command+=" | tail -n $num_arquivos"
    fi
    eval "$find_command"
}


