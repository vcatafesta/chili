#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166


SYMBOLS=""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
SYMBOLS=$SYMBOLS'!@#$%^&*()?/\[]{}-+_=<>.,'

PWD_LENGTH=16
PASSWORD=""
RANDOM=256
for i in `seq 1 $PWD_LENGTH`
do
    PASSWORD=$PASSWORD${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
done
echo $PASSWORD