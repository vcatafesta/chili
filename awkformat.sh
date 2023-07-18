#!/usr/bin/env bash

echo "OrclLog,1: Number of rows inserted on the current node: 66." | grep -E -o '[0-9]+' | xargs | awk '{printf("%d\n", $2)}' 
echo "OrclLog,1: Number of rows inserted on the current node: 66." | grep -E -o '[0-9]+' | xargs | awk '{printf("%04d\n", $2)}' 


