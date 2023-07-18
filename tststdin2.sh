#!/usr/bin/env bash

if [[ -s /dev/stdin ]]; then   				# -s /dev/stdin tem tamanho > zero
	echo "recebi pelo stdin: $(cat -)"		# - é o conteudo do stdin
else
	echo "[[ -s /dev/stdin ]] é false"
fi

