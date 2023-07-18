#!/usr/bin/env bash

sh_checkdepstype1()
{
	declare -A deps
	deps[banana]=fruta-populares
	deps[laranja]=fruta-citricas
	deps[abacate]=fruta-pseudofruto
	deps[dialog1]=dialog-1:1.3_20220414-1

	declare -a missing

	for d in "${!deps[@]}"; do
		[[ -z $(command -v $d) ]] && missing+=(${deps[$d]}) && printf "Falta o pacotes: ${deps[$d]}\n"
	done
	#[[ ${#missing[@]} -ne 0 ]] && printf "Faltam os pacotes: ${missing[@]}\n" && exit 1
	[[ ${#missing[@]} -ne 0 ]] && exit 1
	printf "Tudo certo!"
	exit 0
}

sh_checkdepstype2()
{
	declare -a deps=('banana' 'laranja' 'abacate' 'dialog')
	declare -a missing

	for d in "${deps[@]}"; do
		[[ -z $(command -v $d) ]] && missing+=($d) && printf "Falta o pacotes: $d\n"
	done
	[[ ${#missing[@]} -ne 0 ]] && exit 1
	printf "Tudo certo!"
	exit 0
}

sh_checkdepstype2
