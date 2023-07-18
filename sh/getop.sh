#!/bin/bash
function Uso
{
    echo "    $Coment
    Uso: $0 -f -C -u parâmetro" >&2
    exit 1
}
(($#==0)) && { Coment="Faltou parâmetro"; Uso; }

printf "%29s%10s%10s%10s%10s\n" Comentário Passada Char OPTARG OPTIND
while getopts ":fu:C" VAR
do
    case $VAR in
        f) Coment="Achei a opção -f"
           ;;
        u) Coment="Achei a opção -u $OPTARG"
           ;;
        C) Coment="Achei a opção -C"
           ;;
       \?) Coment="Achei uma opção invalida -$OPTARG"
           Uso
           ;;
        :) Coment="Faltou argumento da opção -u"
    esac
    printf "%30s%10s%10s%10s%10s\n" "$Coment" $((++i)) "$VAR" \
"$OPTARG" "$OPTIND"
done
