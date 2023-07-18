#!/usr/bin/env bash
#=======================HEADER=======================================|
# Criado em Janeiro de 2019
#
#AUTOR
# Jefferson 'slackjeff' Rocha <root@slackjeff.com.br>
#
#DESCRICAO
# Simples script criado para mazonOS para escolher a interface que o
# usuário necessita. O script reconhece quais interfaces existe no
# sistema e joga na tela para o usuário fazer a seleção.
#
#LICENÇA
# MIT
#
#CHANGELOG
# (Versão 1.0) - Jefferson Rocha
#   -Interfaces adicionadas de entrada:
#   (xfce, i3, fluxbox, blackbox, kde, wmaker)
#====================================================================|
clear # Limpando a vida

#=================VARIABLES
readonly NAME='chwm'
readonly VERSION='1.0'
red='\033[31;1m'
blue='\033[34;1m'
end='\033[m'

#=================FUNCTIONS
_HELP()
{
    cat <<EOF
$NAME $VERSION

Menu show the interfaces that u have have installed by default in your system
You select a interface and the $NAME send for your HOME in the archive .xinitrc

EOF
}

_SEND() # Function for send .xinitrc
{
    local xinitrc="${HOME}/.xinitrc"

    echo "$@" > $xinitrc
    return 0
}

#=================START
echo "=============================================="
echo -e "\t${red}chwm - Change your Environment${end}"
echo -e "==============================================\n"

declare -A interfaces # Declare associative array
interfaces=( # List possibles interfaces
     ['blackbox']="$(which startblackbox 2>/dev/null)"
     ['fluxbox']="$(which startfluxbox 2>/dev/null)"
     ['i3']="$(which i3 2>/dev/null)"
     ['xfce']="$(which startxfce4 2>/dev/null)"
     ['wmaker']="$(which wmaker 2>/dev/null)"
     ['kde']="$(which startkde 2>/dev/null)"
)

# Have interface in system?
[[ -z "${interfaces[@]}" ]] && { echo "Your system no have Interface."; exit 1 ;}

# Print on STDOUT list of interfaces on SYSTEM
i=0 # Increment var
echo -e "[?] - Help\n"
for conf in "${!interfaces[@]}"; do
    if [[ -e "${interfaces[$conf]}" ]]; then # Exist? Print now.
        select_me_name[$i]="$conf" # take indice/name
        select_me_path[$i]="${interfaces[$conf]}" # Insert content in array
        echo -e "${blue}[$i]${end} - $conf"
        i=$(($i+1)) # Increment
    fi
done

read -p $'\n\033[31;1mSelect Your Interface: \033[m' CHOICE

# if user select help, quit ;)
[[ "$CHOICE" = '?' ]] && { _HELP; exit 0 ;}

# Take only number user select
CHOICE_NUMBER="$CHOICE"

# making conversion for take full index of ambient
CHOICE="${select_me_name[$CHOICE]}"

# Need add interface here also.
case $CHOICE in
    blackbox) _SEND "exec ${select_me_path[$CHOICE_NUMBER]}" ;;
    fluxbox)  _SEND "exec ${select_me_path[$CHOICE_NUMBER]}" ;;
    i3)       _SEND "exec ${select_me_path[$CHOICE_NUMBER]}" ;;
    xfce)     _SEND "exec dbus-launch --exit-with-session ${select_me_path[$CHOICE_NUMBER]}" ;;
    wmaker)   _SEND "exec dbus-launch --exit-with-session ${select_me_path[$CHOICE_NUMBER]}" ;;
esac

echo -e "${blue}Your new interface is: ${red}${CHOICE}${end} ${red},${end} ${blue}Please run ${red}startx${end} ${blue}for up 
your interface${end}"
