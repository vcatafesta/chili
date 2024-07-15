#!/bin/bash

function Flashcmd() { # Apaga o Menu Após o Click do Mouse
	yad --text "Click - $1" --info
	echo $*
	kill -s USR2 $YAD_PID
}
export -f Flashcmd

flash_menu_detect=('<b>Fabricante: </b>' '<b>Modelo: </b>' '<b>Gravador: </b>''<b>Detectar</b>'!${flash_file[15]}'!Exibe as Informções do Chip Rom')

mapfile -t Apple < <(
	echo "--field=${flash_menu_detect[0]}":RO
	echo "--field=${flash_menu_detect[1]}":RO
	echo "--field=${flash_menu_detect[2]}":RO
	echo "--field=<b>Detectar</b> :FBTN"
	echo 'bash -c "Flashcmd 7"'
)

flashmenudetect=$(yad --text "\n<b>Apple</b>\n" \
	--posx 260 --posy 178 --height 456 --margins 0 --columns 1 --text-align center --undecorated --no-buttons --no-escape \
	--skip-taskbar --fixed --form "${Apple[@]}") #& # Não Colocar --ON-TOP fica sem mostrar o YAD PULSATE
exit
