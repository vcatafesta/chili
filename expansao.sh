#!/usr/bin/env bash

Var=teste
echo ${Var^}  # 1 letra maiscula
echo ${Var^^} # todas maisculas
echo ${Var,}  # 1 letra minuscula
echo ${Var,,} # todas minusculas

echo ${Var^t}  # troca somente o 1 t para maiscula
echo ${Var^^t} # troca todoas os t para maiscula
echo ${Var^^e} # troca todoas os e para maiscula

Nome='vilmar catafesta'
echo ${Nome^^[vc]}

Var=PIRARUCU
echo ${Var,,[RU]}

${PARM:-CADEIA} # caso haja : se estiver vazia ou não nao definiida
${PARM-CADEIA}  # caso nao haja : a expansao se dará somente se não existir

read -p "Login ($LOGNAME):" User
User=${User:-$LOGNAME}

unset $Var
echo ${Var-Variável nao definida}
echo ${Var:-Variável nao definida}
Var=
echo ${Var-Variável nao definida}
echo ${Var:-Variável nao definida}

SO=Linux
echo System Name $SO ${Sh:+ e Shell $Sh}
Sh=Bash
echo System Name $SO ${Sh:+ e Shell $Sh}

: ${NLINES?Falta informar parametro}
echo "A tela tem $NLINES linhas"
