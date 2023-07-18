#!/usr/bin/env bash
# https://www.youtube.com/watch?v=JT5_X2Nqs4Q

# | 		Pipe  				passa a stdout de um programa para a stdin de outro
# <<[-}	Here Documents		Passa para um comando a linha interpretada até um rótulo (label)
# <<<		Here Strings		Substitui o echo CADEIA | CMD por CMD <<< CADEIA

#evite							#prefira
#echo CADEIA					cmd <<< CADEIA

Sexo=2 ; Nome=Marina; Valor=10.000,00
cat << FimTxt
	$( (( Sexo == 1 )) && echo -n Caro Senhor || echo -n Cara Senhora) $Nome
	Hoje em $(date +%d/%m/%Y) acusamos o recebimento de sua fatura no total de $Valor
FimTxt

echo "$( (( Sexo==1 )) && echo -n Caro Senhor || echo -n Cara Senhora) $Nome"
echo Hoje em "$(date +%d/%m/%Y)" acusamos o recebimenot de sua fatura no total de $Valor


if [[ -p /dev/stdin ]]
then
	echo "1-Recebi via stdin:"
	echo "$(cat -)"
else
	echo "[[ -s /dev/stdin ]] é falso"
fi

if [[ ! -t 0 ]]
then
	echo "2-Recebi via stdin :"
	echo "$(cat -)"
else
	echo "Dados? Só se for por passagem de parametros"
fi

