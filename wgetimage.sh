#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166


url='https://www.kernel.org'
while read; do
    wget -O /tmp/${REPLY##*/} "$url/$REPLY"
done < <(wget -qO- "$url"|grep -oP 'src="\K.*(png|jpg)(?=")')

