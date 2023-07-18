#!/usr/bin/env bash

# Envia a sequência de escape para o terminal
printf "\033[6n"

# Lê a resposta do terminal e extrai a posição atual do cursor
read -s -d R CUR_POS
CUR_POS=${CUR_POS#*[}    # Remove a parte inicial da resposta
CUR_X=${CUR_POS##*;}    # Extrai a coordenada X
CUR_Y=${CUR_POS%%;*}    # Extrai a coordenada Y

echo "A posição atual do cursor é: X=$CUR_X, Y=$CUR_Y"
