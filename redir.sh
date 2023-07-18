#!/usr/bin/env bash

while read Nome Sexo Valor
do
	sendmail <<- FimMail
		Documentos
	FimMail
done < arquivo-de-emails.txt

echo CADEIA | grep DE
grep DE <<< CADEIA

echo Marina 4 | read Nome Idade
read Nome Idade <<< "Marina 4"

echo $lista | tr ' ' '\n'
tr ' ' '\n' <<< "$lista"

echo "$exemp" | wc -L
wc -L <<< "$exemp"

echo $BASHPID; : | echo $BASHPID

#forma errada
echo -- teste de msgs de erro ---
(($# == 0)) && {
	echo Uso: $0 Parâmetros
	#exit 1;
}

#forma correta
echo -- teste de msgs de erro ---
(($# == 0)) && {
	echo Uso: $0 Parâmetros >&2
	#exit 1;
}

#tratamento de erros
rm talvez
rm talvez 2> /dev/null
rm talvez 2>&- #10% mais rápido
script.sh > log 2> log
script.sh > log 2>&1
script.sh >& log
script.sh &> log

ls talvez 2>&1 | cut -f2 -d:
ls talvez |& cut -f2 -d:

