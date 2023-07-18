#!/usr/bin/env bash

largura=20
altura=10

# Imprime linha superior
printf "+"
for ((i=0; i<largura; i++)); do
  printf "-"
done
printf "+\n"

# Imprime linhas intermediárias
for ((j=0; j<altura; j++)); do
  printf "|"
  for ((i=0; i<largura; i++)); do
    printf " "
  done
  printf "|\n"
done

# Imprime linha inferior
printf "+"
for ((i=0; i<largura; i++)); do
  printf "-"
done
printf "+\n"

#!/bin/bash

largura=20
altura=10

# Imprime linha superior
printf "\u250c"  # Canto superior esquerdo
for ((i=0; i<largura; i++)); do
  printf "\u2500"  # Linha horizontal
done
printf "\u2510\n"  # Canto superior direito

# Imprime linhas intermediárias
for ((j=0; j<altura; j++)); do
  printf "\u2502"  # Linha vertical
  for ((i=0; i<largura; i++)); do
    printf " "  # Espaço em branco
  done
  printf "\u2502\n"  # Linha vertical
done

# Imprime linha inferior
printf "\u2514"  # Canto inferior esquerdo
for ((i=0; i<largura; i++)); do
  printf "\u2500"  # Linha horizontal
done
printf "\u2518\n"  # Canto inferior direito


