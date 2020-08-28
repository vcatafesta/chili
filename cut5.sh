#!/bin/bash
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
           ;;
        :) Coment="Faltou argumento da opção -u"
    esac
    printf "%30s%10s%10s%10s%10s\n" "$Coment" $((++i)) "$VAR" "$OPTARG" "$OPTIND"
done

