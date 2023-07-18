#!/usr/bin/env bash

if [[ -p /dev/stdin ]]; then   				# -p arquivo tipo naned pipe
	echo "recebi pelo pipe: $(cat -)"		# - é o conteudo do stdin
else
	echo "o teste foi falso. nada recebi via pipe"
fi

