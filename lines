#!/usr/bin/bash

string='first line
        second line
        third line'

while read -r line;
do
	lines+=("$line")
	echo ${line}
done <<< "$string"

echo "============================================="

string='first line,second line,third line'
IFS=',' read -r -a array <<< "$string"
echo "${array[0]}"
for element in "${array[@]}"
do
    echo "$element"
done

for index in "${!array[@]}"
do
    echo "$index ${array[index]}"
done

echo "${array[-1]}"
echo "${array[@]: -1:1}"

echo "============================================="
a=()
while read -rd,
do
	a+=("$REPLY")
done <<<"$string,"
declare -p a;
declare -a a=([0]="Paris" [1]=" France" [2]=" Europe")

echo "============================================="
string='first line
			second line
			third line'
readarray -t lines <<<"$string"
printf "[%s]\n" "${lines[@]}"

echo "============================================="
MY_STRING="string1 string2 string3"
array=($MY_STRING)
for element in "${array[@]}"
do
    echo $element
done

echo "============================================="
#!/bin/bash
str="Paris, France, Europe"
array=()
while [[ $str =~ ([^,]+)(,[ ]+|$) ]]; do
    array+=("${BASH_REMATCH[1]}")   # capture the field
    i=${#BASH_REMATCH}              # length of field + delimiter
    str=${str:i}                    # advance the string by that length
done                                # the loop deletes $str, so make a copy if needed
declare -p array
# declare -a array=([0]="Paris" [1]="France" [2]="Europe") output...

echo "============================================="
string="1,2,3,4,5"
delimiter=","
declare -a array=($(echo $string | tr "$delimiter" " "))
for element in "${array[@]}"
do
    echo $element
done
