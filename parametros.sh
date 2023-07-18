#!/usr/bin/env bash

IFS=$' \t\n'

echo "set -- a b 'c d' e"
set -- a b 'c d' e

echo 'printf '%s\n' $@'
printf '%s\n' $@
# a
# b
# c
# d
# e

echo
echo 'printf '%s\n' $*'
printf '%s\n' $*
# a
# b
# c
# d
# e

echo
echo 'printf '%s\n' "$@"'
printf '%s\n' "$@"
# a
# b
# c d
# e

echo
echo 'printf '%s\n' "$*"'
printf '%s\n' "$*"
# a b c d e

echo
echo 'IFS="-"'
IFS='-'

echo 'printf '%s\n' "$@"'
printf '%s\n' "$@"

echo
echo 'printf '%s\n' "$*"'
printf '%s\n' "$*"
# a-b-c d-e
IFS=$' \t\n'
