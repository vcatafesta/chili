#!/usr/bin/env bash

declare +n array
unset numv simv array

declare -a numv=(uva limão maçã limão)
declare -A simv=([a]=uva [b]=limão [c]=maçã [d]=limão)

index1() {
  local -n a=array
  local s=$search
  declare -p ${!a} | grep -oP "\[\K[^]]+(?=\]=\"$s\")"
}

index2() {
  local -n a=array
  local s=$search
  for k in "${!a[@]}"; do
    echo "k=$k"
    [[ ${a[$k]} == "$s" ]] && echo $k
  done
}

search=limão
declare -n array=numv
index1
index2
echo --------
declare -n array=simv
index1
index2
