#!/bin/bash

type=$(cat /var/cache/fetch/search/packages-installed)

a="zenity"

echo $type
#echo $type |  sed 's/.*zenity*// ; s/ *>.*//'
#echo $type | awk '$0 ~ /^[zenity]/'
echo $type | grep -o "tree"

