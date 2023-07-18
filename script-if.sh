#!/usr/bin/env bash
echo ==================================================================
echo 'if grep -q "^$1:" /etc/passwd
then
	echo Usuário ${1^^} está cadastrado
fi'
if grep -q "^$1:" /etc/passwd
then
	echo Usuário ${1^^} está cadastrado
else
	echo Usuário ${1^^} NÃO está cadastrado
fi
echo ==================================================================
echo 'test 01 = 1; echo $? 			# test para cadeia char'
test 01 = 1; echo $? 			# test para cadeia char
echo ==================================================================
echo 'test 01 -eq 1; echo $?			# test para int'
test 01 -eq 1; echo $?			# test para int
echo ==================================================================
echo '[[ 01 = 1   ]] ; echo $? 		# test para cadeia char'
[[ 01 -eq 1 ]] ; echo $?		# test para int
echo ==================================================================
echo 'test 01 < 1; echo $?      		# Fail!'
test 01 < 1; echo $?      		# Fail!
echo ==================================================================
echo '[ 01 < 1 ]; echo $?     		# Fail!'
[ 01 < 1 ]; echo $?     		# Fail!
echo ==================================================================
echo '[[ 01 < 1 ]]; echo $?     		# Fail!'
[[ 01 < 1 ]]; echo $?     		# Fail!
echo ==================================================================
echo '[ -f arq* ]; echo $?				# FAIL -f é unário, só espera 1 arquivo'
[ -f arq* ]; echo $?					# FAIL -f é unário, só espera 1 arquivo
echo '[[ -f arq* ]]; echo $?				# FAIL -f é unário, só espera 1 arquivo'
[[ -f arq* ]]; echo $?				# FAIL -f é unário, só espera 1 arquivo
echo ==================================================================
# lib extglob
touch cepa coopera copa copo cpu
echo c*(o)p*	# c, zero ou mais o, um p e qualquer coisa
ls c+(o)p*		# c, um ou mais o, um p e qualquer coisa
ls c@(o|e)p*	# c, um o, ou e, um p e qualquer coisa
echo c?(o)p*	# c, um o opcional, um p e qualquer coisa
echo ==================================================================
Var=shell
echo ${Var^}	# Shell
echo ${Var^^}	# SHELL
echo ==================================================================
if [[ ${Resp^^} == @(S|SIM|Y|YES) ]]
then
	echo Aceito
else
	echo Dançou cara!
fi
echo ==================================================================
if [[ $1 =~ ([01][0-9]|2[0-3]):[0-5][0-9] ]]
then
	echo hora correta
else
	echo hora inválida
fi
echo ==================================================================
