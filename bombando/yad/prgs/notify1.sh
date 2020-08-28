#!/bin/bash
#  Executa um comando dando a resposta num
#+ balão do tipo notify-send. Ideal para
#+ usar com <ALT>+F2, sem abrir um terminal
#+ Thanks Karthik

Saida=$(eval "$*" 2>/dev/null) || {
    yad --text "Comando errado" --button gtk-ok
	exit 1
	}
notify-send -t $((1000+300*$(echo -n $Saida | wc -w))) -u low -i gnome-terminal "$*" "$Saida" 

