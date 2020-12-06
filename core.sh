#!/bin/bash
# awk -F: '{print $1}' /var/cache/fetch/search/packages-split | grep ^python$

#fatorial
#seq -s* 6 | bc
#cat <(echo xxx; sleep 3; echo yyy; sleep 3)
#ls | cut -d. -sf2-  | sort | uniq -c
#source=($pkgname-${pkgver//_/-}.tar.gz)

IFS=$' \t\n'
SAVEIFS=$IFS

OK=1
NOK=0
NEG=1
true=1
TRUE=1
false=0
FALSE=0
LINSTALLED=2
LREMOVED=3
LAUTO=0
LFORCE=0
LLIST=0
verbose=1

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	rst=$(tput sgr0);
	rs=$(tput sgr0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
#	green=$(tput setaf 64);
	green=$(tput setaf 2);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
	yellow=$(tput setaf 129);
	black=$(tput setaf 0);
else
	bold='';
	reset="\e[0m";
	rst="\e[0m";
	rs="\e[0m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
	pink="\033[35;1m";
	black="\e[1;30m";
fi

#hex code
barra=$'\x5c'
check=$'\0xfb'
reg=$'\0x2a'
SYSCONFDIR='/etc/fetch'
NORMAL="\\033[0;39m"         # Standard console grey
SUCCESS="\\033[1;32m"        # Success is green
WARNING="\\033[1;33m"        # Warnings are yellow
FAILURE="\\033[1;31m"        # Failures are red
INFO="\\033[1;36m"           # Information is light cyan
BRACKET="\\033[1;34m"        # Brackets are blue
BMPREFIX="     "
DOTPREFIX="  ${blue}::${reset} "
SUCCESS_PREFIX="${SUCCESS}  *  ${NORMAL}"
FAILURE_PREFIX="${FAILURE}*****${NORMAL}"
WARNING_PREFIX="${WARNING}  W  ${NORMAL}"
SKIP_PREFIX="${INFO}  S  ${NORMAL}"
SUCCESS_SUFFIX="${BRACKET}[${SUCCESS}  OK  ${BRACKET}]${NORMAL}"
FAILURE_SUFFIX="${BRACKET}[${FAILURE} FAIL ${BRACKET}]${NORMAL}"
WARNING_SUFFIX="${BRACKET}[${WARNING} WARN ${BRACKET}]${NORMAL}"
SKIP_SUFFIX="${BRACKET}[${INFO} SKIP ${BRACKET}]${NORMAL}"
WAIT_PREFIX="${WARNING}  R  ${NORMAL}"
WAIT_SUFFIX="${BRACKET}[${WARNING} WAIT ${BRACKET}]${NORMAL}"
FAILURE_PREFIX="${FAILURE}  X  ${NORMAL}"
BOOTLOG=/tmp/fetchlog-$USER
KILLDELAY=3
SCRIPT_STAT="0"
LKEEP=$false

if [ -z "${COLUMNS}" ]; then
   COLUMNS=$(stty size)
   COLUMNS=${COLUMNS##* }
fi
if [ "${COLUMNS}" = "0" ]; then
   COLUMNS=80
fi

COL=$((${COLUMNS} - 8))
WCOL=$((${COL} - 2))
SET_COL="\\033[${COL}G"      # at the $COL char
SET_WCOL="\\033[${WCOL}G"    # at the $WCOL char
CURS_UP="\\033[1A\\033[0G"   # Up one line, at the 0'th char
CURS_ZERO="\\033[0G"

# flag's para split package
: ${aPKGSPLIT=()}
: ${aPKGLIST=}
: ${PKG_FOLDER_DIR=0}
: ${PKG_FULLNAME=1}
: ${PKG_ARCH=2}
: ${PKG_BASE=3}
: ${PKG_BASE_VERSION=4}
: ${PKG_VERSION=5}
: ${PKG_BUILD=6}

# SUBROUTINES

function cpad(){
	# centralizar string
	COLS=$(tput cols)
	printf "%*s\n" $[$COLS/2] "${1}"
}

function rpad(){
	# justificar à direita
	COLS=$(tput cols)
	printf "%*s\n" $COLS "${1}"
}

function lpad(){
	# justificar à esquerda + $2 espacos
	COLS=$(tput cols)
	printf "%ds\n" ${2} "${1}"
}

function sh_cdroot(){
	cd - >/dev/null 2>&1
}

function colorize(){
    if tput setaf 0 &>/dev/null; then
        ALL_OFF="$(tput sgr0)"
        BOLD="$(tput bold)"
        BLUE="${BOLD}$(tput setaf 4)"
        GREEN="${BOLD}$(tput setaf 2)"
        RED="${BOLD}$(tput setaf 1)"
        YELLOW="${BOLD}$(tput setaf 3)"
    else
        ALL_OFF="\e[0m"
        BOLD="\e[1m"
        BLUE="${BOLD}\e[34m"
        GREEN="${BOLD}\e[32m"
        RED="${BOLD}\e[31m"
        YELLOW="${BOLD}\e[33m"
    fi
    readonly ALL_OFF BOLD BLUE GREEN RED YELLOW
}

function plain()
{
	local mesg=$1; shift
	printf "${BOLD}    ${mesg}${ALL_OFF}\n" "$@" >&2
}

function msg()
{
	local mesg=$1; shift
	printf "${GREEN}  =>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

function msg2()
{
	local mesg=$1; shift
	printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

function warning()
{
	local mesg=$1; shift
	printf "${YELLOW}==> $(gettext "WARNING:")${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

function error()
{
	local mesg=$1; shift
	printf "${RED}==> $(gettext "ERROR:")${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

function timespec()
{
	STAMP="$(echo `date +"%b %d %T %:z"` `hostname`) "
	return 0
}

function log_msg()
{
	#echo -n -e "${DOTPREFIX}${@}\n"
	printf "${DOTPREFIX}${@}\n"
	return 0
}

function log_info_msg()
{
	#echo -n -e "${BMPREFIX}${@}"
	printf "${BMPREFIX}${@}"
	#logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
	#timespec
	#echo -n -e "${STAMP} ${logmessage}" >> ${BOOTLOG}
	return 0
}

function log_warning_msg()
{
	#echo -n -e "${BMPREFIX}${@}"
	printf "${BMPREFIX}${@}"
	printf "${CURS_ZERO}${WARNING_PREFIX}${SET_COL}${WARNING_SUFFIX}\n"

	# Strip non-printable characters from log file
	#logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
	#timespec
	#echo -e "${STAMP} ${logmessage} WARN" >> ${BOOTLOG}
	return 0
}

function log_failure_msg()
{
	#echo -n -e "${BMPREFIX}${@}"
	#echo -e "${CURS_ZERO}${FAILURE_PREFIX}${SET_COL}${FAILURE_SUFFIX}"
	printf "${BMPREFIX}${@}"
	printf "${CURS_ZERO}${FAILURE_PREFIX}${SET_COL}${FAILURE_SUFFIX}\n"
	#echo "FAIL" >> ${BOOTLOG}
	return 0
}

function log_failure_msg2()
{
	#echo -n -e "${BMPREFIX}${@}"
	#echo -e "${CURS_ZERO}${FAILURE_PREFIX}${SET_COL}${FAILURE_SUFFIX}"
	printf "${BMPREFIX}${@}"
	printf "${CURS_ZERO}${FAILURE_PREFIX}${SET_COL}${FAILURE_SUFFIX}\n"
	#echo "FAIL" >> ${BOOTLOG}
	return 0
}

function log_success_msg2()
{
	#echo -n -e "${BMPREFIX}${@}"
	#echo -e "${CURS_ZERO}${SUCCESS_PREFIX}${SET_COL}${SUCCESS_SUFFIX}"
	printf "${BMPREFIX}${@}"
	printf "${CURS_ZERO}${SUCCESS_PREFIX}${SET_COL}${SUCCESS_SUFFIX}\n"
	#echo " OK" >> ${BOOTLOG}
	return 0
}

function log_wait_msg()
{
	#echo -n -e "${BMPREFIX}${@}"
	#echo -e "${CURS_ZERO}${WAIT_PREFIX}${SET_COL}${WAIT_SUFFIX}"
	printf "${BMPREFIX}${@}"
	printf "${CURS_ZERO}${WAIT_PREFIX}${SET_COL}${WAIT_SUFFIX}\n"
	echo " OK" >> ${BOOTLOG}
	return 0
}

function die()
{
	local msg=$1; shift
   log_failure_msg2 "${red}$msg" "$@" >&2
	exit 1
}

function evaluate_retval()
{
   local error_value="${?}"

	if [ $# -gt 0 ]; then
   	error_value="${1}"
	fi

	if [ ${error_value} = 0 ]; then
		log_success_msg2
	else
		log_failure_msg2
	fi
	return ${error_value}
}

function info(){
#	dialog							\
	whiptail							\
		--title     "[debug]$0"	\
		--backtitle "\n$*\n"	   \
		--yesno     "${1}"		\
	0 0
	result=$?
	if (( $result )); then
		exit
	fi
	return $result
}
export -f info

# Módulo para emular o comando cat
function _CAT(){
    # Tag para sinalizar que precisa parar.
    local end_of_file='EOF'

    INPUT=( "${@:-"%"}" )
    for i in "${INPUT[@]}"; do
        if [[ "$i" != "%" ]]; then
            exec 3< "$i" || exit 1
        else
            exec 3<&0
        fi
        while read -ru 3; do
            # END OF FILE. Para identificar que precisa parar.
            [[ "$REPLY" = "$end_of_file" ]] && break
            echo -E "$REPLY"
        done
    done
}

# Módulo para emular o grep
function _GREP(){
    # Se encontrar a linha ele retorna a expressão encontrada! com status 0
    # se não é status 1.
    # Para utilizar este módulo precisa ser passado o argumento seguido do arquivo.
    # ou variável.
    local expression="$1"
    local receive="$2"

    # Testando e buscando expressão.
    if [[ -z "$expression" ]]; then
        { echo 'MODULE _GREP ERROR. Not found variable $expression'; exit 1 ;}
    elif [[ -z "$receive" ]]; then
        { echo 'MODULE _GREP ERROR. Not found variable $receive'; exit 1 ;}
    fi
    while IFS= read line; do
        [[ "$line" =~ $expression ]] && { echo "$line"; return 0;}
    done < "$receive"
	 IFS=$SAVEIFS
    return 1
}

# Módulo para emular o comando wc
# Está funcionando por enquanto somente para
# linhas.
function _WC(){
    local check="$@" # Recebendo args
    local inc='0'    # Var incremento

    for x in $check; do
        let inc++
    done
    echo "$inc"
    return 0
}

function importlib(){
	for lib in "$LIBRARY"/*.sh; do
		source "$lib"
	done
}

function toupper(){
    declare -u TOUPPER=${@}
    echo ${TOUPPER}
}

function tolower(){
    declare -l TOLOWER=${@}
    echo ${TOLOWER}
}

function now(){
    printf "%(%m-%d-%Y %H:%M:%S)T\n" $(date +%s)
}

function strzero(){
    printf "%0*d" $2 $1
}

function replicate(){
	for c in $(seq 1 $2);
	do
		printf "%s" $1
	done
}

function maxcol(){
	if [ -z "${COLUMNS}" ]; then
		COLUMNS=$(stty size)
		COLUMNS=${COLUMNS##* }
	fi
	return $COLUMNS
}

function inkey(){
	read -t "$1" -n1 -r -p "" lastkey
}

# simulando bash com echo
# Vilmar Catafesta <vcatafesta@gmail.com>
function _cat(){
	echo "$(<$1)"
}

function setvarcolors(){
	if tput setaf 1 &> /dev/null; then
		tput sgr0; # reset colors
		bold=$(tput bold);
		reset=$(tput sgr0);
		rst=$(tput sgr0);
		rs=$(tput sgr0);
		blue=$(tput setaf 33);
		cyan=$(tput setaf 37);
#		green=$(tput setaf 64);
		green=$(tput setaf 2);
		orange=$(tput setaf 166);
		purple=$(tput setaf 125);
		red=$(tput setaf 124);
		violet=$(tput setaf 61);
		white=$(tput setaf 15);
		yellow=$(tput setaf 136);
		pink=$(tput setaf 129);
		black=$(tput setaf 0);
	else
		bold='';
		reset="\e[0m";
		rst="\e[0m";
		rs="\e[0m";
		reset="\e[0m";
		blue="\e[1;34m";
		cyan="\e[1;36m";
		green="\e[1;32m";
		orange="\e[1;33m";
		purple="\e[1;35m";
		red="\e[1;31m";
		violet="\e[1;35m";
		white="\e[1;37m";
		yellow="\e[1;33m";
		pink="\033[35;1m";
		black="\e[1;30m";
	fi
}

function unsetvarcolors(){
	bold=
	reset=
	black=
	blue=
	cyan=
	green=
	orange=
	purple=
	red=
	violet=
	white=
	yellow=
	pink=
}

function sh_msgdoevangelho(){
	local total
	local id
	local msg

	frases=(
		"Seja fiel até a morte, e eu te darei a coroa da vida! Ap 2:10"
		"O que adianta o homem ganhar o mundo inteiro e perder sua alma?"
		"Deus está com você!"
		"Deus não falha!"
		"A recompensa é boa!"
		"A recompensa é eterna!"
		"As dificuldades e os sofrimentos vão passar"
		"Não desista, Deus tem grandes planos para você"
	)

	total=${#frases[@]}
	id=$(( $RANDOM % $total ))
	msg="${frases[$id]}"
	printf "${blue}${msg}${reset}\n"
}

function spinner(){
	spin=('\' '|' '/' '-' '+')

	while :; do
		for i in "${spin[@]}"; do
			echo -ne "${cyan}\r$i${reset}"
			#sleep 0.1
		done
	done
}

function sh_checkroot(){
	if [ "$(id -u)" != "0" ]; then
		log_failure_msg2 "ERROR: This script must be run with root privileges."
		exit
	fi
}

function sh_version(){
	printf "$0 $_VERSION_\n"
	echo
}

function conf(){
    read -p "$1 [Y/n]"
    [[ ${REPLY^} == "" ]] && return $true
    [[ ${REPLY^} == N ]] && return $false || return $true
}

function confok(){
	read -p "$1 [Y/n]"
	[[ ${REPLY^} == "" ]] && return $true
	[[ ${REPLY^} == N ]] && return $false || return $true
}

function confno(){
	read -p "$1 [N/y]"
	[[ ${REPLY^} == "" ]] && return $false
	[[ ${REPLY^} == N  ]] && return $false || return $true
}

function DOT()
{
	printf "${blue}:: ${reset}"
	return
}

function sh_adel()
{
	#removendo duplicados e ordenando
	local arr=${1}
	local item

	> /tmp/.array >/dev/null 2>&1
	for item in ${arr[*]}
	do
		echo $item >> /tmp/.array    #imprime o conteudo da matriz
	done
	unset arr
	unset deps
	deps=$(uniq --ignore-case <<< $(sort /tmp/.array))
	[[ -e /tmp/.array ]] && rm /tmp/.array >/dev/null 2>&1
	return $?
}

function print(){
	[[ "$printyeah" = '1' ]] && echo -e "$@"
}

function fmt(){
	printf "${pink}(j#${ncount}:8/f#${ntotalpkg}:${nfullpkg})${reset}"
	return $?
}

checkDependencies(){
  local errorFound=0

  for command in "${DEPENDENCIES[@]}"; do
    if ! which "$command"  &> /dev/null ; then
      echo "ERRO: não encontrei o comando '$command'" >&2
      errorFound=1
    fi
  done

  if [[ "$errorFound" != "0" ]]; then
    echo "---IMPOSSÍVEL CONTINUAR---"
    echo "Esse script precisa dos comandos listados acima" >&2
    echo "Instale-os e/ou verifique se estão no seu \$PATH" >&2
    exit 1
  fi
}

function sh_checkparametros()
{
	local param=$@
	local s

	for s in ${param[@]}
	do
		[[ $(toupper "${s}") = "--quiet" ]]   && verbose=0
		[[ $(toupper "${s}") = "-q" ]]   	  && verbose=0
		[[ $(toupper "${s}") = "--NOCOLOR" ]] && unsetvarcolors;USE_COLOR='n'
		[[ $(toupper "${s}") = "-Y" ]]        && LAUTO=$true
		[[ $(toupper "${s}") = "-F" ]]        && LFORCE=$true
		[[ $(toupper "${s}") = "OFF" ]]       && LLIST=$false
	done
}

#   parseopts.sh - getopt_long-like parser
#
#   Copyright (c) 2012-2020 Pacman Development Team <pacman-dev@archlinux.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# A getopt_long-like parser which portably supports longopts and
# shortopts with some GNU extensions. It does not allow for options
# with optional arguments. For both short and long opts, options
# requiring an argument should be suffixed with a colon. After the
# first argument containing the short opts, any number of valid long
# opts may be be passed. The end of the options delimiter must then be
# added, followed by the user arguments to the calling program.
#
# Recommended Usage:
#   OPT_SHORT='fb:z'
#   OPT_LONG=('foo' 'bar:' 'baz')
#   if ! parseopts "$OPT_SHORT" "${OPT_LONG[@]}" -- "$@"; then
#     exit 1
#   fi
#   set -- "${OPTRET[@]}"
# Returns:
#   0: parse success
#   1: parse failure (error message supplied)
parseopts() {
	local opt= optarg= i= shortopts=$1
	local -a longopts=() unused_argv=()

	shift
	while [[ $1 && $1 != '--' ]]; do
		longopts+=("$1")
		shift
	done
	shift

	longoptmatch() {
		local o longmatch=()
		for o in "${longopts[@]}"; do
			if [[ ${o%:} = "$1" ]]; then
				longmatch=("$o")
				break
			fi
			[[ ${o%:} = "$1"* ]] && longmatch+=("$o")
		done

		case ${#longmatch[*]} in
			1)
				# success, override with opt and return arg req (0 == none, 1 == required)
				opt=${longmatch%:}
				if [[ $longmatch = *: ]]; then
					return 1
				else
					return 0
				fi ;;
			0)
				# fail, no match found
				return 255 ;;
			*)
				# fail, ambiguous match
				printf "${0##*/}: $(gettext "option '%s' is ambiguous; possibilities:")" "--$1"
				printf " '%s'" "${longmatch[@]%:}"
				printf '\n'
				return 254 ;;
		esac >&2
	}

	while (( $# )); do
		case $1 in
			--) # explicit end of options
				shift
				break
				;;
			-[!-]*) # short option
				for (( i = 1; i < ${#1}; i++ )); do
					opt=${1:i:1}

					# option doesn't exist
					if [[ $shortopts != *$opt* ]]; then
						printf "${0##*/}: $(gettext "invalid option") -- '%s'\n" "$opt" >&2
						OPTRET=(--)
						return 1
					fi

					OPTRET+=("-$opt")
					# option requires optarg
					if [[ $shortopts = *$opt:* ]]; then
						# if we're not at the end of the option chunk, the rest is the optarg
						if (( i < ${#1} - 1 )); then
							OPTRET+=("${1:i+1}")
							break
						# if we're at the end, grab the the next positional, if it exists
						elif (( i == ${#1} - 1 )) && [[ $2 ]]; then
							OPTRET+=("$2")
							shift
							break
						# parse failure
						else
							printf "${0##*/}: $(gettext "option requires an argument") -- '%s'\n" "$opt" >&2
							OPTRET=(--)
							return 1
						fi
					fi
				done
				;;
			--?*=*|--?*) # long option
				IFS='=' read -r opt optarg <<< "${1#--}"
				longoptmatch "$opt"
				case $? in
					0)
						# parse failure
						if [[ $optarg ]]; then
							printf "${0##*/}: $(gettext "option '%s' does not allow an argument")\n" "--$opt" >&2
							OPTRET=(--)
							return 1
						# --longopt
						else
							OPTRET+=("--$opt")
						fi
						;;
					1)
						# --longopt=optarg
						if [[ $optarg ]]; then
							OPTRET+=("--$opt" "$optarg")
						# --longopt optarg
						elif [[ $2 ]]; then
							OPTRET+=("--$opt" "$2" )
							shift
						# parse failure
						else
							printf "${0##*/}: $(gettext "option '%s' requires an argument")\n" "--$opt" >&2
							OPTRET=(--)
							return 1
						fi
						;;
					254)
						# ambiguous option -- error was reported for us by longoptmatch()
						OPTRET=(--)
						return 1
						;;
					255)
						# parse failure
						printf "${0##*/}: $(gettext "invalid option") '--%s'\n" "$opt" >&2
						OPTRET=(--)
						return 1
						;;
				esac
				;;
			*) # non-option arg encountered, add it as a parameter
				unused_argv+=("$1")
				;;
		esac
		shift
	done

	# add end-of-opt terminator and any leftover positional parameters
	OPTRET+=('--' "${unused_argv[@]}" "$@")
	unset longoptmatch

	return 0
}

