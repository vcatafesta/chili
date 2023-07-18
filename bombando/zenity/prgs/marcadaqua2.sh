#!/bin/bash
#  O programa pedirá para o operador informar a
#+ imagem que será utilizada como marca d'água nos
#+ arquivos selecionados no nautilus, bem como a
#+ posição na qual se situará.
#+
#+ De posse deste dados, a imagem será gerada sobre
#+ o arquivo inicial. Assim sendo, é uma boa prática,
#+ primeiramente salvar as imagens originais.

Titulo="Colocação de marca d'água"
#  Caso que que a marca d'agua fique mais ou menos
#+ visível, aumente ou diminua o valor da variável a seguir
Brilho=40
#  ou então comente a linha acima e descomente as linhas abaixo
#+ Brilho=$(zenity --entry --title "$Titulo"                      \
#+     --text "Escolha o percentual de intensidade" {10..100..10} \
#+     --entry-text 40) || exit 1

#  Solicita arquivo que será a marca dágua.
#+ Infelizmente a opção --file-selection é a única
#+ que não aceita --text e por isso temos de criar
#+ um --title que seja bastante informativo.
MarDag=$(zenity --file-selection \
   --title "Seleção do arquivo que será usado como marca d'água") || exit 1

#  Solicita localização da marca d'água.
Local=$(zenity --list --radiolist --title "$Titulo" --height 360 \
    --text "Informe em qual local das imagens se situará a marca d'água"           \
    --column Marque --column "" --column Localização --hide-column 2               \
    false center centro                       \
    true southeast "Canto inferior direito"   \
    false south "Centro inferior"             \
    false southwest "Canto inferior esquerdo" \
    false west "Centro esqueda"               \
    false northwest "Canto superior esquerdo" \
    false north "Centro superior"             \
    false northeast "Canto superior direito"  \
    false east "Centro direito"               \
    false tile "lado-a-lado sobre a imagem") || exit 1

#  Preparando $Local para fazer tile ("azulejar")
#+ ou receber local da marca d'água
[[ $Local == 'tile' ]] && Local=--tile || Local='--gravity '$Local


IFS='
'   # Somente o <ENTER> como separador entre campos
i=0
TotArqs=$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | wc -l) 
#  No for a seguir um echo numérico atualiza 
#+ a barra de progresso e um echo seguido de um 
#+ jogo-da-velha (#) atualiza o texto do cabeçalho.
#+ Agora a mágica do ImageMagick junto com o nautilus e com o zenity
for Arq in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
do 
    echo $((++i * 100 / $TotArqs))
    echo "# Redimensionando $(basename $Arq)" 
    composite "$MarDag" -watermark $Brilho $Local "$Arq" "$Arq"
done | zenity --progress \ 
    --title "Aguarde. Em redimensionamento" \ 
    --auto-close --auto-kill
