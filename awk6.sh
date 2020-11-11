#!/usr/bin/bash

file='zziplib-lib-0.13.71-1-x86_64.chi.zst'
pkg_re='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst'

arr=$(echo $file | awk 'match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array) {
echo $arr
    print array[1]
    print array[2]
    print array[3]
    print array[4]
    print array[5]
    print array[6]
}')

echo "*******************************"
for i in $arr
do
	echo $i
done
