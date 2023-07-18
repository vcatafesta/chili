#!/usr/bin/env bash
# lowUpCamel.sh

toLower() {
  echo "${*,,}"
}

toUpper() {
  echo "${*^^}"
}

camelCase() {
  local array=( ${*,,} )      # 1. tudo minúsculo. OBS: sem "aspas"
  local string="${array[*]^}" # 2. primeiras letras maiúsculas
  echo "${string// /}"        # 3. remove espaços
}
