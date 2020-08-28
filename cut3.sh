#!/bin/bash
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
done
