#!/bin/sh
#!/bin/bash
# Usando o comando return na função
function valor {
 read -p "Digite um número entre 0 e 255: " num
 return $[ $num ]
}
valor
echo "O valor do status retornado é $?"

chaves ()
{
    local mensagem="Foi sem querer querendo..."
    local repita=3
    local i=0

    while [ $i -lt $repita ]
    do
        echo "$mensagem"
        i=$((i+1))
    done
}
chaves "$@"

function VersaoLinux () {
   /usr/bin/lsb_release -ds
}
 
CheckUser () {
   USER_ID=$(/usr/bin/id -u)
   return $USER_ID
}
 
echo "Iniciando script, aguarde..."
 
CheckUser
if [ $? -ne "0" ]; then
   echo -e "nVoce não é root, execute como super-usuario!n"
   exit 1
fi
 
# Macete para imprimir saida de funcao dentro do echo
echo -e "SO:t$(VersaoLinux)"

function VersaoLinux () {
   /usr/bin/lsb_release -ds
}
 
function CheckUser () {
   USER_ID=$(/usr/bin/id -u)
   return $USER_ID
}
 
function CheckGCC () {
   /usr/bin/gcc -v
}
 
function CheckPython () {
   /usr/bin/python --version
}
 
function CheckPerl () {
   /usr/bin/perl -v
}
 
function CheckSystem () {
 
   # Macete para imprimir saida de funcao dentro do echo
   echo -e "nn###\033[0;31m Distrubuição:\033[0mt$(VersaoLinux)"
   #echo -e "### Distribuição:t$(VersaoLinux)"
 
   echo -e "nn###\033[0;31m Processador\033[0m"
   cat /proc/cpuinfo | grep "model name"
 
   echo -e "nn###\033[0;31m Memoria\033[0m"
   /usr/bin/free -m
 
   echo -e "nn###\033[0;31m Disco\033[0m"
   /bin/df -h
}
 
function CheckOptions () {
   if [ $1 = "python" ]; then
      CheckPython
   elif [ $1 = "perl" ]; then
      CheckPerl
   elif [ $1 = "gcc" ]; then
      CheckGCC
   elif [ $1 = "system" ]; then
      CheckSystem
   elif [ $1 = "all" ]; then
      CheckSystem
      CheckGCC
      CheckPerl
      CheckPython
   else
      echo -e "$1 é uma opção invalida!"
      exit 1
   fi
 
}
 
echo "Iniciando script, aguarde..."
 
CheckUser
if [ $? -ne "0" ]; then
   echo -e "nVoce não é root, execute como super-usuario!n"
   exit 1
fi
 
while true;
do
   echo -e "### Voce deve digitar um dos parametros abaixo para obter informacoes: "
   echo -e "tpython"
   echo -e "tperl"
   echo -e "tgcc"
   echo -e "tsystem"
   echo -e "talln"
   read -p "### Opcao: " op
 
   CheckOptions $op
 
   read -p "### Continuar? (S/N) " cont
 
   if [ $cont = "N" ] || [ $cont = "n" ]; then
      echo -e "Saindo..."
      exit 1
   fi
 
   /usr/bin/clear
 
done

fxx(){

	dialog --title "sim" --yesno "Confirma?" 0 0
	return $?
}

c=`fxx`
echo $c

