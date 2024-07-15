#!/bin/bash
for Arq in *.sh; do
	if [ -f ../"$Arq" ]; then
		TamOrig=$(ls -l "$Arq" | awk '{print $5}')
		TamDest=$(ls -l ../"$Arq" | awk '{print $5}')
		kdialog --dontagain ArqJaExiste:CopiaArq \
			--title "Exemplo de dontagain" --yesno \
			"O arquivo $Arq tem $TamOrig bytes, mas já existe no destino com $TamDest bytes.\nDeseja copiá-lo assim mesmo?" && {
			echo copiando
			#  Durante a cópia, o ideal seria termos trocado o
			#+ echo acima pela opção --progress que veremos depois
			kdialog --dontagain ArqJaExiste:RemoveArq \
				--title "Exemplo de dontagain" --yesno \
				"Deseja remover o arquivo $Arq da origem?" &&
				echo removendo
		}
	fi
done
