#!/bin/bash
# Cria agenda de aniversários

while true; do
	Pessoa=$(zenity --entry \
		--title "Nome do Amigo" \
		--text "Informe o nome do amigo")
	[ "$Pessoa" ] ||
		zenity --question \
			--title "Nome não Informado" \
			--text "Deseja continuar?\n \
        Para SIM clique em OK\n \
        Para NÃO clique em CANCEL" || exit 1
	break
done
Nasc=$(zenity --calendar \
	--date-format "%Y%m%d" \
	--title "Escolha de Data" \
	--text "Escolha a data do aniversário de $Pessoa")
echo $Nasc
