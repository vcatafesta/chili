#!/usr/bin/env bash

nomes=('Vilmar' 'Bruno' 'Celso' 'Washington' 'Filipi' 'Bagatini' 'Mauricio' 'Alcides' 'Leandro' 'Gleiton' 'Ama' 'Ivan')
if [ "${#nomes[@]}" -lt 2 ]; then
	echo "É necessário pelo menos duas pessoas para o sorteio."
	exit 1
fi
echo "A pessoa sorteada é: ${nomes[$((RANDOM % ${#nomes[@]}))]}"
