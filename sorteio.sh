#!/usr/bin/env bash

nomes=(Vilmar Bruno Celso Washington Filipi Bagatini Mauricio Alcides Leandro Gleiton Ama Ivan  )
if [ "${#nomes[@]}" -lt 2 ]; then
	echo "É necessário ter pelo menos duas pessoas para o sorteio."
	exit 1
fi
num_pessoas=${#nomes[@]}
indice_sorteado=$((RANDOM % num_pessoas))
pessoa_sorteada=${nomes[$indice_sorteado]}
echo "A pessoa sorteada é: $pessoa_sorteada"
