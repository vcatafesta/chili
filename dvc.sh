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


regex_visa='/^4[0-9]{12}(?:[0-9]{3})?$/'
regex_mastercard='/^5[1-5][0-9]{14}$|^2(?:2(?:2[1-9]|[3-9][0-9])|[3-6][0-9][0-9]|7(?:[01][0-9]|20))[0-9]{12}$/'
regex_amex='/^3[47][0-9]{13}$/'
regex_discover='/^65[4-9][0-9]{13}|64[4-9][0-9]{13}|6011[0-9]{12}|(622(?:12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10})$/'
regex_diners_club='/^3(?:0[0-5]|[68][0-9])[0-9]{11}$/'
regex_jcb='/^(?:2131|1800|35[0-9]{3})[0-9]{11}$/'

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
