#!/bin/bash

while getopts ":SshfF" opt; do
  case ${opt} in
    Ss )
      echo "Usage:"
      echo "    pip -h                      Display this help message."
      echo "    pip install                 Install a Python package."
      exit 0
      ;;
    h )
      echo "Usage:"
      echo "    pip -h                      Display this help message."
      echo "    pip install                 Install a Python package."
      exit 0
      ;;
    f|F )
      echo "Usage:"
      echo "    pip -h                      Display this help message."
      echo "    pip install                 Install a Python package."
      exit 0
      ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))
