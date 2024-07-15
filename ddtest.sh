#!/bin/bash

echo "Cria o arquivo de teste"
dd if=/dev/zero of=/tmp/drall_infile count=1175000

for bs in 1k 2k 4k 8k 16k 32k 64k 128k 256k 512k 1M 2M 4M 8M; do
	echo "Testando tamanho de bloco (BS) = $bs"
	dd if=/tmp/drall_infile of=/tmp/drall_outfile bs=$bs
	echo ""
done
rm /tmp/drall_infile /tmp/drall_outfile
