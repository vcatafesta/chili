#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

if grep -q ^$1 /etc/passwd;
then echo Pode entrar
else echo Barrado no baile
fi
