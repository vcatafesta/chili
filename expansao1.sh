#!/usr/bin/env bash

# remocao e substituicao de padroes

# ${nome#padrao} e ${nome##padrao}
# ${nome%padrao} e ${nome%%padrao}

#caracteres de formacao de nomes de arquivos
# * - qualquer quantidade de caracteres
# ? - um caractere
# [...] - um dos caracteres da lista (classe)

var='Maria tinha uma carneirinho'
echo ${var#* } #remove tudo do inicio, até encontrar espaco
echo ${var#*m} #remove tudo do inicio, até encontrar a letra m

echo ${var%* } #remove tudo do final, até encontrar espaco
echo ${var%*m} #remove tudo do final, até encontrar a letra m
echo ${var%m*} #remove tudo do m e qualquer coisa depois do m

pkg='harbour-3.4-5-x86_64.chi.zst'
echo ${pkg%%.chi.zst}
