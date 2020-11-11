#!/usr/bin/bash

declare -a candidates=()
declare -a whitelist=()
declare -a blacklist=()
declare -a pkg_base=()

function info(){
	dialog							\
		--title     "[debug]$0"	\
		--backtitle "\n${0}\n"	\
		--yesno     "${1}"		\
		0 0
		result=$?
		if (( $result )); then
			exit
		fi
		return $result
}

function filtro()
{
	awk '
	{
		if( match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array)){
			#print array[1], array[2], array[3], array[4], array[5], array[6]
			print array[1]
		}
	}'
}

pushd /var/cache/fetch/archives/ &>/dev/null

IFS=$'\n' read -r -d '' -a cand < \
	<( find "$PWD" -type f -name "linux*.chi.zst" -printf '%p\n' \
		|pacsort --files --key 3 --separator ' ' 	\
		|filtro "${#whitelist[*]}" "${whitelist[@]}" "${#blacklist[*]}" "${blacklist[@]}")

	candidates+=("${cand[@]}")
	info "${candidates[*]}"

	unset cand


popd &>/dev/null
