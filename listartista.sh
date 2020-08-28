#!/bin/bash
# Dado um artista, mostra as suas musicas
# versao 2

if  [ $# -eq 0 ]
then
    echo Voce deveria ter passado pelo menos um parametro
    exit 1
fi


IFS="
:"


for ArtMus in $(cut -f2 -d^ musicas)
do
    echo "$ArtMus" | grep -i "^$@~" > /dev/null && echo $ArtMus | cut -f2 -d~
done
