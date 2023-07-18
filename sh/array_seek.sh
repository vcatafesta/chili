#!/usr/bin/bash

true=0
false=1

array=($(ls -1 /etc/ | sort ))
search='passwd'

if [[ "${array[@]}" =~ "${search}" ]]; then
    echo "${!array[*]}"
    echo "${BASH_REMATCH[0]}"
fi

function ascan3()
{
	local myarray="$1"
	local match="$2"
	printf '%s\n' "${myarray[@]}" | grep -P '^math$'
}

function ascan2()
{
	local myarray="$1"
	local match="$2"
	case "${myarray[@]}" in
		*"$match"*)
			return $true
			;;
	esac
	return $false
}

function ascan()
{
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return $true; done
  return $false
}

array=("primeiro" "segundo" "terceiro")

ascan "primeiro" "${array[@]}"
echo $?

ascan "terceiro" "${array[@]}"
echo $?

ascan2 "quarto" "${array[@]}"
echo $?


function len()
{
	return $#
}

function contains()
{
	local n=$#
	local value=${!n}

	for ((i=1;i < $#;i++)) {
		if [ "${!i}" == "${value}" ]; then
			return $i
		fi
	}
	return $n
}


echo "+++++++++++++++++++++++++++++++"
array=("one" "two" "three" "four" "five six")
contains "${array[@]}" "five"
echo $?
len "${array[@]}"
echo $?
