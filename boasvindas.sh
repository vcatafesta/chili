#!/bin/bash
#  Programa bem educado que
#  dá bom-dia, boa-tarde ou
#  boa-noite conforme a hora
Hora=$(date +%H)
case $Hora in
    0? | 1[01]) echo Bom Dia
                ;;
    1[2-7]    ) echo Boa Tarde
                ;;
    *         ) echo Boa Noite
                ;;
esac
exit
