#!/usr/bin/env bash


#pegar da 2 a 4 linha de um arquivo
seq 10 | sed -n '2,4p'

echo

unset Cont; seq 10 | while read num; do
		((++Cont >= 2 && Cont <= 4 )) && echo $num
	done

echo

seq 10 | cut -f2-4 -d$'\n'
