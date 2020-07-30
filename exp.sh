#!/bin/bash
VAR="-MTIME=0"

[[ $VAR == *e* ]] && echo e:OK
[[ $VAR == *r* ]] && echo r:OK

echo =========================================

expr $VAR : '.*e.*' && echo expr e:OK
expr $VAR : '.*r.*' && echo expr r:OK
expr $VAR : '.*T.*' && echo expr r:OK



SIZE=${#VAR}
POS=${VAR%=*} # % para posição do ultimo; %% para posiçao do primeiro hifen
POS=${#POS}
[ $SIZE -ne $POS ]&& echo "Encontrado = na posicao $((POS+1))"
