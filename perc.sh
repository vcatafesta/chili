#!/usr/bin/env bash
MEDIUM='~/Downloads/'
dir_install='/tmp/temp/'
DIALOG='dialog'

#rsync --progress --stats -avz ~/Downloads/ /tmp/temp/ | pv -lep -s $(du -sb /chili/ | awk '{print $1}') > /dev/null
#rsync -vrltD ~/Downloads/ /tmp/temp/ | pv -lep -s5 > /dev/null

sh_tailexecrsync() {
	{
#		cd $dir_install
		rsync -ravZp --dry-run "$MEDIUM/" "$dir_install/"
		echo
		echo
		echo "COPIA EFETUADA COM SUCESSO. TECLE ALGO"
	} > out &
	${DIALOG}  	--title "**RSYNC**"                   	\
        		--begin 10 10 --tailboxbg out 04 120 	\
        		--and-widget                           \
        		--begin 3 10 --msgbox "Aguarde" 5 30

	rm -f out > /dev/null 2>&1
}

sh_tailexecrsync
