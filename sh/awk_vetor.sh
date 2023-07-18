#!/bin/bash

FIRST_COLUMN=( $(awk -F"," '(NR>1){print $1}' arquivo.csv) )

for((cont=0;cont<${#FIRST_COLUMN[@]};cont++)); do
    #mkdir ${FIRST_COLUMN[$cont]}
    echo ${FIRST_COLUMN[$cont]}
done
