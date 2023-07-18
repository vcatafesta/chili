#!/bin/bash
#  Recebe dados via pipe, arquivo ou passagem de parâmetros e
#+ os coloca em coluna numerando-os

# exemplo uso: echo {A..Z} | ./colunador

if  [[ -t 0 ]]        # Testa se tem dado em stdin
then
	(($# == 0)) || {  # Testa se tem parâmetro
		echo Passe os dados via pipe, arquivo ou passagem de parâmetros >&2  # Redirecionando para stderr
		exit 1
	}
	Parms="$@"
else
    Parms=$(cat -)    # Seta parâmetros com conteúdo de stdin
fi

set $Parms
for ((i=1; i<="$#"; i++))
{
    Lista=$(for ((i=1; i<="$#"; i++)); { printf "%0${##}i %s\n" $i "${!i}"; })
}
echo "$Lista" | column -c $(tput cols)


# 1. A quase totalidade dos utilitários do Shell, aceitam o hífen como
# representando os dados recebido de stdin. Veja isso:

#$ cat arq
#Isto é um teste
#Outra linha de teste
#$ echo Inserindo uma linha antes de arq | cat - arq
#Inserindo uma linha antes de arq
#Isto é um teste
#Outra linha de teste

#Ou seja, o comando primeiramente listou o que recebeu da entrada primária e em seguida o arquivo arq.

# 2. O outro macete é o comando set. Para entendê-lo vá para o prompt e faça:

#$ set a b c
#$ echo $1:$2:$3
# a:b:c
