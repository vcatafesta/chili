#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

function luhn_validate { # <numeric-string>
	num=$1
	shift 1

	len=${#num}
	is_odd=1
	sum=0
	for ((t = len - 1; t >= 0; --t)); do
		digit=${num:$t:1}

		if [[ $is_odd -eq 1 ]]; then
			sum=$((sum + $digit))
		else
			sum=$(($sum + ($digit != 9 ? ((2 * $digit) % 9) : 9)))
		fi

		is_odd=$((!$is_odd))
	done

	# NOTE: returning exit status of 0 on success
	return $((0 != ($sum % 10)))
}

function print_result { # <numeric-string>
	if luhn_validate "$1"; then
		echo "$1 is valid"
	else
		echo "$1 is not valid"
	fi
}

print_result "49927398716"
print_result "49927398717"
print_result "1234567812345678"
print_result "1234567812345670"
