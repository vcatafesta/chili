#!/bin/bash
h="1 2 3"
a() {
	for i in $h $h $h; do
		[ -n "${L[$i]}" ] && [ -z "${L[$i - 1]}" ] && L[$i - 1]=${L[$i]} && L[$i]=
	done
}
s() {
	for i in $h; do
		[ -n "${L[$i]}" ] && [ "${L[$i]}" == "${L[$i - 1]}" ] && L[$i - 1]=$((${L[$i]} * 2)) && L[$i]=
	done
}
e=echo
_() {
	for n in $5 $6 $7 $8; do
		L=($(for i in {1..4}; do
			$e ${M[$n + ${!i}]}
		done)
		)
		a
		s
		a
		for i in {1..4}; do
			M[$n + ${!i}]=${L[$i - 1]}
		done
	done
}
S="%s\n|%4s|%4s|%4s|%4s|\n"
p=printf
D=---------------------
w="$p $S $D"
q() {
	$w $(for i in {1..4}; do
		$e ${M[${!i}]:-.}
	done)
}
m="0 4 8 12"
b() {
	clear
	for i in $m; do
		q $i+{0..3}
	done
	$e $D
	$e Moves: w,a,s,d, Quit: q
}
R() {
	n=$(($RANDOM % 16))
}
t() {
	R
	while [ -n "${M[$n]}" ]; do
		R
	done
	M[$n]=2
}
p() {
	for i in {0..15}; do
		M[$i]=
	done
	t
	t
	b
}
r=return
c() {
	for i in {0..15}; do
		[ -z "${M[$i]}" ] && $r 0
	done
	$r 1
}
o() {
	until [ "$REPLY" = y -o "$REPLY" = n ]; do
		read -n 1 -p "GAME OVER! Play again? (y/n)"
	done
	case $REPLY in
	y)
		p
		$r 1
		;;
	n) exit ;;
	esac
}
RANDOM=$RANDOM
g="0 1 2 3"
C=continue
p
for (( ; ; )); do
	read -n 1 -s
	case $REPLY in
	w) _ $m $g ;;
	a) _ $g $m ;;
	s) _ 12 8 4 0 $g ;;
	d) _ {3..0} $m ;;
	q) exit ;;
	*) $C ;;
	esac
	c || o || $C
	b
	sleep 1
	t
	b
done
