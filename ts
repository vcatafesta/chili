#!/bin/bash

# Função para posicionar o cursor
function posicionar_cursor {
  printf "\e[${2};${1}H"
}

# Função para imprimir um quadro com caracteres gráficos
function imprimir_quadro {
  local quadro_x=$1
  local quadro_y=$2
  local quadro_largura=$3
  local quadro_altura=$4

  local linha_superior=$(printf "\u250c\u2500%.0s" $(seq 1 $((quadro_largura-2))) ; printf "\u2510")
  local linha_inferior=$(printf "\u2514\u2500%.0s" $(seq 1 $((quadro_largura-2))) ; printf "\u2518")
  local linha_vertical=$(printf "\u2502%${quadro_largura}s\u2502")

  posicionar_cursor $quadro_x $quadro_y
  printf "%s" "$linha_superior"

  for ((j=1; j<quadro_altura-1; j++)); do
    posicionar_cursor $quadro_x $((quadro_y+j))
    printf "%s" "$linha_vertical"
  done

  posicionar_cursor $quadro_x $((quadro_y+quadro_altura-1))
  printf "%s" "$linha_inferior"
}

# Define a posição inicial e tamanho do quadro
pos_x=10  # Posição horizontal
pos_y=5   # Posição vertical
largura=20
altura=10

# Imprime o quadro na posição definida
imprimir_quadro $pos_x $pos_y $largura $altura

# Calcula o tamanho dos quadros menores
quadro_menor_largura=$((largura / 3))
quadro_menor_altura=$((altura / 3))

# Divide o quadro em uma grade de 9 posições
for ((i=0; i<3; i++)); do
  for ((j=0; j<3; j++)); do
    quadro_x=$((pos_x + j * (quadro_menor_largura + 1) + 1))
    quadro_y=$((pos_y + i * (quadro_menor_altura + 1) + 1))
    imprimir_quadro $quadro_x $quadro_y $quadro_menor_largura $quadro_menor_altura
  done
done
