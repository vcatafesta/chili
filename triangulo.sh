#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

altura=20

for ((i=1; i<=altura; i++)); do
    printf "%*s" $((altura-i))
    printf "%s" $(printf '#%.0s' $(seq 1 $((2*i-1))))
    echo    # Nova linha
done


