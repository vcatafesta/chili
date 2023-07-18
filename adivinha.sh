## vim:set ts=3 sw=3 et:# vim:set ts=3 sw=3 et:# vim:set ts=3 sw=3 et:!/usr/bin/env bash

true=0
false=1
rmin=1
rmax=100

msg[0]="Você acertou (em %s tentativas)"
msg[1]='Baixo demais!'
msg[2]='Alto demais!'
msg[3]='Somente numeros!'
msg[4]="Somente numeros entre $rmin e $rmax!"

prompt[0]="Entre um numero entre $rmin e $rmax:"
prompt[1]='Tecle algo'
prompt[2]='Jogar novamente? (S/n)'

msg_quit='Saindo...'
str_title='JOGO DA ADIVINHAÇÃO'

is_number()	[[ $1 =~ ^[0-9]+$ ]]
in_range() 	[[ $1 -ge $rmin && $1 -le $rmax ]]
in_higher()	[[ $1 -gt $sec ]]
in_lower() 	[[ $1 -lt $sec ]]
get_secret() (( sec = RANDOM % 100 -1 ))

guess_update(){
	local r
	local go
	case $1 in
		1)	r='↓';;
		2)	r='↑';;
		*)	r='-';;
	esac
	guesses+="$count:$guess$r "
	((count++))
	echo "${msg[$1]}"
	read -sN1 -p "${prompt[1]}" go
}

check_guess(){
	ok=0
	is_number $1 || return 3
	in_range $1  || return 4
	in_lower $1 && return 1
	in_higher $1 && return 2

	return $ok
}

set_game(){
	count=1
	guesses=''
	get_secret
}

main(){

	set_game
	while :; do
		clear
		printf '%s\n\n' "$str_title"
		[[ "$guesses" ]] && printf '%s\n\n' "$guesses"
		read -e -p "${prompt[0]} " guess
		check_guess "$guess" || { guess_update $?; continue; }
		printf "${msg[$?]}\n" $count
		printf '\n%s ' "${prompt[2]} "
		read -sN1 again
		[[ ${again,} = n ]] && break
		set_game
	done
	printf '\n%s ' "$msg_quit"
}

main

#vim:set ts=3 sw=3 et:

