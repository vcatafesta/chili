#!/usr/bin/bash

echo "1 2 3 4 5 6 7 8 9" | awk '{for(n=5;n<NF;n++) print $n}'

