#!/usr/bin/env bash
#shellcheck disable=SC2015
#shellcheck source=/dev/null
#
#  jogodavelha - jogo da velha escrito em bash
#  Chili GNU/Linux - https://raw.githubusercontent.com/vcatafesta/chili/main/jogodavelha.sh
#  Chili GNU/Linux - https://chililinux.com
#  Chili GNU/Linux - https://chilios.com.br
#
#	Created: 2023/06/30
#	Altered: 2023/07/04
#
#  Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  jogodavelha uses quite a few external programs during its execution. You
#  need to have at least the following installed for makepkg to function:
#     awk, bsdtar (libarchive), bzip2, coreutils, fakeroot, file, find (findutils),
#     gettext, gpg, grep, gzip, sed, tput (ncurses), xz
#########################################################################
#debug
export PS4='${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} '
#set -x
#set -e
shopt -s extglob

readonly _VERSION_="1.04.20230704"
readonly DEPENDENCIES=('tput' 'printf' 'grep' 'stty')
readonly PACKAGEDEP=([tput]='ncurses' [printf]='coreutils' [grep]='grep' [stty]='coreutils')
declare -gA Alanguage=([pt_BR]=0 [en_US]=1 [de_DE]=2 [fr_FR]=3 [es_ES]=4 [it_IT]=5)
declare -gA Alocale=([0]=pt_BR [1]=en_US [2]=de_DE [3]=fr_FR [4]=es_ES [5]=it_IT)

function sh_usage {
	printf "%s\n" "${orange}${0##*/} v${_VERSION_}${reset}"
	printf "%s\n" "${reset}	usage: ${0##*/} -l <n>        ${cyan}# language (default = locale) 0=Portuguese 1=English 2=German 3=French 4=Spanish 5=Italian"
	printf "%s\n" "${reset}	       ${0##*/} -n|--nocolor  ${cyan}# suppress colors in output"
	printf "%s\n" "${reset}	       ${0##*/} -h|--help     ${cyan}# this help"
	printf "%s\n" "${reset}	       ${0##*/} -e|--emoji    ${cyan}# use emoji"
	printf "%s\n"
	printf "%s\n" "${reset}	   ex: ${0##*/} -l1 --nocolor ${cyan}# languague=english, supress colors"
	printf "%s\n" "${reset}	       ${0##*/}               ${cyan}# language default = locale"
}

function sh_version {
	printf "%s\n" "${orange}${0##*/} v${_VERSION_}${reset}"
}

function sh_configvar {
	declare -g Ganhei=0
	declare -g Empate=0
	declare -g Cols=$(tput cols)
	declare -g Lines=$(tput lines)
	declare -g Col0=$(((Cols-46)/2))
	declare -g emoji=0
	declare -ga board
}

function sh_checktty {
	if [ "$Cols" -lt 30 ] || [ "$Lines" -lt 17 ]; then
		clear
		printf "%s\n" "${StrTty[LC_DEFAULT]}"
		printf "%s\n" "Atual: $(stty size)"
		exit 2
	fi
}

function sh_checkDependencies {
	local d
	local errorFound=0
	declare -a missing

	for d in "${DEPENDENCIES[@]}"; do
		[[ -n $(command -v "$d") ]] && { :; } || { \
			printf "%s\n" "${red}ERROR${reset}: Could not find command ${cyan}'$d'${reset} -> install package '${PACKAGEDEP[$d]}'"
			missing+=("$d")
			errorFound=1
		}
	done
	if (( errorFound )); then
		echo "${yellow}---------------IMPOSSIBLE TO CONTINUE---------------"
		echo "${black}This script needs the commands listed above"
		echo "Install them and/or make sure they are in your \$PATH"
		echo "${yellow}---------------IMPOSSIBLE TO CONTINUE---------------"
		exit 1
	fi
}

function sh_getLocale {
   local lc

   LC_DEFAULT="${Alanguage[pt_BR]}"
   LOCALE="pt_BR"
   if lc=$(grep _ <(locale -a) | head -1 | cut -c1-5); then
      LOCALE="$lc"
      LC_DEFAULT="${Alanguage[$lc]}"
   fi
}

function sh_setLanguage {
	langmsg=(
		'lang=("pt_BR"
			"en_US"
			"de_DE"
			"fr_FR"
			"es_ES"
			"it_IT")'
	'StrYou=("Você GANHOU!"
			"You WON!"
			"Du HASTGEWONNEN!"
			"Tu as GAGNÉ!"
			"¡GANASTE!"
			"Hai VINTO!")'
	'StrPc=("Computador GANHOU!"
			"Computer WINS!"
			"Computer GEWINNT!"
			"L''ordinateur GAGNE !"
			"¡La computadora GANA!"
			"Il computer VINCE!")'
	'StrTie=("EMPATE"
			"A TIE"
			"EINE KRAWATTE"
			"UNE CRAVATE"
			"UN LAZO"
			"UNA CRAVATTA")'
	'StrLe=("Informe a sua jogada (1-9): "
			"Enter your move (1-9): "
			"Geben Sie Ihren Zug ein (1-9): "
			"Entrez votre coup (1-9): "
			"Ingrese su movimiento (1-9): "
			"Inserisci la tua mossa (1-9): ")'
	'StrEr1=("Nesta posicao ja existe um -> "
			"In this position there is already a -> "
			"An dieser Stelle steht bereits ein -> "
			"Dans cette position, il y a déjà un -> "
			"En esta posición ya hay un -> "
			"In questa posizione c''è già un -> ")'
	'StrEr2=("Posição inválida!"
			"Invalid position!"
			"Ungültige Position!"
			"Position invalide!"
			"¡Posición no válida!"
			"Posizione non valida!")'
	'StrFim=("Deseja continuar (S/n)?"
			"Do you want to continue (Y/n)?"
			"Möchten Sie fortfahren (J/n)?"
			"Voulez-vous continuer (O/n)?"
			"¿Quieres continuar (T/n)?"
			"Vuoi continuare (S/n)?")'
	'StrTty=("O tamanho mínimo da janela deve ser 17 linhas e 30 colunas"
			"Minimum window size must be 17 rows and 30 columns"
			"Die Mindestfenstergröße muss 17 Zeilen und 30 Spalten betragen"
			"La taille minimale de la fenêtre doit être de 17 lignes et 30 colonnes"
			"El tamaño mínimo de la ventana debe ser de 17 filas y 30 columnas"
			"La dimensione minima della finestra deve essere di 17 righe e 30 colonne")'
	)
	for xmsg in "${langmsg[@]}"; do eval "$xmsg"; done
}

function sh_setvarcolors {
   if [ -n "$(command -v "tput")" ]; then
		bold=$(tput bold)
		reset=$(tput sgr0)
		white="${bold}$(tput setaf 7)"
		black="${bold}$(tput setaf 0)"
		red=$(tput bold)$(tput setaf 196)
		green=$(tput setaf 2)
		yellow=$(tput bold)$(tput setaf 3)
		cyan=$(tput setaf 6)
		orange=$(tput setaf 3)
		pink=$(tput setaf 5)
		blue=$(tput setaf 4)
		purple=$(tput setaf 125);
		violet=$(tput setaf 61);
   else
      sh_unsetvarcolors
   fi
}

function sh_unsetvarcolors {
	unset reset green red bold blue cyan
	unset orange pink white yellow violet purple
}

function RandomGame {
	row=$(shuf -e {1..3} -n 1)
	col=$(shuf -e {1..3} -n 1)
	echo "$row$col"
}

function EraseLine {
	SetPos "$1" "$2"
	tput el
}


function replicate {
	local Var
	printf -v Var %$2s " "
	echo ${Var// /$1}
}


function status {
	local linha="$1"
	local coluna="$2"
	local quantidade="$3"
	local texto="$4"
	local color="$5"

	# Sequências de escape para configurar a posição do cursor e as cores
	posicao="\e[${linha};${coluna}H"
	cor_branco="\e[97m"
	cor_azul="\e[44m"
	redefinir="\e[0m"

	# Imprimir a quantidade variável de caracteres Unicode com cores e posição definidas
	printf "${posicao}${cor_branco}${cor_azul}"
	for ((i=1; i<=quantidade; i++)); {
#	  printf "\u2588"
	  printf " "
	}
	PrintCenter "$linha" "$texto" "$color"
	printf "${redefinir}"
}

# Função para posicionar o cursor
function SetPos {
  printf "\e[${1};${2}H"
}

function SetPos1 {
	tput cup "$1" "$2"
}

function PrintPos {
	SetPos "$1" "$2"
	echo "$3"
}

function MaxCol {
	tput cols
}

function MaxRow {
	tput lines
}

function PrintCenter {
	local nrow="$1"
	local text="$2"
	local color="$3"
	local largura_terminal=$(tput cols)
	local	posicao_inicial=$(( ($largura_terminal - ${#text}) / 2 ))
	local	posicao_final=$(( $posicao_inicial + ${#text}))

	if [[ -n color ]]; then
		PrintPos "$nrow" "$posicao_inicial" "${color}$text${reset}"
	else
		PrintPos "$nrow" "$posicao_inicial" "$text"
	fi
	SetPos "$nrow" "$posicao_final"
}

function display_scoreboard {
	EraseLine 21 0
	if [ "$1" = E ]; then
		((++Empate))
		PrintPos 17 $(( Col0 + 29 )) "$yellow$Empate$reset"	# Printando Placar
		PrintPos 22 "$Col0" "$yellow${StrEmp[LC_DEFAULT]}$reset"
	else
		((++Ganhei))
		PrintPos 17 $(( Col0 + 40 )) "$red$Ganhei$reset"		# Printando Placar
		PrintPos 22 "$Col0" "$red${StrGan[LC_DEFAULT]}$reset"
		case "$2" in
			L)  for j in {1..3}; 	{ Jogar "$i$j" X; };;
			C)	 for j in {1..3}; 	{ Jogar "$j$i" X; };;
			D1) for i in 11 22 33;	{ Jogar "$i" X;   };;
			*)  for i in 13 22 31;	{ Jogar "$i" X;   };;
		esac
	fi
}

function populate_board {
	board=()

	for i in {0..8}; {
		board+=('   ')
	}
}

# Função para exibir o tabuleiro
function display_board {
	local nMaxCol=$(MaxCol)
	local nMaxRow=$(MaxRow)
	local nCenterCol=$(( $nMaxCol/2 ))
	local nCenterRow=$(( $nMaxRow/2 ))
	local cline=
	local nPos_ini=$(( ($nMaxCol - 13) / 2))

	clear
	status 0 0 $nMaxCol "Macrosoft JogoDaVelha.sh for Linux | $(date +"%H:%M %p")"

	StrIni[0]='  1   2   3'
	StrIni[1]='┌───┬───┬───┐'
	StrIni[2]='│   │   │   │'
	StrIni[3]='├───┼───┼───┤'
	StrIni[4]='│   │   │   │'
	StrIni[5]='├───┼───┼───┤'
	StrIni[6]='│   │   │   │'
	StrIni[7]='└───┴───┴───┘'
	StrIni[8]='  7   8   9'

   for i in {0..8}; {
   	PrintPos $(( nCenterRow-4 + i )) "$nPos_ini" "${StrIni[i]}"
   	[ "${board[i]}" = ' O ' ] && cLine+="│${green}${board[i]}${reset}" || cLine+="│${red}${board[i]}${reset}"
   	[ $i -eq 2 ] && { PrintPos $(( nCenterRow-2 )) "$nPos_ini" "$cLine"; cLine= ; }
   	[ $i -eq 5 ] && { PrintPos $(( nCenterRow+0 )) "$nPos_ini" "$cLine"; cLine= ; }
   	[ $i -eq 8 ] && { PrintPos $(( nCenterRow+2 )) "$nPos_ini" "$cLine"; cLine= ; }
   }
}

# Função para verificar se alguém venceu
function check_win {
	local -a win_conditions=("0 1 2" "3 4 5" "6 7 8" "0 3 6" "1 4 7" "2 5 8" "0 4 8" "2 4 6")

	for condition in "${win_conditions[@]}"; {
		local positions=($condition)
		local pos1=${positions[0]}
		local pos2=${positions[1]}
		local pos3=${positions[2]}

		if [[ ${board[$pos1]} == " O " && ${board[$pos2]} == " O " && ${board[$pos3]} == " O " ]]; then
#			PrintCenter $(($(MaxRow)/2+7)) "${StrYou[LC_DEFAULT]}" "$green"
			status $(( $(MaxRow)-1 )) 0 $(MaxCol) "${StrYou[LC_DEFAULT]}" "$green"
			return 1
		elif [[ ${board[$pos1]} == " X " && ${board[$pos2]} == " X " && ${board[$pos3]} == " X " ]]; then
			PrintCenter $(($(MaxRow)/2+7)) "${StrPc[LC_DEFAULT]}" "$red"
			return 1
		fi
	}
}

# Função para verificar se o jogo empatou
function check_draw {
	local -a filled_positions=()
	for i in "${board[@]}"; {
		[[ -n "$i" ]] && filled_positions+=($i)
	}
	if [[ ${#filled_positions[@]} -eq ${#board[@]} ]]; then
		PrintCenter $(($(MaxRow)/2+7)) "${StrTie[LC_DEFAULT]}" "$yellow"
		return 1
	fi
}

# Função para a jogada do computador
function computer_move {
	local empty_positions=()
	for i in "${!board[@]}"; {
		if [[ ${board[$i]} == "   " ]]; then
			empty_positions+=($i)
		fi
	}

	if [[ ${#empty_positions[@]} -eq 0 ]]; then
		PrintCenter $(($(MaxRow)/2+7)) "Não há posições disponíveis. O jogo empatou!"
		return 1
    fi

    local random_index=$(( RANDOM % ${#empty_positions[@]} ))
    local position=${empty_positions[$random_index]}
    local index=$((position))
    board[$index]=" X "
}

#Playing
function Playing {
	# Loop principal do jogo
	while true; do
		populate_board
		while true; do
			display_board

			# Jogada do jogador
			PrintCenter $(($(MaxRow)/2+6)) "${StrLe[LC_DEFAULT]}" "$black"
			read -r player_move

			if [[ $player_move =~ ^[1-9]$ ]]; then
				index=$((player_move - 1))
				if [[ ${board[$index]} == "   " ]]; then
					board[$index]=" O "
				else
					PrintCenter $(($(MaxRow)/2+7)) "${StrEr1[LC_DEFAULT]}${board[index]}" "$red"
					sleep 1
					continue
				fi
			else
				PrintCenter $(($(MaxRow)/2+7)) "${StrEr2[LC_DEFAULT]}" "$red"
				sleep 1
				continue
			fi
			display_board
			if ! check_win; then break; fi
			if ! check_draw; then break; fi

			# Jogada do computador
			computer_move
			display_board
			if ! check_win; then break; fi
			if ! check_draw; then break; fi
		done
		PrintCenter $(($(MaxRow)/2+6)) "${StrFim[LC_DEFAULT]}" "$cyan" "$pink"
		read -r
		[ "${REPLY^}" == N ] && exit
	done
}

sh_checkDependencies
sh_configvar
sh_setvarcolors
sh_getLocale
sh_setLanguage
sh_checktty

if ! opts=$(getopt -o l:Vnhe --long language:,version,nocolor,help,emoji -n "${0##*/}" -- "$@"); then
   sh_usage
   exit 0
fi
eval set -- "$opts"
while true; do
   case "$1" in
      -l|--language) LC_DEFAULT="$2"; shift 2 ;;
      -e|--emoji)    emoji=1; shift;;
      -n|--nocolor)  sh_unsetvarcolors; shift;;
      -V|--version)  sh_version; exit 0;;
      -h|--help)     sh_usage; exit 0;;
		--) shift; break ;;
		*) echo "Invalid option"; exit 1 ;;
   esac
done


Playing
