#!/usr/bin/env bash

#Extract the rightmost substring of a character expression
#Syntax
# right <cString> <nLen> --> cReturn
# right 'vcatafesta' 1
# right 'vcatafesta' 15
# right 'vcatafesta' -1
right()
{
	local cString=$1
	local -i nLen=$2
	local -i i
	local -i nMaxLen=${#cString}

	[[ $nLen -eq -1       ]] && nLen=nMaxLen
	[[ $nLen -gt $nMaxLen ]] && nLen=nMaxLen
	i=${#cString}-$nLen
	echo ${cString:$i:$nLen}
}

#Returns size of a string
# Syntax
# len <cString> --> <nLength>

len()
{
	local cString=$1
	echo ${#cString}
}

#examples
right 'vcatafesta' 1 	# a
right 'vcatafesta' 15 	# vcatafesta
right 'vcatafesta' -1 	# vcatafesta

cstr=$(right 'vcatafesta' 3)
echo $cstr 					# sta

nlen=$(len $(right 'vcatafesta' 3))
echo $nlen 					# 3

