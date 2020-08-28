#!/bin/bash4

test_char ()
{
for i in "$@"; do
	case "$i" in
    	# The ;;& terminator continues to the next pattern test.      |
	   	[[:upper:]]	)	echo "($i) letras maiúsculas";;&
	    [[:lower:]]	)	echo "($i) letras minusculas";;&
	    [[:alpha:]]	)	echo "($i) letras maisculas e minusculas";;&
	    [[:digit:]]	)	echo "($i) digitos";;&
	    [[:xdigit:]])	echo "($i) digitos hexadecimal";;&
	    [[:word:]]	)	echo "($i) caracteres de palavra (letras numero e sublinhados)";;&
	    [[:alnum:]]	)	echo "($i) digitos, letras maisculas e minusculas";;&
	    [[:punct:]]	)	echo "($i) pontuação(todos os caracteres graficos, exceto letras e digitos)";;&
	    [[:blank:]]	)	echo "($i) espacos e caracteres TAB apenas";;&
	    [[:space:]]	)	echo "($i) caracters em branco (espaco em branco)";;&
	    [[:cntrl:]]	)	echo "($i) caracteres de controle";;&
	    [[:graph:]]	)	echo "($i) caracteres imprimiveis";;&
	    [[:print:]]	)	echo "($i) imprimiveis e espaco";&
    	# The ;& terminator executes the next statement ...         # |
    	%%%@@@@@    )  echo "********************************";;    # v
		#   ^^^^^^^^  ... even with a dummy pattern.
	esac
	printf ===============================================================================================
	echo
done
}

#test_char 3
#test_char m
#test_char /
[[ $# -eq 0 ]] && echo "Usage: testchar a b c +"
test_char "$@"
