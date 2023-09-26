#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

if [[ $# -eq 0 ]]; then
  echo "Uso: $0 comando"
  exit 1
fi

comando="$1"
shift

# Verifica se o comando existe
if ! command -v "$comando" &> /dev/null; then
  echo "Comando '$comando' não encontrado."
  exit 1
fi

# Executa o comando com pkexec
pkexec "$comando" "$@"


