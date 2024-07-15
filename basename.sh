#!/usr/bin/env bash

echo 'Prog=/var/cache/fetch/script.sh'
Prog=/var/cache/fetch/script.sh

echo 'basename $Prog'
basename $Prog

echo 'echo ${Prog##*/}'
echo ${Prog##*/}

echo 'dirname $Prog'
dirname $Prog

echo 'echo ${Prog%/*}'
echo ${Prog%/*}

echo 'time for ((i=1; i<2000; i++)) { basename $Prog > /dev/null; }'
time for ((i = 1; i < 2000; i++)); do basename $Prog >/dev/null; done

echo 'time for ((i=1; i<2000; i++)) { echo ${Prog##*/} > /dev/null; }'
time for ((i = 1; i < 2000; i++)); do echo ${Prog##*/} >/dev/null; done

echo 'time for ((i=1; i<2000; i++)) { : ${Prog##*/}; }; echo $_'
time for ((i = 1; i < 2000; i++)); do : ${Prog##*/}; done
echo $_
