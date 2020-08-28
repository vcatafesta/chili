#!/bin/bash

while getopts c Opc 
do
    case $Opc in
        c)  echo Recebi a opção -c
            ;;
    esac
done
