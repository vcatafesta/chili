#!/usr/bin/env bash

#para descobir o pid do bash

#gerando com linha indesejada
echo 'ps au | grep bsh'
ps au | grep bash --color=auto


#evitando a linha indesejada
echo 'ps au | grep bash | grep -v grep'
ps au | grep bash --color=auto| grep -v grep --color=auto

#mais eficiente
echo 'ps au | grep '[b]ash''
ps au | grep '[b]ash' --color=auto


