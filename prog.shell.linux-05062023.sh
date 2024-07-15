#!/usr/bin/env bash
#Programação Shell Linux: Paralelismo de Processos

#time echo {1..6} | xargs -t sleep
#time echo {1..6} | xargs -n1 -t sleep
#time echo {1..6} | xargs -n1 -tP0 sleep

# {} Dados da entrada
# {#} Número do processo
# {%} Número da CPU (core)
# {.} Tira a extensão da entrada
# {/} Equivalente ao basename
# {//} Equivalente ao dirname

seq 3 -1 1 |
	parallel sleep {}\; echo {} {#} {%}

ls *.jpg |
	parallel --dryrun convert {} {.}.png

find . -type f \( -name \*.csv -o -name \*.txt \) 2>&- |
	parallel gzip
