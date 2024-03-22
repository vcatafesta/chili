#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

shopt -s expand_aliases

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

#palavra='ViewMap'
#source /github/benshmark/v5.sh
#alias bm=benshmark-v5
#s1() { converter_para_hifen1 "$palavra"; }
#s2() { converter_para_hifen3 "$palavra"; }
#s3() { romeu "$palavra"; }
#s4() { vitor "$palavra"; }
#bm 100 s{1..4}

#	--show-output \
hyperfine \
	--warmup 3 \
	--runs 100 \
	--ignore-failure \
	--shell=bash "romeu $palavra" \
				 "vitor $palavra" \
				 "converter_para_hifen1 $palavra" \
				 "converter_para_hifen2 $palavra" \
				 "converter_para_hifen3 $palavra"
