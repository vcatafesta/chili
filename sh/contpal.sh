#!/bin/bash
# Script  meramente pedagógico cuja
# função é contar a qtd de palavras
# de um  arquivo.  Supõe-se  que as
# palavras estão separadas entre si
# por espaço,  ou .

if  [ $# -ne 1 ]
then
    echo uso: $0 /caminho/do/arquivo
    exit 2
fi
Cont=0
for Palavra in $(cat $1)
do
    Cont=$((Cont+1))
done
echo $Cont
