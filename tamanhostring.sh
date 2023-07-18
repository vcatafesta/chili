#!/usr/bin/env bash

Cad="Onça"

echo 'echo $Cad | wc -c'
echo $Cad | wc -c
# 6

echo 'echo $Cad | wc -m'
echo $Cad | wc -m
# 5

echo 'echo -n $Cad | wc -m'
echo -n $Cad | wc -m
#4

echo 'echo echo ${#Cad}'
echo ${#Cad}
#4

#medicoes
echo 'time for ((i=1; i<2000; i++)) { echo -n $Cad | wc -m > /dev/null; }'
time for ((i=1; i<2000; i++))	{ echo -n $Cad | wc -m > /dev/null; }
echo 'time for ((i=1; i<2000; i++)) { echo ${#Cad} > /dev/null; }'
time for ((i=1; i<2000; i++))	{ echo ${#Cad} > /dev/null; }
echo 'time for ((i=1; i<2000; i++))	{ : ${#Cad}; } ; echo $_'
time for ((i=1; i<2000; i++))	{ : ${#Cad}; } ; echo $_


