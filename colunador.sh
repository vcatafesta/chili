#!/bin/bash
#  Recebe dados via pipe, arquivo ou passagem de parâmetros e
#+ os coloca em coluna numerando-os

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
