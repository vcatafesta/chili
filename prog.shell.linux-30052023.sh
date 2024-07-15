#!/usr/bin/env bash

set {A..K}
echo $11   #	A1
echo ${11} #	K

Fruta=abacaxi
sed 'y/ai/AI/' <<<$Fruta

time for ((i = 1; i < 2000; i++)); do sed 'y/ai/AI/' <<<$Fruta >/dev/null; done
time for ((i = 1; i < 2000; i++)); do tr 'ai' 'AI' <<<$Fruta >/dev/null; done
