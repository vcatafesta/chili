#!/bin/bash
# Programa didático em shell+zenity
# Pesquisa aniversariante

Hoje=$(date +%m%d) # data no formato MMDD
Regs=$(grep $Hoje$ catalogo)
[ -z "$Regs" ] && exit
Pessoas=$(cut -f1 -d: <<<"$Regs")
Tels=$(cut -f2 -d: <<<"$Regs")
Mens='Aniversariante(s) de hoje:
'$(xargs -L1 echo "    " <<<"$Pessoas")
zenity --notification \
	--text "$Mens" &&
	zenity --list --column Nome --column Telefones "$Pessoas" "$(tr ^ ' ' <<<"$Tels")"
