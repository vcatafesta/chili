#!/bin/bash
tput sgr0
clear

# Carregando as 8 cores básicas para um vetor
Cores=(Preto Vermelho Verde Marrom Azul Púrpura Ciano "Cinza claro")


# Listando o menu de cores
echo "
Opc     Cor
=     ==="
#  A linha a seguir significa: para i começando de 1;
#+ enquanto i menor ou igual ao tamanho do vetor Cores;
#+ incremente o valor de i de 1 em 1
for ((i=1; i<=${#Cores[@]}; i++))
{
    printf "%02d        %s\n" $i "${Cores[i-1]}"
}


CL=
until [[ $CL == 0[1-8] || $CL == [1-8] ]]
do
    read -p "
Escolha a cor da letra: " CL
done


#  Para quem tem bash a partir da versao 3.2
#+ o test do until acima poderia ser feito
#+ usando-se Expressoes Regulares. Veja como:
#+ until [[ $CL =~ 0?[1-8] ]]
#+ do
#+    read -p "
#+ Escolha a cor da letra: " CL
#+ done


CF=
until [[ $CF == 0[1-8] || $CF == [1-8] ]]
do
    read -p "
Escolha a cor de fundo: " CF
done


let CL-- ; let CF--   # Porque as cores variam de zero a sete
tput setaf $CL
tput setab $CF
