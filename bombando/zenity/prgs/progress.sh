#!/bin/bash

rm -r ~/dir 2> /dev/null

mkdir -p ~/dir

TotArqFim=$(du -sb /home/.wine/.Flash8/ | cut -f1)
TotArqIni=$(du -sb ~/dir/ | cut -f1)
VouBaixar=$(( $TotArqFim - $TotArqIni ))

cp -ur /home/.wine/.Flash8 ~/dir &

[ $TotArqIni -eq $TotArqFim ] || while ps aux | grep -q $! 
do
	Atual=$(du -sb ~/dir/ | cut -f1)
	Baixei=$(($Atual-$TotArqIni))
	echo "# $((Baixei/1000)) de $((VouBaixar/1000)) KBytes copiados"
	echo $((Baixei * 100 / VouBaixar))
	sleep 1
done | zenity --progress \
    --auto-close         \
    --auto-kill          \
    --title="Atualização"\
    --text="Atualizando..."
