#!/usr/bin/env bash

echo -e "Arquivo nao-estruturado: \c"
read nome_arq

sed -i 's/,/./g' $nome_arq
awk 'NR<=1 {print $1","$2","$3","$4","$5","$6","$7","$8}' $nome_arq | tee ${nome_arq}_clean
awk 'gsub(/([0-9]{2}\s\w{3}\s[0-9]{4})/, $1$2$3) {print $1","$2","$3","$4","$5","$6","$7","$8}' $nome_arq | tee -a ${nome_arq}_clean
