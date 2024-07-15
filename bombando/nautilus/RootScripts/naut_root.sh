#!/bin/bash
#  Executa uma sessão de Nautilus como root
#+ O gksudo para pegar rapidamente a senha de root
#+ caso o tempo de sudo tenha expirado.
#+ O comando executado pelo gksudo é um echo vazio.
#+ isso foi feito para o sudo da lina seguinte ganhar
#+ o privilégio de root, sem pedir senha pela
#+ linha de comando, o que complicaria.

gksudo -u root -k -m "Informe sua senha" echo
sudo nautilus --no-desktop $NAUTILUS_SCRIPT_CURRENT_URI
