#!/usr/bin/env bash

# Início da contagem de tempo
start_time=$(date +%s)

# Executar a tarefa ou comando
# Exemplo: executar um script chamado "meu_script.sh"
./meu_script.sh

# Fim da contagem de tempo
end_time=$(date +%s)

# Calcular o tempo gasto
duration=$((end_time - start_time))

# Converter para formato HH:MM:SS
hours=$((duration / 3600))
minutes=$(( (duration % 3600) / 60))
seconds=$((duration % 60))

# Formatar os valores para terem sempre dois dígitos
hours=$(printf "%02d" $hours)
minutes=$(printf "%02d" $minutes)
seconds=$(printf "%02d" $seconds)

# Exibir o tempo gasto no formato HH:MM:SS
echo "Tempo gasto: $hours:$minutes:$seconds"
