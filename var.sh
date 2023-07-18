#!/usr/bin/env bash

true=0
false=1

if ( cat /etc/passwd ); then
	echo "Result: " $true
else
	echo "Result: " $false
fi

#ou

result=$(cat /etc/passwd)
[ $? = $true ] && echo "Result: ok" || echo "Result: nok"
