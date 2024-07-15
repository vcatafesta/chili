#!/usr/bin/env bash

sh_while() {
	while :; do
		echo vilmar
	done
}

sh_for() {
	for (( ; ; )); do
		echo vilmar
	done
}

sh_for1() {
	for (( ; ; )); do
		echo vilmar
	done
}

sh_until() {
	until false; do
		echo vilmar
	done
}
