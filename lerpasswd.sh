#!/bin/bash

tail -4 /etc/passwd >pw
cat pw |
while IFS=: read Usu Lixo Uid Lixo
do
    echo -e "$((++Cont))\t$Uid\t$Usu"
done; echo Li :$Cont: registros


tail -4 /etc/passwd >pw
while IFS=: read Usu Lixo Uid Lixo
do
    echo -e "$((++Cont))\t$Uid\t$Usu"
done < pw; echo Li :$Cont: registros
