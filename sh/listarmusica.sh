#!/bin/bash
# Recebe parte dos nomes de musicas como parametro e
# lista os interpretes. Se o nome for composto, deve
# ser passado entre aspas.
# ex. "Eu nao sou cachorro nao" "Churrasquinho de Mae"
#
if  [ $# -eq 0 ]
then
    echo Uso: $0 musica1 [musica2] ... [musican]
    exit 1
fi
IFS="
:"
for Musica
do
    echo $Musica
    Str=$(grep -i "$Musica" musicas) ||
        {
        echo "    Não encontrada"
        continue
        }
    for ArtMus in $(echo "$Str" | cut -f2 -d^)
    do
        echo "    $ArtMus" | grep -i "$Musica" | cut -f1 -d~
    done
done
