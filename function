#!/bin/sh
function imprime()
{
    echo "Sou a função '${0}'"
    echo "Param 1: ${1}"
    echo "Param 2: ${2}"
    echo "Lista de parâmetros: ${*}"
}

imprime um dois tres quatro

function retorna()
{
    echo "sou um valor"
    return 42
}

valor=$(retorna)
echo $?
echo $valor


function conf(){
	dialog --title "sim" --yesno "Confirma?" 0 0
	return $?
}
#c=`fxx`
#echo $c
conf
nchoice=$?
if [ $nchoice = 0 ]; then
	echo "ok"
else
	echo "nok"
fi

