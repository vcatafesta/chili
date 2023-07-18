#!/usr/bin/env bash
#
# Require: xbps-install -S bc geoip geoip-data geoipupdate

declare -a arr=(
		#EU: Finland
		"repo-fi.voidlinux.org" 		\
		#USA: Chicago
		"mirrors.servercentral.com"	\
		#USA: Kansas City
		"repo-us.voidlinux.org"			\
		#EU: Germany
		"repo-de.voidlinux.org" 		\
		#USA: California
		"mirror.vofr.net"					\
		#USA: Kentucky
		"mirror2.sandyriver.net"		\
		#USA: New York
		"mirror.clarkson.edu" 			\
		#BR - Ouro Preto
		"voidlinux.com.br"				\
		#BR - Pimenta Bueno
		"void.chililinux.com"			\
		#BR - Pimenta Bueno
		"void.chilios.com.br"			\
	)

fping=10000
frepo=""

for repo in "${arr[@]}"
do
	geo=$(geoiplookup "$repo" | head -1 | sed 's/^.*: //')
	echo ""
	echo "Testing ping for $repo ($geo)"
	ping=$(ping -c 3 "$repo" | tail -1| awk '{print $4}' | cut -d '/' -f 2 | bc -l)
	echo "$repo Average ping: $ping"
	if (( $(bc <<< "$ping<$fping") ))
	then
		frepo="$repo"
		fping="$ping"
	fi
done

geo=$(geoiplookup "$frepo" | head -1 | sed 's/^.*: //')
echo "=================================================="
echo "Recommended repo is: $frepo ($geo)"
echo "Ping: $fping"
echo "=================================================="

#shellcheck OK
