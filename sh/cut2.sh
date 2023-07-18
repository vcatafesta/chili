#!/bin/bash

while getopts :c Opc 
do
    case $Opc in
        c)  echo Recebi a opção -c
            ;;
       \?)  echo Caractere $OPTARG inválido
            exit 1
    esac
done
