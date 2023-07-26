#!/usr/bin/env bash
# mvlower.sh

mvLower() {
  local filepath
  local dirpath
  local filename

  for filepath in "$@"; do
    # OBS: temos que preservar o path do diretório!
    dirpath=$(dirname "$filepath")
    filename=$(basename "$filepath")
    mv "$filepath" "${dirpath}/${filename,,}"
  done
}

mvLower "$@"
