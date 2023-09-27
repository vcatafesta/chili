#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

# uso : parafuso.sh $!

: ${1?Falta o PID a monitorar}
tput civis
trap "tput cnorm; exit" 0 2 3 15
echo -ne "\t\t"
while kill -0 $1 2>&-; do
	for i in \| \/ \- \\ \| \/ \- ; do
		echo -en "\b$i"
		sleep 0.2
	done
done


#head -c 32 /dev/random | xxd -p > /dev/null | dd if=/dev/null of=/dev/sdX
O comando que você forneceu parece conter uma sequência de operações e redirecionamentos de entrada e saída.
No entanto, há um erro na estrutura do comando. Vou descrever as partes do comando que fazem sentido e explicá-las:

head -c 32 /dev/random: Este comando gera 32 bytes de dados aleatórios a partir do dispositivo especial /dev/random no Linux. O comando head é usado para limitar a saída ao número especificado de bytes (32, neste caso).
Isso cria uma sequência de bytes aleatórios.

xxd -p: Este comando é usado para converter a saída dos 32 bytes aleatórios em representação hexadecimal.
Portanto, os 32 bytes aleatórios gerados anteriormente serão convertidos em uma sequência hexadecimal.

> /dev/null: Este redirecionamento de saída > está redirecionando a saída hexadecimal resultante para
o dispositivo /dev/null. Isso significa que a saída não será exibida no terminal, mas será descartada.

Aqui é onde ocorre o erro:
4. | dd if=/dev/null of=/dev/sdX: Este comando está tentando usar a saída do comando anterior
(que foi redirecionada para /dev/null) como entrada para o comando dd, que é usado para copiar dados de um local para outro. No entanto, if=/dev/null não faz sentido, pois /dev/null é um dispositivo especial que representa uma "lixeira" vazia.

Se a intenção original do comando era copiar os 32 bytes aleatórios para um dispositivo de bloco (por exemplo,
uma unidade de armazenamento representada por /dev/sdX), então o comando deveria ser algo como:

#head -c 32 /dev/random | dd of=/dev/sdX
