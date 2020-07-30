#!/usr/bin/env bash

sd=/dev/sda

fdisk -l $sd                    \
| grep "$sd[0-9]"               \
| awk '{print $1,$5,$6,$7}'     \
| sed 's/ /_/'g                 \
| sed 's/.//10'                 \
| sed 's/./& /9'

