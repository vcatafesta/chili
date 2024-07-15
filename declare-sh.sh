#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

#declarando inteiros
declare -i Num
Num=2+3*4
echo $Num

unset Num
Num=$(2+3)*4
echo $Num

unset Num
declare -i Num=2*$(3+5)
echo $Num

#############################################################################

#declarando maiúsculas
declare -u Maiusc
Maiusc="converte para maiúscula"
echo $Maiusc

#############################################################################

#declarando minusculas
declare -l Minusc
Minusc="CONVERTE PARA MINUSCULA"
echo $Minusc

#############################################################################
#declarando constantes/somente leitura

declare -r Const='Constante'
echo $Const
Const="New valor" #fail
unset Const       #fail

#############################################################################

#capitalizando palavra
declare -c Nom
Nom=evili
echo $Nom # Evili
Nom=EVA
echo $Nom # Eva

declare -c Nom1
Nom1="eva DIAS"
echo $Nom1 # Eva dias

#############################################################################
#mantendo cópias de variáveis
unset a b
declare -n a=b
echo $a # 5
echo $b # 5

b=9
echo $a # 9
echo $b #

declare -f VlrTotal

function VlrTotal {
	local USD=4.81
	local EUR=5.25
	local -n Ind=$1
	bc <<<"$Ind * $2"
}

VlrTotal "$@"

declare -p a # a tem o valor de b
declare -p Nom
declare -p Var1
declare -p Var2
declare -p -c
type -a
declare -p Nom >temp
declare -p >>temp
