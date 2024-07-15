#!/bin/bash
# Redimensiona fotos direto no Nautilus

IFS="
" # IFS passa a ser somente o new line
Tipo=$(zenity --list \
	--title "Redimensiona imagens" \
	--text "Informe se redimensionamento\né percentual ou absoluto" \
	--radiolist --column Marque --column "Tipo" \
	true Percentual false Absoluto) || exit 1

if [ $Tipo = Percentual ]; then
	Val=$(zenity --entry \
		--title "Redimensiona imagens" \
		--text "Informe o percentual de redução" \
		--entry-text 50)% || exit 1 # Concatenando % em $Val
else
	Val=$(zenity --entry \
		--title "Redimensiona imagens" \
		--text "Informe a largura final da imagem" \
		--entry-text 200)x || exit 1
fi

Var=$(zenity --list --title "Redimensiona imagens" \
	--text "Escolha uma das opções abaixo" \
	--radiolist --height 215 --width 390 --hide-column 2 \
	--column Marque --column "" --column Opções \
	false 0 "Saída da imagem em outro diretório" \
	false 1 "Saída da imagem com sufixo" \
	true 2 "Saída da imagem sobregravando a inicial") || exit 1
case $Var in
0) Dir=$(zenity --file-selection \
	--title "Escolha diretório" \
	-–directory) || exit 1 ;;
1) Suf=$(zenity --entry \
	--title "Redimensiona imagens" \
	--text "Informe o sufixo dos arquivos" \
	--entry-text _redim) || exit 1 ;;
2)
	mogrify --resize $Val
	"$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"
	exit
	;;
esac
Arqs=$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | wc -l)
#  No for a seguir um echo numérico atualiza
#+ a barra de progresso e um echo seguido de um
#+ jogo-da-velha (#) atualiza o texto do cabeçalho
for Arq in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS; do
	echo $((++i * 100 / $Arqs))
	echo "# Redimensionando $(basename $Arq)"
	sleep 3
	if [ $Var -eq 0 ]; then
		convert "$Arq" -resize $Val "$Dir/${Arq##*/}"
	else
		convert "$Arq" -resize $Val "${Arq%%.*}$Suf.${Arq#*.}"
	fi
done | zenity --progress \
	--title "Aguarde. Em redimensionamento" \
	--auto-close --auto-kill
