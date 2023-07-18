#!/bin/bash

ls | while read arq
do
    ((i++))
    echo "$i: $arq"
done
echo "No diretorio corrente (`pwd`) existem $i arquivos"

unset i

while read arq
do
    ((i++))
    echo "$i: $arq"
done < <(ls)
echo "No diretorio corrente (`pwd`) existem $i arquivos"


