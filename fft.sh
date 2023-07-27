#!/usr/bin/env bash

fft() {
    local num_arquivos=$1
    local intervalo=$2

    local find_command="find . -type d -name .git -prune -o -type f"
    local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"

    if [[ -n "$intervalo" ]]; then
        find_command+=" -mmin -${intervalo}"
#    else
#       find_command+=" -mtime -1"
    fi

    find_command+=" -printf \"$format_string\" | sort"

    if [[ -n "$num_arquivos" ]]; then
        find_command+=" | tail -n $num_arquivos"
    fi

    local resultado=$(eval "$find_command")
    echo "=== Resultado ==="
    echo "$resultado" | nl
    echo "=== Parâmetros passados ==="
    echo "Intervalo de tempo: ${intervalo:-Todos}"
    echo "Número de arquivos: ${num_arquivos:-Todos}"
}

