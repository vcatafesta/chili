#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

declare -a bandeira
declare -a bin
bandeira[3]="American Express"
bandeira[4]="Visa"
bandeira[5]="MasterCard"

bin[1]="Companhia Área"
bin[2]="Companhia Área"
bin[3]="Industria de viagem e entretenimento"
bin[4]="Instituição financeira"
bin[4]="Instituição financeira"
bin[5]="Instituição financeira"
bin[6]="Bancos"
bin[7]="Industria de Petróleo"
bin[8]="Área de telecomunicações"
bin[9]="Outros emissores: como Governo"
bin[0]="Outros emissores: como Governo"

calcula_checksum() {
    card_prefix="$1"
    reversed_prefix=$(echo "$card_prefix" | rev)

    total=0
    is_second_digit=true

    for ((i = 0; i < ${#reversed_prefix}; i++)); do
        digit="${reversed_prefix:$i:1}"

        if [ "$is_second_digit" = true ]; then
            digit=$((digit * 2))
            if ((digit > 9)); then
                digit=$((digit - 9))
            fi
        fi

        total=$((total + digit))
        if [ "$is_second_digit" = true ]; then
            is_second_digit=false
        else
            is_second_digit=true
        fi
    done

    checksum=$((total % 10))
    if ((checksum == 0)); then
        echo 0
    else
        echo $((10 - checksum))
    fi
}

read -p "Digite os números iniciais do cartão de crédito: " card_prefix
checksum=$(calcula_checksum "$card_prefix")
echo "O dígito verificador é: $checksum"
echo "A bandeira é          : ${bandeira[${card_prefix:0:1}]}"
echo "Emitido por           : ${bin[${card_prefix:1:1}]}"
