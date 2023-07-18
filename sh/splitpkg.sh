#!/usr/bin/bash

file='zziplib-lib-0.13.71-1-x86_64.chi.zst'
pkg_re='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst'

#echo $file | grep -Po '(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst'

arr=($(echo $file | awk 'match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array) {
    print array[0]
    print array[1]
    print array[2]
    print array[3]
    print array[4]
    print array[5]
    print array[6]
}'))

echo "*******************************"
for i in $arr
do
	echo $i
done
echo
echo "*******************************"
echo "bloco 0: ${arr[0]}"
echo "bloco 1: ${arr[1]}"
echo "bloco 2: ${arr[2]}"
echo "bloco 3: ${arr[3]}"
echo "bloco 4: ${arr[4]}"
echo "bloco 5: ${arr[5]}"
echo "bloco 6: ${arr[6]}"

echo "${@:5}"
