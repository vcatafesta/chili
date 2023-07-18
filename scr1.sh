#!/usr/bin/env bash

metodo1()
{
	echo [0-9][0-9][0-9][0-9]*.txt |
	while read Arq
	do
		Dir=$(cut -c1-4 <<< $Arq)
		[[ -d $Dir ]] || mkdir $Dir
		cp $Arq $dir
	done
}

metodo2()
{
	echo [0-9][0-9][0-9][0-9]*.txt |
	while read Arq
	do
		Dir=${Arq:0:4}
		[[ -d $Dir ]] || mkdir $Dir
		cp $Arq $dir
	done
}

metodo3()
{
	ls [0-9][0-9][0-9][0-9]*.txt | cut -c-4 | uniq |
		xargs -i bash -c "[[ -d {} ]] || mkdir {}; mv {}*.txt {}"
}

metodo3




