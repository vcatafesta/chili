(
	echo "10" ; sleep 1
	echo "# Primeira tarefa" ; sleep 1
	echo "20" ; sleep 1
	echo "# Segunda tarefa" ; sleep 1
	echo "50" ; sleep 1
	echo "Terceira tarefa" ; sleep 1
	echo "75" ; sleep 1
	echo "# Finalizando" ; sleep 1
	echo "100" ; sleep 1
) |
yad --progress \
--title="Teste zenity" \
--center \
--auto-close --auto-kill \
--text="Testando progresso..." \
--percentage=0


sleep 10s &
# Armazena o PID do programa disparado em background
pid=$!

# Via subshell verifica se o processo disparado ainda esta em execucao e vai populando a barra de progresso do Zenity
(ctd=1; while [ -d "/proc/$pid" ]; do
	echo "# Faltam $ctd segundos para fechar esta janela!"
	echo $ctd
	sleep 1
	((ctd++))
done; echo 100) | zenity --progress --percentage=0 --title='Barra de progresso' --auto-close --no-cancel
 
#!/bin/bash
# Dispara o comando a ser monitorado pela barra de progresso em background
sleep 10s &
# Armazena o PID do programa disparado em background
pid=$!

# Via subshell verifica se o processo disparado ainda esta em execucao e vai populando a barra de progresso do Zenity
(ctd=0; seg=10 ; while [ -d "/proc/$pid" ]; do
	echo "# Faltam $seg segundos para fechar esta janela!"
	echo $ctd
	sleep 1
	ctd=$(echo $((ctd+10))) ; ((seg--))
done; echo 100) | zenity --progress --percentage=0 --title='Barra de progresso' --auto-close --no-cancel 
 