#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

# uso: ./expansao-var.sh ivo "viu vovó"

echo 'Usando $*'
Parm=1; for i in $*; { echo Parâmetro $((Parm++)) -- $i; }
echo "========================="

echo 'Usando $@'
Parm=1; for i in $@; { echo Parâmetro $((Parm++)) -- $i; }
echo "========================="

echo 'Usando "$*"'
Parm=1; for i in "$*"; { echo Parâmetro $((Parm++)) -- $i; }
echo "========================="

echo 'Usando "$@"'
Parm=1; for i in "$@"; { echo Parâmetro $((Parm++)) -- $i; }
echo "========================="