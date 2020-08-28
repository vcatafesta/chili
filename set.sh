set A B C
echo $1, $2, $3
echo $#
echo $@


if [[ -t 0 ]] # Em stdin?
then
	(($#)) || { # Passou parametro?
		uso "Não foi passado parametro"
		exit 1
	}
else
	Params=$(cat -) # Pega conteudo do stdin
fi
set $Params
