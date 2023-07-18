#!/usr/bin/env bash

echo $((2#1111))							# 2# - base 2 (binário)
echo $((017))								# mas tambem poderia ser $((8#17))
echo $((0xF))								# inicia com 0x = base 16 (hexa) ou ((16#F))
echo $((2#1111+017+0xF))				# misturou tudo
Int=4; let Int=Int**3; echo $Int
declare -i Num=(3+2)*6; echo $Num 	# Declarar como numerico, só começar a fazer conta nem precisa de (())
Num=Num*2; echo $Num

