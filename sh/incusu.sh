#!/bin/bash
# Versão 1

if  grep ^$1 /etc/passwd  > /dev/null
then
    echo Usuario \'$1\' já existe
else
    if  useradd $1 2> /dev/null
    then
        echo Usuário \'$1\' incluído em /etc/passwd
    else
        echo "Problemas no cadastramento. Você é root?"
    fi
fi
