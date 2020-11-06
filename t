#!/usr/bin/bash

ARRAY=$(find "$PWD" -type f -name '*')
COUNT=0

for i in ${ARRAY}
do
    split -b 1M $i $i.
    (( COUNT++ ))
    echo "$COUNT): $i"
done
