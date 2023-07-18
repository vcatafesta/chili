#!/usr/bin/env bash

if [[ ! -t 0 ]]; then   				# Verdadeiro se entrada vier do terminal
	echo "recebi pelo stdin: $(cat -)"		# - é o conteudo do stdin
else
	echo "Nada recebi via stdin"
fi

