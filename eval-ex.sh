#!/usr/bin/env bash
barra=\|

echo '# ls $barra wc -l  			#fail'
ls $barra wc -l #fail

echo '# eval ls $barra wc -l  	#OK - resolve primeiro a variável para depois executar o comando'
eval ls $barra wc -l #OK - resolve primeiro a variável para depois executar o comando

echo '# num=5'
echo '# echo {1..$num}				#fail'
echo '# eval echo {1..$num}		#OK'
num=5
echo {1..$num}      #fail
eval echo {1..$num} #OK

data_hoje="date"
data_param="+%s"
echo '$data_hoje' '$data_param'
eval '$data_hoje' '$data_param'
eval echo '$data_hoje' '$data_param'

echo
echo 'c="echo"; a1="olá"; a2="mundo"'
echo 'eval $c $a1 $a2'
c="echo"
a1="olá"
a2="mundo"
eval $c $a1 $a2

echo
echo 'Cd="cd Desktop"'
echo 'eval $Cd'
Cd="cd Desktop"
eval $Cd

echo
cat >department.txt <<'EOF'
CSE
EEE
ETE
INGLÊS
BBA
FARMACIA
# end department.txt
EOF

echo 'mycommand="wc -l department.txt"'
echo 'eval $mycommand'
mycommand="wc -l department.txt"
eval $mycommand
rm department.txt

echo
x=5
y=15
# A primeira variável de comando é usada para atribuir o comando `expr` para adicionar os valores de $x e $y
calculo="$(expr $x + $y)"
# A segunda variável de comando é usada para atribuir o comando `echo`
print="echo"
# `eval` irá calcular e imprimir a soma de $x e $y executando os comandos das variaveis $c1 e $c2
eval $print $calculo
