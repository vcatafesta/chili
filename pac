#!/usr/bin/bash
IFS=$' \t\n'
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

function filtro2(){
	awk '
	{
		if(match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array)){
			printf("%s %s %s %s %s %s %s", "array[1] array[2] array[3] array[4] array[5] array[6]")
		}
	}'
}

function filtro(){
	awk '
	BEGIN {}
	match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array) {
#		printf("%s %s\n", array[1], array[2] )
		print array[1], array[2]
	 }
	END 	{}'
}

pushd /var/cache/fetch/archives/ &>/dev/null

IFS='\|' read -r -d '\n' -a cand < \
		<( find "$PWD" -type f -name "*.chi.zst" -printf '%p\n' \
		|filtro )

	candidates+=("${cand[@]}")
	for i in ${candidates[*]}
	do
		echo -e ${i}
	done

	unset cand


popd &>/dev/null
