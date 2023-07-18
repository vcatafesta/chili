#!/usr/bin/env bash

#neste caso, só imprimir linhas que estejam duplicadas, 2 ou +
awk 'dup[$4]++ {print $0}' dados.txt
