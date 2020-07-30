#!/bin/bash

# armazena os valores das setas direcionais
UP_KEY=$(echo -n -e '\e[A')
DOWN_KEY=$(echo -n -e '\e[B')
RIGHT_KEY=$(echo -n -e '\e[C')

# configurações do menu
OPTION=( "Option 1" "Option 2" "Option 3" "Quit" )
NUM_OPTIONS=${#OPTION[*]}
CURRENT=0

# vai para o início da linha atual. como não há uma seqüência de escape única
# para isso, o cursor é movido para o início da linha anterior e a seguir
# para o início da linha seguinte, retornando à linha atual
function startline () {
    echo -n -e "\e[1F"
    echo -n -e "\e[1E"
}

# limpa a linha atual
function clearline () {
    echo -n -e "\e[2K"
    startline
}

# imprime uma opção do menu. se o segunto argumento for um valor verdadeiro
# (1, por exemplo), a opção é impressa como selecionada
function print_option () {
    if [ $2 ]; then
        echo -n -e "\e[7m"
    fi

    clearline

    echo -n -e ${OPTION[$1]}
    echo -n -e "\e[0m"
}

# move a seleção para cima. a sequencia de escape \e[1F move o cursor para
# o início da linha anterior
function move_up () {
    if [ $CURRENT -gt 0 ]; then
        print_option $CURRENT
        CURRENT=$((CURRENT - 1))
        echo -n -e "\e[1F"
        print_option $CURRENT 1
    fi
}

# move a seleção para baixo. a sequencia de escape \e[1E move o cursor para
# o início da linha seguinte
function move_down () {
    if [ $CURRENT -lt $((NUM_OPTIONS-1)) ]; then
        print_option $CURRENT
        CURRENT=$((CURRENT + 1))
        echo -n -e "\e[1E"
        print_option $CURRENT 1
    fi
}

# detecta se uma tecla foi pressionada
function keypressed () {
    read KEY
    [ $KEY ]
}

# armazena as configurações de linha do terminal
STTY_SETTINGS=$(stty -g)

# imprime as opções do menu
for i in $(seq 0 $((${#OPTION[*]}-1))); do
    echo ${OPTION[i]}
done

# vai para a primeira opção e a imprime como selecionada
echo -n -e "\e[${NUM_OPTIONS}F"
print_option $CURRENT 1

# altera as configurações de linha do terminal
stty -icanon min 0 time 0 -echo

# loop do menu
while [ 1 ]; do
    if keypressed; then
        if [ $KEY = $UP_KEY ]; then
            move_up
        elif [ $KEY = $DOWN_KEY ]; then
            move_down
        elif [ $KEY = $RIGHT_KEY ]; then
            if [ $CURRENT = 3 ]; then
                break
            fi
        fi
    fi
done

# restaura a cor padrão do terminal
echo -e '\e[0m'

# restaura as configurações de linha do terminal
stty $STTY_SETTINGS
