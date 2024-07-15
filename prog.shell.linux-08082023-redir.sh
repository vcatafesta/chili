#!/usr/bin/env bash

while IFS=: read Uname lx Uid lx; do
	echo -e "$((++Seq))\t$Uid\t$Uname"
done </etc/passwd
echo O arquivo /etc/passwd tem ==$Seq== registros
