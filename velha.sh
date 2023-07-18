#!/usr/bin/env bash
#shellcheck disable=SC2015
#shellcheck source=/dev/null
#
#	Created: 0000/00/00
#	Altered: 2023/07/05
#
#	Copyright (c) 0000-2023, Julio Cezar Neves <jneves@gmail.com>
#	Copyright (c) 2023-2023, Vilmar Catafesta <vcatafesta@gmail.com>
#
#######################################################
#                   JOGO DA VELHA                     #
#          DUVIDO QUE VOCE CONSIGA GANHAR!            #
#-----------------------------------------------------#
#                    TIC TAC TOE                      #
#    I WON'T GIVE YOU A CHANCE. YOU'LL NEVER WIN!     #
#######################################################
#                                                     #
#         Leia:    Programacao Shell - Linux          #
#         Autor:   Julio Cezar Neves                  #
#         Editora: Brasport                           #
#         ISBN:    85-7452-076-4                      #
#                                                     #
#######################################################
#  Para qualquer duvida ou esclarecimento sobre este  #
# programa estou as ordens em julio.neves@bigfoot.com #
#-----------------------------------------------------#
#   Any doubt about this program you can find me at   #
#              julio.neves@bigfoot.com                #
#######################################################
# Se voce estiver sob o bash, troque a 1a. linha por  #
#                    #!/bin/bash                      #
#-----------------------------------------------------#
#   If you are running bash change the 1st. line for  #
#                    #!/bin/bash                      #
#######################################################
#    Este foi um meio divertido que encontrei para    #
#  testar a compatibilidade no uso de arrays entre o  #
# bash e o ksh. Se alguem quiser desenvolver a rotina #
#   em que o adversario comeca jogando, sinta-se a    #
#  vontade, porem nao esqueca de mandar-me o modulo   #
#             para incorpora-lo ao meu.               #
#-----------------------------------------------------#
#  This program was developed as a funny way to test  #
#  the compatibility between arrays in ksh and bash.  #
# Feel free for develop the module that the opponent  #
# start playing, but don't forget to send me the new  #
#     routine because I'll attach it at this one.     #
#######################################################
#

#debug
export PS4='${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} '
#set -x
#set -e
shopt -s extglob


. /chili/core.sh





readonly _VERSION_="1.05.20230705"
readonly DEPENDENCIES=('tput' 'printf')
declare -gA Alanguage=([pt_BR]=0 [en_US]=1 [de_DE]=2 [fr_FR]=3 [es_ES]=4 [it_IT]=5)
declare -gA Alocale=([0]=pt_BR [1]=en_US [2]=de_DE [3]=fr_FR [4]=es_ES [5]=it_IT)

# Cuidado com o chefe!
# Warning! The boss is near you!
#trap "clear ; exit" 0 2 3

function sh_usage {
	printf "%s\n" "${orange}${0##*/} v${_VERSION_}${reset}"
	printf "%s\n" "${reset}usage: ${0##*/} -l <n>        ${cyan}# language (default = locale) 0=Portuguese 1=English 2=German 3=French 4=Spanish 5=Italian"
	printf "%s\n" "${reset}       ${0##*/} -n|--nocolor  ${cyan}# suppress colors in output"
	printf "%s\n" "${reset}       ${0##*/} -h|--help     ${cyan}# this help"
	printf "%s\n" "${reset}       ${0##*/} -e|--emoji    ${cyan}# use emoji"
	printf "%s\n"
	printf "%s\n" "${reset}   ex: ${0##*/} -l1 --nocolor ${cyan}# languague=english, supress colors"
	printf "%s\n" "${reset}       ${0##*/}               ${cyan}# language default = locale"
}

function sh_version {
	printf "%s\n" "${orange}${0##*/} v${_VERSION_}${reset}"
}

function sh_configvar {
	declare -g Ganhei=0
	declare -g Empate=0
	declare -g emoji=0
	sh_setvars
}

function sh_setvars {
	Cols=$(MaxCol)
	Lines=$(MaxRow)
	Col0=$(((Cols-46)/2))
	nCenterRow=$((Lines/2))
}

function sh_checktty {
	if [ "$Lines" -lt 14 ] || [ "$Cols" -lt 75 ]; then
		clear
		printf "%s\n" "${StrTty[LC_DEFAULT]}"
		exit 2
	fi
}

function sh_checkDependencies {
	local d
	local errorFound=0
	declare -a missing

	for d in "${DEPENDENCIES[@]}"; do
		[[ -n $(command -v "$d") ]] && { :; } || { printf "%s\n" "${red}ERROR${reset}: Could not find command ${cyan}'$d'${reset}"; missing+=("$d"); errorFound=1; }
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
	'StrGan=("GANHEI !!!"
			"I WON !!!"
			"ICH HABE GEWONNEN !!!"
			"J''AI GAGNÉ !!!"
			"GANÉ !!!"
			"HO VINTO !!!")'
	'StrEmp=("EMPATE"
			"A TIE"
			"EINE KRAWATTE"
			"UNE CRAVATE"
			"UN LAZO"
			"UNA CRAVATTA")'
	'StrLe=("Informe a sua jogada (Linha Coluna):"
			"Enter your move (Line Column):"
			"Geben Sie Ihren Zug ein (Zeilenspalte):"
			"Entrez votre coup (colonne de ligne):"
			"Ingrese su movimiento (Columna de línea):"
			"Inserisci la tua mossa (colonna linea):")'
	'StrEr1=("Nesta posicao ja existe um -> "
			"In this position there is already a -> "
			"An dieser Stelle steht bereits ein -> "
			"Dans cette position, il y a déjà un -> "
			"En esta posición ya hay un -> "
			"In questa posizione c''è già un -> ")'
	'StrEr2=("Informe Linha e Coluna junto. Ex: 13 = Ln 1 e Col 3"
			"Enter Row and Column together. Ex: 13 = Lin 1 and Col 3"
			"Geben Sie Zeile und Spalte zusammen ein. Beispiel: 13 = Zeile 1 und Spalte 3"
			"Entrez Ligne et Colonne ensemble. Ex : 13 = Ligne 1 et Colonne 3"
			"Ingrese Fila y Columna juntas. Ej: 13 = Línea 1 y Columna 3"
			"Immettere Riga e Colonna insieme. Es: 13 = Riga 1 e Colonna 3")'
	'StrFim=("Deseja continuar (S/n)?"
			"Do you want to continue (Y/n)?"
			"Möchten Sie fortfahren (J/n)?"
			"Voulez-vous continuer (O/n)?"
			"¿Quieres continuar (T/n)?"
			"Vuoi continuare (S/n)?")'
	'StrTty=("O tamanho mínimo da janela deve ser 25 linhas e 80 colunas"
			"Minimum window size must be 25 rows and 80 columns"
			"Die Mindestfenstergröße muss 25 Zeilen und 80 Spalten betragen"
			"La taille minimale de la fenêtre doit être de 25 lignes et 80 colonnes"
			"El tamaño mínimo de la ventana debe ser de 25 filas y 80 columnas"
			"La dimensione minima della finestra deve essere di 25 righe e 80 colonne")'
	'StrEmpates=(" Empates "
			"  Ties   "
			"Krawatten"
			" Cravates"
			" Corbatas"
			" Cravatte")'
	'StrVitorias=(" Vitórias "
			"   Wins   "
			"  Gewinnt "
			"   Gagne  "
			"    Gana  "
			"   Vince  ")'
	'Eng=("Para obter ajuda, use: ${0##*/} -h"
			"For help, use: ${0##*/} -h"
			"Für Hilfe verwenden Sie: ${0##*/} -h"
			"Pour obtenir de l''aide, utilisez : ${0##*/} -h"
			"Para obtener ayuda, usa: ${0##*/} -h"
			"Per aiuto, usa: ${0##*/} -h")'
	)
	for xmsg in "${langmsg[@]}"; do eval "$xmsg"; done
}

function sh_setvarcolors {
   if [ -n "$(command -v "tput")" ]; then
		bold=$(tput bold)
		reset=$(tput sgr0)
		black=$(tput bold)$(tput setaf 0);
		red=$(tput bold)$(tput setaf 196)
		green=$(tput setaf 2)
		yellow=$(tput bold)$(tput setaf 3)
		cyan=$(tput setaf 6)
		orange=$(tput setaf 3)
#		blue=$(tput setaf 4)
#		pink=$(tput setaf 5)
#		white=$(tput setaf 7)
#		purple=$(tput setaf 125);
#		violet=$(tput setaf 61);
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

# Função para posicionar o cursor
function SetPos {
	printf "\e[${1};${2}H"
}

function SetPos1 {
	tput cup "$1" "$2"
}

function PrintPos {
	SetPos "$1" "$2"
	printf "$3"
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
   local posicao_inicial=$(( ($largura_terminal - ${#text}) / 2 ))
   local posicao_final=$(( $posicao_inicial + ${#text}))

   if [[ -n color ]]; then
      PrintPos "$nrow" "$posicao_inicial" "${color}$text${reset}"
   else
      PrintPos "$nrow" "$posicao_inicial" "$text"
   fi
   SetPos "$nrow" "$posicao_final"
}

Placar() {
	EraseLine $((nCenterRow+5)) 0
	if [ "$1" = E ]; then
		((++Empate))
		PrintPos $((nCenterRow+2)) $(( Col0 + 29 )) "$yellow$Empate$reset"	# Printando Placar
		PrintPos $((nCenterRow+7)) "$Col0" "$yellow${StrEmp[LC_DEFAULT]}$reset"
	else
		((++Ganhei))
		PrintPos $((nCenterRow+2)) $(( Col0 + 40 )) "$red$Ganhei$reset"		# Printando Placar
		PrintPos $((nCenterRow+7)) "$Col0" "$red${StrGan[LC_DEFAULT]}$reset"
		case "$2" in
			L)  for j in {1..3}; 	{ Jogar "$i$j" X; };;
			C)	 for j in {1..3}; 	{ Jogar "$j$i" X; };;
			D1) for i in 11 22 33;	{ Jogar "$i" X;   };;
			*)  for i in 13 22 31;	{ Jogar "$i" X;   };;
		esac
	fi
}

function set_board {
	StrIni[1]="   1   2   3"
	StrIni[2]=" ┌───┬───┬───┐"
	StrIni[3]="1│   │   │   │          ┌─────────┬──────────┐"
	StrIni[4]=" ├───┼───┼───┤          │${StrEmpates[LC_DEFAULT]}│${StrVitorias[LC_DEFAULT]}│"
	StrIni[5]="2│   │   │   │          ├─────────┼──────────┤"
	StrIni[6]=" ├───┼───┼───┤          │         │          │"
	StrIni[7]="3│   │   │   │          └─────────┴──────────┘"
	StrIni[8]=" └───┴───┴───┘"
}

function display_board {
	set_board
	clear
	for i in {1..8}; {
		PrintPos $(( nCenterRow-4 + i )) "$Col0" "${StrIni[i]}"
	}
}

function Jogar {
	local emoji_X="\u274C"
	local emoji_O="\U0001F7E2\n"
	local pos="$1"
	local char="$2"

	sh_setvars
	display_board
	P[$pos]="$char"

	for i in {1..3}; do
		for j in {1..3}; do
			pos="$i$j"
			char="${P[$i$j]}"
			Lin=$(cut -c1 <<< "$pos")
			Col=$(cut -c2 <<< "$pos")
			Lin=$(( ((Lin - 1) * 2) + nCenterRow-1))

			if [[ -n "$char" ]]; then
				if ((emoji)); then
					Col=$(( ((Col - 1) * 4) + 3 + Col0 -1 ))
					[ "$char" = 'O' ] &&	PrintPos "$Lin" "$Col" "$(printf $emoji_O)" || \
												PrintPos "$Lin" "$Col" "$(printf $emoji_X)"
				else
					Col=$(( ((Col - 1) * 4) + 3 + Col0 ))
					[ "$char" = 'O' ] &&	PrintPos "$Lin" "$Col" "$green$char$reset" || \
												PrintPos "$Lin" "$Col" "$red$char$reset"
				fi
			fi
		done
	done
	((++nJobs))
}

UserPlayer() {
	EraseLine $((nCenterRow+6)) "$(( Col0 + 1 + ${#StrLe[LC_DEFAULT]} ))"
	PrintPos $((nCenterRow+6)) "$Col0" "${StrLe[LC_DEFAULT]}"
	SetPos $((nCenterRow+6)) "$(( Col0 + 1 + ${#StrLe[LC_DEFAULT]} ))"
	read -r Jogo

	case "$Jogo" in
		[1-3][1-3])
			if [ "${P[$Jogo]}" ]; then
				SetPos $((nCenterRow+7)) "$Col0"
				echo -n "$bold${StrEr1[LC_DEFAULT]}$red${P[$Jogo]}$reset <-$reset"
				read -r Jogo
				EraseLine $((nCenterRow+6)) "$(( Col0 + 1 + ${#StrLe[LC_DEFAULT]} ))"
				EraseLine $((nCenterRow+7)) "$ColIni"
				return 1
			fi
			Jogar "$Jogo" O
			((++Vez))
			return 0
			;;
		*)
			PrintCenter $((nCenterRow+7)) "${StrEr2[LC_DEFAULT]}"
			read -r Jogo
			EraseLine $((nCenterRow+6)) "0"
			EraseLine $((nCenterRow+7)) "0"
			return 1
			;;
	esac
}

Iniciar() {
	local Seconds

	Jogo=
	for i in {1..3}; {
		for j in {1..3}; {
			P["$i$j"]=
		}
	}

	clear
	PrintCenter $((nCenterRow-6)) "${Eng[LC_DEFAULT]}" "$red"
	display_board

	Seconds=$(date "+%S")
	case $(( Seconds % 5 )) in
		0)	Jogo=11; Saida=1;;
		1)	Jogo=13; Saida=2;;
		2)	Jogo=31; Saida=3;;
		3)	Jogo=33; Saida=4;;
		*)	Jogo=22;	Saida=5;;
	esac
	PrintPos $((nCenterRow+2)) $(( Col0 + 29)) "$yellow$Empate$reset"
	PrintPos $((nCenterRow+2)) $(( Col0 + 40)) "$red$Ganhei$reset"
}

# Jogando
Playing() {
	while true; do
		nJobs=0

		Iniciar
		Vez=0
		Jogo=$(RandomGame)
		while true; do
			if [ $Vez -eq 4 ] ; then
				Placar E
				break
			fi

			if (( nJobs )); then
				if ! UserPlayer; then
					continue
				fi
			fi

			for i in {1..3}; do
				LX[i]=0
				CX[i]=0
				LO[i]=0
				CO[i]=0
				DX[i]=0
				DY[i]=0
				for j in {1..3}; do
					[ "${P[$i$j]}" = X ] && LX[i]=$((LX["$i"] + 1))
					[ "${P[$i$j]}" = O ] && LO[i]=$((LO["$i"] + 1))
					[ "${P[$j$i]}" = X ] && CX[i]=$((CX["$i"] + 1))
					[ "${P[$j$i]}" = O ] && CO[i]=$((CO["$i"] + 1))
				done
			done
			for i in 11 22 33; do
				[ "${P[$i]}" = X ] && DX[1]=$((DX[1] + 1))
				[ "${P[$i]}" = O ] && DY[1]=$((DY[1] + 1))
			done

			for i in 13 22 31; do
				[ "${P[$i]}" = X ] && DX[2]=$((DX[2] + 1))
				[ "${P[$i]}" = O ] && DY[2]=$((DY[2] + 1))
			done

			# Pra ganhar                       I wanna win!

			for i in {1..3}; do
				LAlinhadas[i]=$((LX[i] - LO[i]))
				CAlinhadas[i]=$((CX[i] - CO[i]))
				DAlinhadas[i]=$((DX[i] - DY[i]))
				if [ "${LAlinhadas[i]}" -eq 2 ]; then
					for j in {1..3}; do
						[ "${P[$i$j]}" ] && continue
						Jogo="$i$j"
						Jogar "$Jogo" X
						Placar G L
						break 3
					done
				fi
				if [ "${CAlinhadas[i]}" -eq 2 ]; then
					for j in {1..3}; do
						[ "${P[$j$i]}" ] && continue
						Jogo="$j$i"
						Jogar "$Jogo" X
						Placar G C
						break 3
					done
				fi
			done
			if [ "${DAlinhadas[1]}" -eq 2 ]; then
				for i in 11 22 33; do
					[ "${P[$i]}" ] && continue
					Jogo="$i"
					Jogar "$Jogo" X
					Placar G D1
					break 2
				done
			fi
			if [ "${DAlinhadas[2]}" -eq 2 ]; then
				for i in 13 22 31; do
					[ "${P[$i]}" ] && continue
					Jogo="$i"
					Jogar "$Jogo" X
					Placar G D2
					break 2
				done
			fi

			# Pra nao perder                   I don't wanna lose

			for i in {1..3}; do
				if [ "${LAlinhadas[i]}" -eq -2 ]; then
					for j in {1..3}; do
						[ "${P[$i$j]}" ] && continue
						Jogo="$i$j"
						Jogar "$Jogo" X
						continue 3
					done
				fi
				if [ "${CAlinhadas[i]}" -eq -2 ]; then
					for j in {1..3}; do
						[ "${P[$j$i]}" ] && continue
						Jogo="$j$i"
						Jogar "$Jogo" X
						continue 3
					done
				fi
			done
			if [ "${DAlinhadas[1]}" -eq -2 ]; then
				for i in 11 22 33; do
					[ "${P[$i]}" ] && continue
					Jogo="$i"
					Jogar "$Jogo" X
					continue 2
				done
			fi
			if [ "${DAlinhadas[2]}" -eq -2 ]; then
				for i in 13 22 31; do
					[ "${P[$i]}" ] && continue
					Jogo="$i"
					Jogar "$Jogo" X
					continue 2
				done
			fi

			# Ao ataque!                       Let's attack!

			case "$Vez" in
			1) case "$Saida" in
				1) [ "${P[33]}" ] && Jogo=13 || Jogo=33 ;;
				2) [ "${P[31]}" ] && Jogo=33 || Jogo=31 ;;
				3) [ "${P[13]}" ] && Jogo=11 || Jogo=13 ;;
				4) [ "${P[11]}" ] && Jogo=31 || Jogo=11 ;;
				*) if   [ "${P[11]}" ]; then	Jogo=33
					elif [ "${P[33]}" ]; then	Jogo=11
					elif [ "${P[13]}" ]; then	Jogo=31
					else								Jogo=13
					fi ;;
				esac ;;
			*) [ "${P[22]}" ] && {
					Jogo=
					for i in 1 3; do
						for j in 1 3; do
							[ "${P[$i$j]}" ] &&
								{
									[ "${P[$j$i]}" ] && continue ||
										{
											Jogo="$j$i"
											break 2
										}
								} ||
								{
									Jogo="$i$j"
									break 2
								}
						done
					done
					[ "$Jogo" ] &&
						{
							Jogar "$Jogo" X
							continue
						}
					for i in {1..3}; do
						for j in {1..3}; do
							[ "${P[$i$j]}" ] && continue
							Jogo="$i$j"
							break 2
						done
					done
				} || Jogo=22 ;;
			esac
			Jogar "$Jogo" X
		done
		SetPos $((nCenterRow+8)) "$Col0"
		read -rp "${StrFim[LC_DEFAULT]}"
		[ "${REPLY^}" == N ] && exit
	done
}

sh_checkDependencies
sh_setvarcolors
sh_configvar
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
      -e|--emoji) emoji=1; shift;;
      -n|--nocolor)  sh_unsetvarcolors; shift;;
      -V|--version)  sh_version; exit 0;;
      -h|--help)     sh_usage; exit 0;;
		--) shift; break ;;
		*) echo "Invalid option"; exit 1 ;;
   esac
done

Playing
