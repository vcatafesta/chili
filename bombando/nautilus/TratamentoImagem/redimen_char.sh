#!/bin/bash
#  Coleta informações para fazer redimensionamento
#+ de imagens diretamente do nautilus
#+ Autor:       Julio Neves
#+ Colaboração: Luiz Carlos Silveira (aka Dom)

#  Abre um xterm para executar o programa
#+ a sintaxe pode parecer estranha, mas
#+ acho que esta é a melhor forma
# xterm -T "Redimensiona Imagens" -geometry 500x500 -bg darkred -fg lightgray -fn 7x14 -e bash -c "source <(tail -n +15 $0)"
xterm -T "Redimensiona Imagens" -geometry 500x500 -bg darkred -fg lightgray -fn '-dejavu-dejavu sans mono-medium-r-*-*-*-*-*-*-*-*-*-*' -e bash -c "source <(tail -n +15 $0)"
exit 0

################Programa propriamente dito.

Verde=$(
	tput setaf 2
	tput bold
)                 # Valores default em verde
Norm=$(tput sgr0) # Restaura cor
clear
# Preparando o basename dos arquivos para listá-los
for Arq in "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"; do
	Arqs=$(echo -e "$Arqs${Arq%%*/}\n")
done
echo Os arquivos a redimensionar são:
echo == ======== = ============= ====
column -c$(tput cols) <(echo "$Arqs") # Listando arqs em colunas
read -n1 -p "
Certo? (${Verde}S${Norm}/n): "
[[ $REPLY == [Nn] ]] && exit 1

echo
read -n1 -p "Informe se redimensionamento é: 
    ${Verde}P${Norm} - ${Verde}P${Norm}ercentual
    ${Verde}A${Norm} - ${Verde}A${Norm}bsoluto
==> " Tipo

case ${Tipo^} in #  Conteudo passa para maiuscula (bash 4.0)
P)
	echo ercentual
	read -p "Informe o percentual de redução: " Val
	grep -Eq '^[0-9]+$' <<<$Val || { # $Val não numérico
		tput flash
		read -n1 -p"Percentual inválido"
		exit 1
	}
	Val=$Val%
	;;
A)
	echo bsoluto
	read -p "Informe a largura final da imagem: " Val
	grep -Eq '^[0-9]+$' <<<$Val || {
		tput flash
		read -n1 -p"Largura inválida"
		exit 1
	}
	;;
*)
	tput flash
	read -n1 -p"Informação inválida"
	exit 1
	;;
esac

read -n1 -p "
Informe a saída da imagem que vc deseja:
    ${Verde}D${Norm} - saída da imagem em outro ${Verde}D${Norm}iretório
    ${Verde}S${Norm} - saída da imagem com ${Verde}S${Norm}ufixo
    ${Verde}G${Norm} - saída da imagem sobre${Verde}G${Norm}ravando a inicial
==> " Saida

case ${Saida^^} in
D)
	echo -e '\010Outro diretório'
	read -p 'Informe o diretório: ' Dir
	[ -d "$Dir" ] || {
		tput flash
		read -n1 -p "Diretório inexistente"
		exit 1
	}
	;;
S)
	echo -e '\010Sufixo'
	read -p "Informe o sufixo dos arquivos (${Verde}_redim${Norm}): " Suf
	Suf=${Suf:-_redim}
	;;
G)
	echo -e '\010Sobregravando'
	mogrify --resize $Val $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
	exit
	;;
*)
	read -n1 -p "Você devia ter escolhido ${Verde}D${Norm}, ${Verde}S${Norm} ou ${Verde}G${Norm}"
	exit 1
	;;
esac
IFS='
' # A variável $IFS ficou só com um \n (<ENTER>)
# Agora vamos redimensionar
for Arq in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS; do
	if [ ${Saida^^} = D ]; then
		convert "$Arq" -resize $Val "$Dir/${Arq##*/}"
		echo "$Dir/${Arq##*/}" redimensionado
	else
		convert "$Arq" -resize $Val "${Arq%%.*}$Suf.${Arq#*.}"
		echo "${Arq%%.*}$Suf.${Arq#*.}" redimensionado
	fi
done
