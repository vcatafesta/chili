function Uso()
{
	# Dá msg de erro para stderr e aborta passando codigo de erro.
	# Recebe como parâmetros: msg de erro e código de erro ($?)

	echo $0: "$1" >&2		# Redirecionando a msg de erro para stderrr
	[[ -t 2 ]] && read -n1	# Só dá uma parada se stderr não está sendo descartada.
	exit $2					# Encerra o programa passando o código de erro.
};	export -f Uso

