#!/usr/bin/bash

# A string with command options
options=$@

# An array with all the arguments
arguments=($options)

# Loop index
index=0

for argument in $options
  do
    # Incrementing index
    (( index++ ))

    # The conditions
    case $argument in
      -Sl) echo "key: $argument value: ${arguments[index]}" ;;
      -a) echo "key $argument value ${arguments[index]}" ;;
      -abc) echo "key $argument value ${arguments[index]}" ;;
    esac
  done

exit;
