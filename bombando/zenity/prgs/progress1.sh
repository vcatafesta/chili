#!/bin/bash

# As 3 linha aseguir, armazenam respectivamente:
#    - Quantos bytes existem no diretorio de origem;
#    - Quantos bytes já existiam no destino;
#    - Quantidade de bytes que serao baixados.
TotArqFim=$(du -sb /diretorio/origem | cut -f1)
TotArqIni=$(du -sb /diretorio/destino | cut -f1)
VouBaixar=$(($TotArqFim - $TotArqIni))

# Copiando em background:
cp -ur /diretorio/origem /diretorio/destino &

# O while a seguir sera executado caso haja algo a baixar
# e enquanto persistir o processo em background ($!)
[ $TotArqIni -eq $TotArqFim ] || while ps aux | grep -q $!; do
	Atual=$(du -sb ~/diretorio/destino | cut -f1)
	Baixei=$(($Atual - $TotArqIni))
	echo "# $((Baixei / 1000)) de $((VouBaixar / 1000)) Kbytes copiados"
	echo $((Baixei * 100 / VouBaixar))
	sleep 1
done | zenity --progress \
	--auto-close \
	--auto-kill \
	--title="Atualização" \
	--text="Atualizando..."
