#!/bin/bash

# Chat usando Shell e Zenity 
# Copyright 2009 Lucas Mazzardo Veloso <lmveloso#gmail-com>
#
# This is a Free Software relized under the terms of
# the GNU-GPL: http://www.gnu.org/licenses/gpl-3.0.html
#
# Contribuições: Julio Neves e José Roberto Andrade

Apelido=$(zenity --entry \
  --title "Captura de Apelido" \
  --text  "Informe o seu Apelido para usar no bate-papo:" \
  --entry-text $LOGNAME \
  --window-icon z.svg )
[[ "$Apelido" ]] || exit 1

# Abre o zenity notification em 5 e text info em 6
exec 5> >(zenity --notification --listen --window-icon z.svg >/dev/null 2>&1 ) 
exec 7> >(zenity --text-info --window-icon z.svg --width=400 --height=300 )
exec 8> >(xargs -i bash -c "echo 'message:{}' >&5 ; echo '{}' >&7;" )

# Abre o netcat server/client em 6 e conectar a saída padrao em 5
[ "$1" ] && {
  title=CLIENTE;
  exec 6> >(nc $1 7777 >&8 )
} || {
  title=SERVIDOR
  exec 6> >(nc -lp 7777 >&8 )
}

echo " * Bem Vindo ao Zenitalk * " >&7
sleep 1

# Mostra o Diálogo de Mensagens
while msg=$(zenity --entry   --window-icon z.svg           \
    --title "Voce é o $title - Zenitalk"                   \
    --text "Escreva a sua Mensagem"                        \
    && pidof nc > /dev/null 2>&1 )
do
    # Escreve a saida para o descritor do netcat
    [ "$msg" ] && { 
       echo "<$Apelido>: $msg" >&6 
       echo "<Você>: $msg" >&7
     }
done
echo " * Bate-Papo Encerrado * " >&7
exec 8>&-
exec 7>&-
exec 6>&-
exec 5>&-
pidnc=`pidof nc`
[ "$pidnc" ] && kill -INT $pidnc

