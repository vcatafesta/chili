#!/bin/bash

#fatorial
#seq -s* 6 | bc
#cat <(echo xxx; sleep 3; echo yyy; sleep 3)
#ls | cut -d. -sf2-  | sort | uniq -c
#source=($pkgname-${pkgver//_/-}.tar.gz)

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
BOOTLOG=/tmp/bootlog-$USER
KILLDELAY=3
SCRIPT_STAT="0"

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

OK=1
NOK=0
true=1
TRUE=1
false=0
FALSE=0
LINSTALLED=2
LREMOVED=3
declare -l BAIXA=${MENSAGEM}
declare -u ALTA=${MENSAGEM}

# SUBROUTINES

function colorize()
{
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
    printf "${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
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

function log_info_msg(){
    echo -n -e "${BMPREFIX}${@}"
    logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
    timespec
    echo -n -e "${STAMP} ${logmessage}" >> ${BOOTLOG}
    return 0
}

function log_warning_msg()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${WARNING_PREFIX}${SET_COL}${WARNING_SUFFIX}"

    # Strip non-printable characters from log file
    logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
    timespec
    echo -e "${STAMP} ${logmessage} WARN" >> ${BOOTLOG}
    return 0
}

function log_failure_msg2()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${FAILURE_PREFIX}${SET_COL}${FAILURE_SUFFIX}"
    echo "FAIL" >> ${BOOTLOG}
    return 0
}

function log_success_msg2()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${SUCCESS_PREFIX}${SET_COL}${SUCCESS_SUFFIX}"
    echo " OK" >> ${BOOTLOG}
    return 0
}

function log_wait_msg()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${WAIT_PREFIX}${SET_COL}${WAIT_SUFFIX}"
    echo " OK" >> ${BOOTLOG}
    return 0
}

function evaluate_retval()
{
   local error_value="${?}"

   if [ ${error_value} = 0 ]; then
		log_success_msg2
   else
      	log_failure_msg2
   fi
	return ${error_value}
}

function sh_checkparametros()
{
    LAUTO=$false
    LFORCE=$false
    LLIST=$true
    local param=$@
    local s

    for s in ${param[@]}
    do
        [[ $(toupper "${s}") = "-Y" ]] && LAUTO=$true
        [[ $(toupper "${s}") = "-F" ]] && LFORCE=$true
        [[ $(toupper "${s}") = "OFF" ]] && LLIST=$false
    done
}

function info()
{
    dialog 				\
    --beep				\
    --title     "FETCH"	\
    --backtitle "fetch"	\
    --msgbox    "$*"	\
    15 70
}

function sh_info()
{
    dialog 				\
    --beep				\
    --title     "FETCH"	\
    --backtitle "fetch"	\
    --msgbox    "$*"	\
    15 70
}

function importlib()
{
	for lib in "$LIBRARY"/*.sh; do
		source "$lib"
	done
}

function toupper()
{
    declare -u TOUPPER=${@}
    echo ${TOUPPER}
}

function tolower()
{
    declare -l TOLOWER=${@}
    echo ${TOLOWER}
}

function now()
{
    printf "%(%m-%d-%Y %H:%M:%S)T\n" $(date +%s)
}

function strzero()
{
    printf "%0*d" $2 $1
}

function replicate()
{
    for c in $(seq 1 $2);
    do
        printf "%s" $1
    done
}

function maxcol()
{
    if [ -z "${COLUMNS}" ]; then
       COLUMNS=$(stty size)
       COLUMNS=${COLUMNS##* }
    fi
    return $COLUMNS
}

function inkey()
{
    read -t "$1" -n1 -r -p "" lastkey
}

# simulando bash com echo
# Vilmar Catafesta <vcatafesta@gmail.com>
function _cat()
{
	echo "$(<$1)"
}


# Modulo para emular o comando cat
# Agradecimentos a SlackJeff
# https://github.com/slackjeff/bananapkg
function _CAT()
{
    # Tag para sinalizar que precisa parar.
    local end_of_file='EOF'

    INPUT=( "${@:-"%"}" )
    for i in "${INPUT[@]}"; do
        if [[ "$i" != "%" ]]; then
            exec 3< "$i" || return 1
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

# Módulo para emular o comando wc
# Está funcionando por enquanto somente para linhas.
# Agradecimentos a SlackJeff
# https://github.com/slackjeff/bananapkg
function _WC()
{
    local check="$@" # Recebendo args
    local inc='0'    # Var incremento

    for x in $check; do
        let inc++
    done
    echo "$inc"
    return 0
}

function setvarcolors()
{
    if tput setaf 1 &> /dev/null; then
        tput sgr0; # reset colors
        bold=$(tput bold);
        reset=$(tput sgr0);
        black=$(tput setaf 0);
        blue=$(tput setaf 33);
        cyan=$(tput setaf 37);
        green=$(tput setaf 64);
        orange=$(tput setaf 166);
        purple=$(tput setaf 125);
        red=$(tput setaf 124);
        violet=$(tput setaf 61);
        white=$(tput setaf 15);
        yellow=$(tput setaf 136);
		pink="\033[35;1m";
    else
        bold='';
        reset="\e[0m";
        black="\e[1;30m";
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
    fi
}

function sh_msgdoevangelho()
{
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
    echo -e "${blue}${msg}${reset}\n"
}

function sh_cdroot()
{
	cd - >/dev/null 2>&1
}

function sh_checknet()
{
    # have internet?
	log_info_msg "${cyan}Testing internet"
#   ping -c3 -q $(echo $SITE | sed 's/http:\/\///g') >/dev/null 2>&1 || { evaluate_retval; log_failure_msg2 "No route to server ($SITE) - ABORTED."; return 1 ;}
    curl -k $SITE >/dev/null 2>&1 || { evaluate_retval; log_failure_msg2 "No route to server ($SITE) - ABORTED."; return 1 ;}
    evaluate_retval
	return $?
}

function spinner()
{
	spin=('\' '|' '/' '-' '+')

	while :; do
		for i in "${spin[@]}"; do
			echo -ne "${cyan}\r$i${reset}"
			#sleep 0.1
		done
	done
}

function sh_checkroot()
{
	if [ "$(id -u)" != "0" ]; then
		log_failure_msg2 "ERROR: This script must be run with root privileges."
		exit
	fi
}

function conf()
{
    read -p "$1 [Y/n]"
    [[ ${REPLY^} == "" ]] && return $true
    [[ ${REPLY^} == N ]] && return $false || return $true
}

function confok()
{
    read -p "$1 [Y/n]"
    [[ ${REPLY^} == "" ]] && return $true
    [[ ${REPLY^} == N ]] && return $false || return $true
}

function confno()
{
    read -p "$1 [N/y]"
    [[ ${REPLY^} == "" ]] && return $false
    [[ ${REPLY^} == N  ]] && return $false || return $true
}

function sh_version()
{
    echo -e "$0 $_VERSION_"
    echo
}

#figlet
function sh_logo()
{
	_CAT << 'EOF'
  __      _       _
 / _| ___| |_ ___| |__
| |_ / _ \ __/ __| '_ \
|  _|  __/ || (__| | | |
|_|  \___|\__\___|_| |_|
EOF
	sh_version
}

function build()
{
    export r=$PWD
    export srcdir=$PWD
    alias r="cd $r"
#   pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $4}'|sed 's/-/ /g')
#   pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/ /g')
    pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/_/g'| sed 's/\(.*\)_/\1 /')
    arr=($pkg)
    [[ ${#arr[*]} -gt 2 ]] && pkg="${arr[0]}_${arr[1]} ${arr[2]}"
    log_success_msg2 "Criando pacote... $pkg"
    inst $pkg
    evaluate_retval
}

function ban()
{
    pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}')
    arr=($pkg)
    log_success_msg2 "Instalandoo pacote... $pkg-1.chi"
    pushd /lfs/build/
    banana -i "$pkg-2.chi"
    popd
    evaluate_retval
}

function genalien()
{
	export r=$PWD
	export srcdir=$PWD
	alias r="cd $r"
	if [ $# -lt 1 ]; then
		pkg=$(echo $PWD |sed 's/\// /g' | awk '{print $NF}'|sed 's/-x86_64.pkg.tar.xz//g'|sed 's/-any.pkg.tar.xz//g'| sed 's/\(.*\)_/\1 /')
	else
		pkg=$1
	fi

	log_success_msg2 "Criando pacote... $pkg"
	instalien $pkg "G"
	evaluate_retval
}

function instalien()
{
    local false=1
    local true=0
    local lgenerate=$false
    BUILDDIR="${BUILDDIR:-/lfs/build}"
    log_wait_msg "Criando diretorios de trabalho..."
    mkdir -p $BUILDDIR
    PKG=$1
    test -d $BUILDDIR/$PKG || mkdir -p $BUILDDIR/$PKG

    if [ "${2}" = "G" ]; then
        lgenerate=$true
    fi

    log_wait_msg "Instalando pacote em $BUILDIR/$PKG..."
    if [ $lgenerate = $false ]; then
        make -j1 install DESTDIR=$BUILDDIR/$PKG/
        log_wait_msg "Striping arquivos..."
        strip -s $BUILDDIR/$PKG/usr/bin/* > /dev/null 2>&1
        strip -s $BUILDDIR/$PKG/usr/sbin/* > /dev/null 2>&1

        log_wait_msg "Gziping arquivos..."
        for i in $BUILDDIR/$PKG/usr/share/man/man{1..9}/*
        do
            gzip -9 $i
        done
    fi

    log_wait_msg "Criando pacote..."
    cd $BUILDDIR/$PKG/

    if [ "$2" = "" ]; then
        sh_generatepkg "$PKG"
        cd $BUILDDIR/$PKG/info/
        #nano desc
    fi
    if [ $lgenerate = $true ]; then
		sh_generatepkg "$PKG"
    fi

    cd $BUILDDIR/$PKG/
    export l=$BUILDDIR/$PKG
    export pkgdir=$BUILDDIR/$PKG
    alias l="cd $l"
    if [ $lgenerate = $false ]; then
		sh_createpkg -c $PKG-2.chi
    fi
}

as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}
export -f as_root

function bcpalien()
{
    export l=$PWD
    pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}')
#   pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $3}')

    log_wait_msg "Criando pacote... $pkg"
    log_wait_msg "Gziping arquivos..."
    for i in $PWD/usr/share/man/man{1..9}/*
    do
        #find -iname *.gz -exec gunzip -f {} \;
#       gzip -9 $i &>/dev/null
        gzip -9 $i
    done
    log_wait_msg "Chamando o bananapkg..."
    echo
    banana -c $pkg.chi
    evaluate_retval
}
