#!/bin/bash
#
# Coloca no centro da tela, em video reverso,
# a quantidade de colunas e linhas
# quando o tamanho da tela eh alterado.
#

trap Muda 28   # 28 = sinal gerado pela mudanca no tamanho
# da tela e Muda eh a funcao que fara isso.

Bold=$(tput bold)    # Modo de enfase
Rev=$(tput rev)      # Modo de video reverso
Norm=$(tput sgr0)    # Restaura a tela ao padrao default

Muda ()
{
clear
Cols=$(tput cols)
Lins=$(tput lines)
tput cup $(($Lins / 2)) $(((Cols – 7) / 2)) # Centro da tela
echo $Bold$Rev$Cols X $Lins$Norm
}

clear
read -n1 -p “Mude o tamanho da tela ou tecle algo para terminar “
