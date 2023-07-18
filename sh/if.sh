#!/bin/bash

List="one two three"

for a in $List     # Splits the variable in parts at whitespace.
do
  echo "$a"
done
# one
# two
# three

echo "---"

for a in "$List"   # Preserves whitespace in a single variable.
do #     ^     ^
  echo "$a"
done
# one two three


a=23              # Simple case
echo $a
b=$a
echo $b

# Now, getting a little bit fancier (command substitution).

a=`echo Hello!`   # Assigns result of 'echo' command to 'a' ...
echo $a
#  Note that including an exclamation mark (!) within a
#+ command substitution construct will not work from the command-line,
#+ since this triggers the Bash "history mechanism."
#  Inside a script, however, the history functions are disabled by default.

a=`ls -l`         # Assigns result of 'ls -l' command to 'a'
echo $a           # Unquoted, however, it removes tabs and newlines.
echo
echo "$a"         # The quoted variable preserves whitespace.
                  # (See the chapter on "Quoting.")

exit 0


string="pano-de-trato coca-cola pepis-cola"
echo "a string tem ${#string} caracteres "
cont=0
for((i=0;$i < ${#string}; i++)){
	if [ "${string:$i:1}" == '-' ]; then
		echo "'-' encontrado na posição $i da variavel"
		cont=`expr $cont + 1`
	fi
}
echo -e "\n a string '$string' tem $cont '-' "


lDisk=0
	echo $EDITOR
if [ $lDisk -eq 0 ]; then
	echo "ok"
else
	echo "nok"
fi

#!/bin/bash

echo "$VARIAVEL" | egrep '*\-*' > /dev/null
if [ $? -ne 0 ]; then
	echo "sim"
else
	echo "nao"
fi
 

#!/bin/bash
# more http://sekysu.blogspot.com
#
# A variável
VAR=$1

# A mesma variável porém sem o "-", caso a conter  
TVAR=$( echo $VAR | sed 's/-//g' )

# Se os comprimentos forem diferentes então:
if [ "${#VAR}" -ne "${#TVAR}" ]
then
    echo 'Contem -'

else
# Caso contrário
    echo 'Não contem -'

fi

#!/bin/bash
# v0.1a
VL=$1
CLEAN=$( echo $VL | sed 's/[^-]//g' )

if [ "${#VL}" -ne "${#CLEAN}" ]
then
     echo "Contem exatamente ${#CLEAN} -"
else
     echo 'Não contem nenhum -'
fi
 

sh_functeste()
{
  echo "$FUNCNAME now executing."  # xyz23 now executing.
}

sh_functeste

echo "FUNCNAME = $FUNCNAME"        # FUNCNAME =
                                   # Null value outside a function.

N=0
((N++))
((N--))
((N+=1))
((N-=1))
