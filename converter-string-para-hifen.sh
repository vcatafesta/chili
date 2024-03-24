#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

shopt -s expand_aliases
palavra='ViewMap'

function converter_para_hifen1 {
    local palavra="$1"
    palavra_convertida=$(sed 's/[[:upper:]]/-&/g' <<< "$palavra")
    palavra_convertida=${palavra_convertida,,}
    palavra_convertida=${palavra_convertida#-}
    echo "$palavra_convertida"
}
export -f converter_para_hifen1

function converter_para_hifen2 {
	local palavra="$1"
	local palavra_convertida=""

	for ((i = 0; i < ${#palavra}; i++)); do
		if [[ "${palavra:i:1}" =~ [A-Z] ]]; then
			palavra_convertida+="-${palavra:i:1}"
		else
			palavra_convertida+="${palavra:i:1}"
		fi
	done
	palavra_convertida="${palavra_convertida,,}"
	palavra_convertida="${palavra_convertida#-}"
	echo "$palavra_convertida"
}
export -f converter_para_hifen2

function converter_para_hifen3 {
	local palavra="$1"
	palavra_convertida="${palavra//[A-Z]/-&}"
	palavra_convertida="${palavra_convertida,,}"
	palavra_convertida="${palavra_convertida#-}"
	echo "$palavra_convertida"
}
export -f converter_para_hifen3

function vitor {
	foo="$1"
	while [[ "$foo" =~ (.*[a-z0-9])([A-Z].*) ]] && foo="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"; do
		: # do nothing
	done
	echo "${foo,,}"
}
export -f vitor

function romeu {
	sed 's/[[:upper:]]/-\l&/g; s/^-//' <<<"$1"
}
export -f romeu

function vcatafesta1 {
	word="${1//[A-Z]/-&}"
	word="${word,,}"
	echo "${word#-}"
}
export -f vcatafesta1

function vcatafesta2 {
	read word <<< "${1//[[:upper:]]/-&}"
	read word <<< "${word,,}"
	echo "${word#-}"
}
export -f vcatafesta2

function bagatini {
	: $1
	: ${_//[A-Z]/-&}
	: ${_,,}
	echo ${_#*-}
}
export -f bagatini

#source /github/benshmark/v5.sh
#alias bm=benshmark-v5
#s1() { converter_para_hifen1 "$palavra"; }
#s2() { converter_para_hifen2 "$palavra"; }
#s3() { converter_para_hifen3 "$palavra"; }
#s4() { romeu "$palavra"; }
#s5() { vitor "$palavra"; }
#s6() { vcatafesta1 "$palavra"; }
#s7() { vcatafesta2 "$palavra"; }
#s8() { bagatini "$palavra"; }
#bm 1000 s{1..8}

#	--show-output \
hyperfine \
	--warmup 3 \
	--runs 1000 \
	--ignore-failure \
	--shell=bash "romeu $palavra" \
				 "vitor $palavra" \
				 "converter_para_hifen1 $palavra" \
				 "converter_para_hifen2 $palavra" \
				 "converter_para_hifen3 $palavra" \
				 "vcatafesta1 $palavra" \
				 "vcatafesta2 $palavra" \
				 "bagatini $palavra"
