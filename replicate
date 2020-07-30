#!/bin/bash

function replicate(){
    for counter in $(seq 1 $2);
    do
        printf "%s" $1
    done
}
function col(){
    if [ -z "${COLUMNS}" ]; then
       COLUMNS=$(stty size)
       COLUMNS=${COLUMNS##* }
    fi
    return $COLUMNS
}
col
replicate "#" $?

