#!/usr/bin/env bash

while IFS= read -r linha || [[ -n "$linha" ]]; do
    echo "$linha"
    # faça algo mais interessante aqui...
done < "$1"
