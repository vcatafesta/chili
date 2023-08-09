#!/usr/bin/env bash

echo 'echo pe{itu,la,ga}da'
echo pe{itu,la,ga}da
# result: peituda pelada pegada

echo
echo 'Silaba=la'
echo 'echo pe{itu,$Silaba,ga}da'
Silaba=la
echo pe{itu,$Silaba,ga}da
# result : peituda pe pegada

echo '#na primeira passada do eval, ele vai trocar $Silaba por la e tirar as contra-barras \'
echo '#e na segunda passada ele vai expandir as chaves'
echo 'eval echo pe\{itu,$Silaba,ga\}da'
eval echo pe\{itu,$Silaba,ga\}da
# result: peituda pelada pegada

echo
echo 'echo {8..2..2}'
echo {8..2..2}
#result 10 8 6 4 2

echo 'Maior=10; Menor=02; Passo=2;'
echo 'echo {$Maior..$Menor..$Passo}'
Maior=10; Menor=02; Passo=2;
echo {$Maior..$Menor..$Passo}
# result: {10..2..2}

echo 'eval echo {$Maior..$Menor..$Passo}'
eval echo {$Maior..$Menor..$Passo}
#result 10 08 06 04 02







