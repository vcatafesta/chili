#!/bin/bash
# file: strzero.sh
# ---------------------------------------------------#

function _strzero()
{

    local meu_numero tamanho_total meu_strzero

    # ---------------------------------------------------#
    # param1 = Valor numérico informado.
    # param2 = Quantidade total de casas em seu numerador inteiro. 
    # ---------------------------------------------------#
    if ! [ "$1" -a "$2" ]; then 
        echo "Envie: 1º parâmetro o valor. No 2º a quantidade de casas. Bye"
        exit
    fi
    meu_numero="$1"
    tamanho_total="$2"
    meu_strzero=$(printf "%0${tamanho_total}d\n" $meu_numero)
    echo $meu_strzero
    # ---------------------------------------------------#
    # Retorno: Número formatado com zeros a esquerda. ex: 13 5 volta com 00013
    # ---------------------------------------------------#
}

# Para executar é obrigatório enviar 2 parâmetros.
_strzero $1 $2
 
