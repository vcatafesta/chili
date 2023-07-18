#!/usr/bin/env bash

set {A..K}
echo $11 		#	A1
echo ${11} 		#	K

Fruta=abacaxi
sed 'y/ai/AI/' <<< $Fruta

time for ((i=1; i<2000; i++)); { sed 'y/ai/AI/'	<<< $Fruta > /dev/null; }
time for ((i=1; i<2000; i++)); { tr 'ai' 'AI'	<<< $Fruta > /dev/null; }

