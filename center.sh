#!/bin/bash
# Script bobo para testar
# o comando tput (versao 2)

Colunas=`tput cols`      #  Salvando quantidade colunas
Linhas=`tput lines`      #  Salvando quantidade linhas
Linha=$((Linhas / 2))    # Qual eh a linha do meio da tela?
Coluna=$(((Colunas - ${#1}) / 2)) #Centrando a mensagem na tela
tput sc                  # Salvando posicao do cursor
tput cup $Linha $Coluna  #  Posicionando para escrever
tput rev                 #  Video reverso
echo $1
tput sgr0                #  Restaura video ao normal
tput rc                  #  Restaura cursor aa posição original
