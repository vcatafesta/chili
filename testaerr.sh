#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

function Erro {
	echo "Error: $0($1) Ret=$2"
}
trap 'Erro $LINENO $?' ERR
grep 'não existe' /etc/passwd
