#!/bin/bash

#  Inicializar OPTIND é necessário caso o script tenha
#+ usado getopts antes. OPTIND mantém seu valor
OPTIND=1
while getopts :c: Opc
do
    case $Opc in
        c)  echo Recebi a opção -c
            echo Parâmetro passado para a opção -c foi $OPTARG
            ;;
       \?)  echo Caractere $OPTARG inválido
            exit 1
            ;;
        :)  echo -c precisa de um argumento
            exit 1
    esac
    shift $((--OPTIND))
    Args="$@"
    echo "Recebi o(s) seguinte(s) argumento(s) extra(s): $Args"
done
