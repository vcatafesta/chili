#!/usr/bin/env bash

source /etc/bashrc

str="python-zope-proxy-4.3.5-1-x86_64.chi.zst"
echo $str | sed 's/-/ /g'

pkg_base=$(echo $str | sed 's/-[[:digit:]].*$//')
pkg_arch=$(echo $str | sed 's/'$pkg_base-'//g')
pkg_version=$(echo ${pkg_arch%%-*})
pkg_build=$(echo ${pkg_arch##-*})
#echo $pkg_base
#echo $pkg_arch
#echo $pkg_version
#echo $pkg_build

#pkg_re='(.+)-[^-]+-[0-9]+-([^.]+)\.chi.*'
pkg_re='([a-zA-Z0-9]+(-[a-zA-Z0-9]+){,2})-(([0-9]+(\.[0-9]+){,2})((\-)([0-9]+))?)-([a-zA-Z0-9]+_[a-zA-Z0-9]+).*'
pkg=$str
[[ $pkg =~ $pkg_re ]] && pkg_base=${BASH_REMATCH[1]} pkg_base_version=${BASH_REMATCH[3]} pkg_version=${BASH_REMATCH[4]} pkg_build=${BASH_REMATCH[8]} pkg_arch=${BASH_REMATCH[9]}

echo $pkg_base
echo $pkg_base_version
echo $pkg_version
echo $pkg_build
echo $pkg_arch

#printf '%s (%s):\n' "${name##*/}" "$arch"
#printf '  %s\n' "${pkg##*/}"


#IFS='-' # space is set as delimiter
#read -ra ADDR <<< "$str" # str is read into an array as tokens separated by IFS
#for i in "${ADDR[@]}"; do # access each element of array
#    echo "$i"
#done

echo

str="python-zope-proxy-4.3.5-1-x86_64.chi.zst"
pkg_re='^([a-z-]+)(-)([0-9\\.]+)(-)([0-9])(-)(.*)(.chi.zst)$'

[[ $str =~ $pkg_re ]] &&
    pkg_base=${BASH_REMATCH[1]}
    pkg_base_version=${BASH_REMATCH[6]}
    pkg_version=${BASH_REMATCH[3]}
    pkg_build=${BASH_REMATCH[5]}
    pkg_arch=${BASH_REMATCH[7]}

echo $pkg_base
echo $pkg_base_version
echo $pkg_version
echo $pkg_build
echo $pkg_arch


echo "==========================================================="
#str="python-4.3.5-1-x86_64.chi.zst"
#str="python-zope-4.3.5-1-x86_64.chi.zst"
str="python-zope-proxy-4.3.5-1-x86_64.chi.zst"

#pkg_re='^([a-z-]+)(-)([0-9\\.]+)(-)([0-9])(-)(.*)(.chi.zst)$'
#pkg_re='([a-zA-Z0-9]+(-[a-zA-Z0-9]+){,2})-(([0-9]+(\.[0-9]+){,2})((\-)([0-9]+))?)-([a-zA-Z0-9]+_[a-zA-Z0-9]+).*'
#pkg_re='([a-zA-Z0-9]+(-[a-zA-Z0-9]+)+)-(([0-9]+(\.[0-9]+)+)(-([0-9]+))?)-([a-zA-Z0-9]+_[a-zA-Z0-9]+).*'
#pkg_re='([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*)-(([0-9]+(\.[0-9]+)*)(-([0-9]+))?)-([^.]+).*'
pkg_re='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst'
if [[ $str =~ $pkg_re ]]; then
  for group_num in ${!BASH_REMATCH[@]}; do
    echo "group ${group_num}: ${BASH_REMATCH[$group_num]}";
  done
fi

echo "==========================================================="
#str="python-4.3.5-1-x86_64.chi.zst"
str="python-zope-4.3.5-1-x86_64.chi.zst"
#str="python-zope-proxy-4.3.5-1-x86_64.chi.zst"
block1="${str//-[0-9].*/}"
block2="${str//${block1}-/}"
block2="${block2%-*}"
block3="${block2%%-*}"
block4="${block2#*-}"
block5="${str//${block1}-${block2}-/}"
block5="${block5%%.*}"

echo "block1: ${block1}"
echo "block2: ${block2}"
echo "block3: ${block3}"
echo "block4: ${block4}"
echo "block5: ${block5}"
