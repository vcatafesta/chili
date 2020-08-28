#!/bin/bash 
#  Executa uma sessão de gedit como root.
#+ O gksudo para pegar rapidamente a senha de root
#+ caso o tempo de sudo tenha expirado.
#+ O comando executado pelo gksudo não produz nada
#+ isso foi feito para o sudo da linha seguinte ganhar
#+ o privilégio de root, sem pedir senha pela
#+ linha de comando, o que complicaria.

gksudo -u root -k -m "Informe sua senha" true 
sudo gedit $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
