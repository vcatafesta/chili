#!/usr/bin/bash

awk -F "," '/dk9102/ { print $1,$2,$3;}' compras.csv
awk -F "," '/dk9102/ { OFS="\t"; print $1,$2,$3;}' compras.csv


awk -F "," '
	BEGIN {
		total=0;
		print "\n";
		print "Relatorio de Compras - dk9102";
		print "==============================================================";
		print "#\t\tProduto\t\tCliente\t\tData\t\tValor";
		print "==============================================================";
	}
	/dk9102/ { OFS="\t\t"; print NR,$4,$2,$6,$5; total+=$5}

	END {
		print "==============================================================";
		print "Total: R$\t\t\t\t\t\t" total;
	}
	' compras.csv

awk '
BEGIN	{ x=0 }
/^$/	{ x=x+1 }
END	{ print "I found " x " blank lines. :)" }
' compras.csv

#Filtra as linhas com o padrão especificado. Linhas que terminam com conf
ls -l /etc | awk /conf$/

#Usando outro separador de campos e imprimindo colunas
cat /etc/passwd | awk -F: '{print $1}'

#Usando separador de campos
ls -l /etc |awk '{print $1 FS $8}'

#Numerando linhas
ls -l /etc | awk '{print NR FS$1 FS $8}'

#Filtra linhas com padrão especificado e mostra apenas as colunas 1 e 8.
ls -l /etc | awk '/conf$/{print $1" "$8}'

#Imprime as linhas com mais de 3 campos. Elimina a primeira linha do ls -l (Total)
ls -l /etc | awk 'NF > 3'

#Filtra linhas com arquivos cujos nomes possuem menos de 5 caracteres
ls -l /etc | awk 'length($8) < 5'

#Imprime linhas pares
ls -l /etc | awk 'NR % 2 == 0 {print NR" "$0}'

#Substitui strings
ls -l /etc | awk '{sub(/conf$/,"test"); print $0}'

#Procura expressão em determinado campo
ls -l /etc | awk '$8 ~ /^[ae]/'

#Inserindo strings entre campos
cat /etc/passwd | awk -F: '{print "Login: " $1}'

#Filtra a saída de ls -l, a fim de mostrar o nome do arquivo, suas permissões e seu tamanho (a condição NR != 1 evita que a linha Total seja exibida):
ls -l | awk 'NR != 1{print "Nome: "$8" Perm: "$1" Tamanho: "$5}'

#Imprime o comprimento da maior linha
#awk '{ if (length($0) > max) max = length($0)}; END { print max}'; arquivo

#Imprime as linhas com mais de 42 caracteres
#awk 'length($0) > 42' arquivo

#Exibe o número de linhas do arquivo
#awk 'END { print NR }' arquivo

awk '
	BEGIN {
		print ARGC;
    if (ARGC != 2)
       print "Forneca 2 numeros\n"
    else
       {
          soma=ARGV[1]+ARGV[2]
          print "Soma = " soma
       }
	}'
