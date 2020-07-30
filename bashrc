#!/usr/bin/env bash

#wget https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS -O ~/.dircolors
eval $(dircolors -b $HOME/.dircolors)
shopt -s cdspell
shopt -s dotglob        # ls *bash*
shopt -s extglob        # ls file?(name); ls file*(name); ls file+(name); ls file+(name|utils); ls file@(name|utils)
#shopt -s nullglob			# suppress error message of a command

ulimit -n 32767
#source /lib/lsb/init-functions
#export PS1='\u@\h:\w\$\[\033[01;31m\]\u@\h[\033[01;34m\]\w \[\e[1;31m\]\$ \[\033[00m\]'
#export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\$\[\033[01;34m\]\w\[\e[1;31m\]\$ \[\033[00m\]'
#export PS1='\[\033[01;31m\]${debian_chroot:+($debian_chroot)}\u@\h[\033[01;34m\]\w \[\e[1;31m\]\$ \[\033[00m\]'
#export DISPLAY=10.0.0.80:0.0
#export TZ=America/Porto_Velho
#export GREP_OPTIONS='-n --color=auto'
export ROOTDIR=${PWD#/} ROOTDIR=/${ROOTDIR%%/*}
export PATH="/usr/bin:/usr/sbin:/bin:/sbin:/tools/bin:/usr/local/bin:/usr/local/sbin"
#export LD_LIBRARY_PATH=/lib:/usr/lib
export EDITOR=nano

#harbour
#export HB_INSTALL_PREFIX=/usr
#export HB_BUILD_CONTRIBS="yes"
#export HB_BUILD_MODE="cpp"
#export WINEDEBUG=-all

#processadores=$(nproc)
#set +h
#umask 022
#export LFS=/mnt/lfs
#export LC_ALL=POSIX
#export LFS_TGT=$(uname -m)-lfs-linux-gnu
export MAKEFLAGS='-j 4'

# unlias -remove alias
# unalias alias_name
# unalias -a # remove all aliases
# unset funcao - remove funcao alias

alias pacman="pacman --needed"
alias result='echo verdadeiro || echo falso'		# uso: [[ -f "$file" ]] && result #
alias lvma="lvm vgchange -a y -v" $1
alias src="cd /sources/blfs"
alias wget="wget --no-check-certificate"
#alias grep="grep --color=always"
#alias egrep="egrep -r -n --color=always"
#alias build="cd /home/vcatafesta/build/"
alias cda="cd /etc/apache2/sites-enabled"
alias cdx="cd /var/www/html"
alias pxe="cd /mnt/NTFS/software"
alias ed++="wine /home/vcatafesta/.wine/dosdevices/'c:/Program Files'/Notepad++/notepad++.exe $1 &"
alias discos="udisksctl status"
alias dd="dd status=progress conv=sync,noerror"
#alias grep="grep $1 -n --color=auto"
alias ack="ack -n --color-match=red"
alias tmm="tail -f /var/log/mail.log | grep ."
#alias win="sudo service lightdm start"
alias win="lightdm"
alias DIR=dir
alias github="cd /home/vcatafesta/github ; ls"
alias v="ssh -l vcatafesta -t balcao '/home/vcatafesta/SYS/sci/sci'"
alias backuptheme="rsync --progress -Cravzp --rsh='ssh -l root' root@10.0.0.80:/mnt/usr/share/grub/themes/ /usr/share/grub/themes/"
alias dude="wine /root/.wine/drive_c/'Program Files'/Dude/dude &"
alias rmake="hbmk2 -info"
alias sci="cd /mnt/c/sci/linux/; ./sci"
alias sl="cd /home/vcatafesta/sci/src.linux ; ls"

#alias ouvindo="netstat -anp | grep :69"
alias ouvindo="netstat -anp | grep :"
alias listen="netstat -anp | grep :"
alias portas="sockstat | grep ."
alias portas1="lsof -i | grep ."

alias ren=mv
alias ls="ls -h --color=auto"
alias dirm="ls -h -ls -Sr --color=auto"
alias dir="ls -la -c --color=auto"
alias dirt="dir -rt"
#alias dir="ls -h -ls -X --color=auto"
alias ed=nano
alias copy=cp
alias md=mkdir
alias rd=rmdir
alias del=rm
alias df="df -h --total | grep ."
alias mem="free -h"
alias cls=clear
#alias ddel1="rm -fvR"
#alias ddel2="find -iname $1 -type d | xargs rm -fvR"
alias ddel2="find -iname $1 | xargs rm --verbose"
alias ddel="find -name $1 | xargs rm -fvR"
alias fdisk="fdisk -l"
#alias portas="nmap -v $?"
alias portas="nmap -v localhost"
alias port="sockstat | grep ."
alias cdi="cd /home/vcatafesta/SYS/sci ; ls"
alias cds="cd /etc/rc.d/init.d ; ls"
alias cdd="cd /etc/systemd/system/ ; ls"
alias du="du -h"
#alias xcopy="cp -Rpvn"
alias cp="cp --force --verbose --preserve"
alias xcopy="cp --force --verbose --preserve -Rpv"
alias versao="lsb_release -a"
alias rdel="find -iname -exec rm -v {} \;"
alias ver="lsb_release -a"
alias cdg="cd /github/ChiliOS/packages/core/"
alias cdb="cd /github/ChiliOS/packages/"
alias cdp="cd /var/cache/pacman/pkg/"
#

alias start=sr
alias stop=st
alias restart="systemctl restart"
alias status="systemctl status"
alias reload="systemctl reload"
alias disable="systemctl disable"
alias enable="systemctl enable"
alias ativo="systemctl is-enabled"
alias reload="systemctl daemon-reload"
alias jornal="journalctl -xe"
#
alias backup-serviio="rsync --progress -Cravzp /home/public/ /mnt/home/serviio/public"
alias backup-sci.src="rsync --progress -Cravzp /home/drive_c_80/sci/ /home/sci.src/"
alias backup-sci="rsync --progress -Cravzp /home/drive_c_80/sys/sci/ /home/sys/sci/"
alias backup-mikrotik="rsync --progress -Cravzp /home/drive_c_80/sys/backup/ /home/sys/backup/"
alias backup-win95_cd="rsync --progress -Cravzp /home/drive_c_66/win95_cd/ /home/drive_c_80/win95_cd/"
alias backup-pmv="scp -prvC backup@primavera.sybernet.changeip.org:/ /home/vcatafesta/backup/primavera"
alias backup-pbw="scp -prvC backup@10.0.0.254:/ /home/vcatafesta/backup/rb-3011"
alias backup-rb1100="scp -prvC backup@172.31.255.2:/ /home/vcatafesta/backup/rb-1100"
alias rsync-pmv="rsync --progress -Cravzp --rsh='ssh -v -l backup' backup@primavera.sybernet.changeip.org:/ /home/vcatafesta/backup/primavera"
alias rsync-pbw="rsync --progress -Cravzp --rsh='ssh -v -l backup' backup@10.0.0.254:/ /home/vcatafesta/backup/rb-3011/"
alias dcomprimtar="tar -vzxf"
alias targz="tar -xzvf"
alias tarxz="tar -Jxvf"
alias tarbz2="tar -xvjf"
alias untar="tar -xvf"
alias pyc="python -OO -c 'import py_compile; py_compile.main()'"
alias tml="tail -f /var/log/lastlog"
#alias tms="tail -f /var/log/syslog"
alias tmd="tail -f /var/log/dnsmasq.log"
#alias tmm="tail -f /var/log/messages"
#alias tmk="tail -f /var/log/mikrotik/10.0.0.254.2018.01.log | grep: '^[0-9\.]*'"
alias tmk="multitail -f /var/log/mikrotik/10.0.0.254.2018.01.log"
alias smbmount="mount -t cifs -o username=vcatafesta,password=451960 //10.0.0.68/c /root/windows"
alias cd=cd

#man colour
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

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
BOOTLOG=/tmp/fetchlog-$USER
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

# SUBROUTINES


function ifsvalue()
{
	echo "default value"
	echo "0000000 0920 0a0a"
   echo "0000004"
	echo
	echo "$IFS" | od -h
}

function firstletter()
{
	word=$1
#	firstletter="$(echo $word | head -c 1)"
#	firstletter=$(echo "$word" | sed -e "{ s/^\(.\).*/\1/ ; q }")
#	firstletter="${word%"${word#?}"}"
#	firstletter=${word:0:1}
	firstletter=${word::1}
	echo $firstletter
}


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

function log_info_msg()
{
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

declare -l BAIXA=${MENSAGEM}
declare -u ALTA=${MENSAGEM}

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
#	declare -l TOLOWER=${@}
#	echo ${TOLOWER}
	for arquivo in $@
	do
		echo $arquivo
		mv "$arquivo" "${arquivo,,}"
	done
}

#!/usr/bin/env bash
# mvlower.sh

mvlower() {
  local filepath
  local dirpath
  local filename

  for filepath in "$@"; do
    # OBS: temos que preservar o path do diretório!
    dirpath=$(dirname "$filepath")
    filename=$(basename "$filepath")
    mv "$filepath" "${dirpath}/${filename,,}"
  done
}
#mvlower "$@"

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

prompt_git()
{
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
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
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\][SYSTEMD]\u@[$HOSTNAME]"; # username
PS1+="\[${white}\] at ";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\n";
PS1+="\[${white}\]\e[35;1m⚡\e[m\[${reset}\]"; # `#` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

#Filtra as linhas com o padrão especificado. Linhas que terminam com conf1
#ls -l /etc | awk /conf$/

#Usando outro separador de campos e imprimindo colunas
#cat /etc/passwd | awk -F: '{print $1}'

#Usando separador de campos
#ls -l /etc |awk '{print $1 FS $8}'

#Numerando linhas
#ls -l /etc | awk '{print NR FS$1 FS $8}'

#Filtra linhas com padrão especificado e mostra apenas as colunas 1 e 8.
#ls -l /etc | awk '/conf$/{print $1" "$8}'

#Imprime as linhas com mais de 3 campos. Elimina a primeira linha do ls -l (Total)
#ls -l /etc | awk 'NF > 3'

#Filtra linhas com arquivos cujos nomes possuem menos de 5 caracteres
#ls -l /etc | awk 'length($8) < 5'

#Imprime linhas pares
#ls -l /etc | awk 'NR % 2 == 0 {print NR" "$0}'

#Substitui strings
#ls -l /etc | awk '{sub(/conf$/,"test"); print $0}'

#Procura expressão em determinado campo
#ls -l /etc | awk '$8 ~ /^[ae]/'

#Inserindo strings entre campos
#cat /etc/passwd | awk -F: '{print "Login: " $1}'

#Filtra a saída de ls -l, a fim de mostrar o nome do arquivo, suas permissões e seu tamanho (a condição NR != 1 evita que a linha Total seja exibida):
#ls -l | awk 'NR != 1{print "Nome: "$8" Perm: "$1" Tamanho: "$5}'

#Imprime o comprimento da maior linha
#awk '{ if (length($0) > max) max = length($0)}; END { print max}'; arquivo

#Imprime as linhas com mais de 42 caracteres
#awk 'length($0) > 42' arquivo

#Exibe o número de linhas do arquivo
#awk 'END { print NR }' arquivo

function GREP_OPTIONS()
{
	#GREP_OPTIONS='-n --color=auto'
	GREP_OPTIONS='--color=auto'
}

function criartemp()
{
	#!/bin/bash
	#
	# bem simples vc da a quantidade de arquivo que quer
	# criar, e ele atribui o nome do arquivo (
	# este nome vc tambe fornece) com uma numeracao
	# como vc mesmo propos
	#
	# as definicoe scomecam com 0,1,2 etc...
	#
	# for((i=1;i<=${1};i++)) ; do touch a-${i}.tmp ; done

	let modo="0755"
	echo -e "Prefixo   :"; read arquivo
	echo -e "Extensao  :"; read ext
	echo -e "Quantidade:"; read quantidade
	echo -e "Modo      :"; read modo
	echo -e "Criando os arquivos...\n";
	variavel="0"
	while [ $variavel -lt $quantidade ]; do
	   arq=$arquivo$variavel
	   touch $arq.$ext
	   chmod $modo $arq.$ext
	   #echo -e "$arq.$ext criado \n"
	   echo -e $PWD"/$arq.$ext criado"
	   let variavel=variavel+1
	done
}

function printeradd()
{
    addprinter
}

function addprinter()
{
    sudo lpadmin -p LPT1    -E -v ipp://10.0.0.99/p1        -m everywhere -o print-is-shared=true -u allow:all
    sudo lpadmin -p LPT2    -E -v ipp://10.0.0.99/p2        -m everywhere -o print-is-shared=true -u allow:all
    sudo lpadmin -p LPT3    -E -v ipp://10.0.0.99/p3        -m everywhere -o print-is-shared=true -u allow:all
    sudo lpadmin -p SAMSUNG -E -v ipp://10.0.0.77/ipp/print -m everywhere -o print-is-shared=true -u allow:all
    sudo lpadmin -d LPT1
    sudo lpadmin -p DeskJet -E -v parallel:/dev/lp0 -m drv:///sample.drv/deskjet.ppd -u allow:all
    sudo lpadmin -p DotMatrix -E -m epson9.ppd -v serial:/dev/ttyS0?baud=9600+size=8+parity=none+flow=soft -u allow:all
    sudo lpadmin -p PRINTERNAME -E -v smb://10.0.0.68/P1 -L "LOCATION" -o auth-info-required=negotiate -u allow:all
}

function mostra()
{
    sudo lpstat -s
    sudo lpq

}

function cancela()
{
    sudo systemctl stop lprng
    sudo rm -rf /var/spool/lpd
    sudo rm /home/sci/LPT*
    sudo rm /home/sci/COM*
    sudo checkpc -f
    sudo systemctl start lprng
    sudo lprm
    sudo systemctl status lprng
}

newtemp() {
	#!/bin/bash
	if [ $# -lt 2 ]
	then
		# Imprime o nome do script "$0" (isso eh bom para tornar um template de script) e como usá-lo 
		echo "usar $0 <qtde> <ext>"
		# Sai do script com código de erro 1 (falha)
	else
		for((i=1;i<=${1};i++)) ; do touch tmp-${i}.${2} ; echo -e tmp-${i}.${2}; done
	fi
}

teste() {
	#!/bin/bash
	dir=/caminho/da/pasta
	if [ -e "$dir" ] ; then
		echo "o diretório {$dir} existe"
	else
		echo "o diretório {$dir} não existe"
	fi
}

atualizasci() {
	#!/bin/bash
	sl
	cp -v sci.dbf /home/vcatafesta/SYS/sci/sci.dbf
	cp -v sci.cfg /home/vcatafesta/SYS/sci/sci.cfg
	cp -v sci     /home/vcatafesta/SYS/sci/sci
	cp -v sci     /home/vcatafesta/SYS/sci/sci64
}

email(){
        #!/bin/bash
        echo "CORPO" | mail -s "Subject" -A /etc/bashrc vcatafesta@balcao
}

modo(){
    #!/bin/bash
	systemctl get-default
	systemctl set-default multi-user.target
	#systemctl set-default graphical.target
}

sshsemsenha() {
    #!/bin/sh
    USUARIO=${USER}
    #SERV="10.0.0.72"
    SERV=$1
    echo $1

    ssh-keygen -t rsa
    #scp /home/$USER/.ssh/id_rsa.pub $USER@$SERV:/tmp
    #scp ~/.ssh/id_rsa.pub $USUARIOR@$SERV:/tmp
    #ssh $USUARIO@$SERV
    #cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
    ssh-copy-id -f -i ~/.ssh/id_rsa.pub $SERV
}


delr()
{
	#!/bin/sh
	#find -name $1 | xargs rm -v
	#!/bin/bash
	for i in `find -name $1`
	do
        ls -f $i
	done
}

alo()
{
	#!/bin/bash
	echo "First arg: $1"
	echo "Second arg: $2"
	echo "List of all arg: $@"
}

ramdisk() {
	#!/bin/bash
	sudo mkdir /mnt/ramdisk
	sudo mount -t tmpfs -o size=4096M tmpfs /mnt/ramdisk
	#fstab
	#tmpfs       /mnt/ramdisk tmpfs   nodev,nosuid,noexec,nodiratime,size=512M   0 0
}

qemuimg() {
	#!/bin/bash
	#qemu-system-x86_64 -cdrom tails-amd64-3.1.iso
	qemu-system-x86_64 -no-fd-bootchk -nographic $1
}

qemu() {
	#!/bin/bash
	#qemu-system-x86_64 -cdrom tails-amd64-3.1.iso
	qemu-system-x86_64 -no-fd-bootchk -nographic -cdrom $1
}

qemux() {
	#!/bin/bash
	#qemu-system-x86_64 -cdrom tails-amd64-3.1.iso
	qemu-system-x86_64 -curses -no-fd-bootchk -nographic -cdrom $1
}

qemukvm()
{
#qemu-system-x86_64 -enable-kvm -m 2048 -name 'CHILI OS' -boot d -hda ubuntu17.qcow2 -cdrom $1
qemu-system-x86_64 -enable-kvm -m 2048 -name 'CHILI OS' -boot -cdrom $1
}

dos() {
	!/bin/bash
	#qemu-img create -f qcow2 /home/vcatafesta/Downloads/qemu/dos7.qcow2 1G
	#qemu-img info /home/vcatafesta/Downloads/qemu/dos7.qcow2
	#qemu-system-x86_64 -hda dos7.qcow2 -cdrom dos71cd.iso -boot d
	#qemu-system-x86_64 -enable-kvm -m 2048 -name 'UBUNTU 17.10' -boot d -hda ubuntu17.qcow2 -cdrom ubuntu-17.10-desktop-amd64.iso
	#qemu-system-x86_64 -hda /home/vcatafesta/Downloads/qemu/dos7.qcow2
	#qemu-system-x86_64 -enable-kvm -m 1 -name 'Microsoft MSDO 7.1' -hda /home/vcatafesta/Downloads/qemu/dos7.qcow2
	qemu-system-x86_64 -m 128 -name 'Microsoft MSDO 7.1' -hda /home/vcatafesta/Downloads/qemu/dos7.qcow2
}

criartap() {
	#sudo apt-get install uml-utilities

	#criar ponte
	sudo modprobe tun
	sudo tunctl -t tap0
	sudo ifconfig tap0 0.0.0.0 promisc up
	sudo ifconfig enp3s0 0.0.0.0 promisc up
	sudo brctl addbr br0
	sudo brctl addif br0 tap0
	#sudo brctl addif br0 enp3s0
	sudo brctl show
	sudo ifconfig br0 up
	sudo ifconfig br0 10.7.7.66/24
}

vlanubnt() {
	#telnet 10.0.0.51
	#ssh 10.0.0.51
	vconfig add br0 5
	vconfig add br0 10
	ifconfig br0.5 x.x.x.x netmask x.x.x.x up
	ifconfig br0.10 x.x.x.x netmask x.x.x.x up
}

repair(){
#    !/bin/bash
	echo "sudo apt install -f && sudo dpkg --configure -a"
	sudo apt install -f && sudo dpkg --configure -a
}

ultrahd() {
	sudo xrandr --newmode "2560x1080_60.00"  230.00  2560 2720 2992 3424  1080 1083 1093 1120 -hsync +vsync
	sudo xrandr --addmode HDMI-0 2560x1080_60.00
}

function info(){
    dialog                              \
        --beep                      \
        --title     "$cmsg002"      \
        --backtitle "$ccabec"       \
        --msgbox    "$*"            \
        00  00
}

function tms()
{
    journalctl -f
}

sr() {
	sudo systemctl restart $1
	sudo systemctl status $1
}

function lsvideo(){
    echo -e "1. lspci | grep VGA"
    sudo lspci | grep VGA
    echo
    echo -e "2. grep -i chipset /var/log/Xorg.0.log"
    sudo grep -i chipset /var/log/Xorg.0.log
    echo
    echo -e "3. lshw -C video"
    sudo lshw -C video
}

st() {
	sudo systemctl stop $1
	sudo systemctl status $1
}

ddel3() {
	find -iname $1 | xargs rm --verbose
}

stsmb() {
	sudo systemctl restart smbd
	sudo systemctl restart nmbd
	sudo systemctl status smbd
}

bindmnt(){
	for i in /dev /dev/pts /proc /sys /run
    do
        sudo mkdir -pv $1/$i
        sudo mount -v -B $i $1/$i
    done
}

chilichroot(){
    CHROOTDIR="/mnt/lfs"
    log_wait_msg "Criando CHROOT on $CHROOTDIR"
    mkdir -pv $CHROOTDIR
	for i in /dev /dev/pts /proc /sys /run; do
        log_wait_msg "Binding $CHROOTDIR$i"
        sudo mount -B ${i} ${CHROOTDIR}${i}
    done
    log_wait_msg "Iniciando CHROOT at $CHROOTDIR"
	sudo chroot ${CHROOTDIR}
    log_wait_msg "Unbinding $CHROOTDIR"
    sudo umount /mnt/lfs/run
    sudo umount /mnt/lfs/sys
    sudo umount /mnt/lfs/proc
    sudo umount /mnt/lfs/dev/pts
    sudo umount /mnt/lfs/dev
	#sudo grub-install /dev/sdb
	#sudo update-grub /dev/sdb
}

mntchroot(){
	sudo mount $1 /mnt
	for i in /dev /dev/pts /proc /sys /run; do
        sudo mount -B $i /mnt$i
    done
	sudo chroot /mnt
	#sudo grub-install /dev/sdb
	#sudo update-grub /dev/sdb
}

conf() {
	./configure                 \
    --prefix=/usr               \
	--sysconfdir=/etc           \
	--localstatedir=/var        \
	--mandir=/usr/man
    make
}

conflib() {
    ./configure --prefix=/usr --disable-static &&
    make
}

function bcp()
{
	export l=$PWD
	export pkgdir=$PWD
    pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}')
#	pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $3}')

    log_wait_msg "Criando pacote... $pkg"
    log_wait_msg "Gziping arquivos..."
    for i in $PWD/usr/share/man/man{1..9}/*
    do
        #find -iname *.gz -exec gunzip -f {} \;
#        gzip -9 $i &>/dev/null
        gzip -9 $i -f
    done
    log_wait_msg "Chamando o bananapkg..."
    echo
	banana -c $pkg-${DESC_BUILD}.chi
	evaluate_retval
}

lsd(){
    echo -e ${blue}
    ls -l | awk '/^d/ {print $9}'
    #ls -la | grep "^d"
    #ls -d */
    echo -n ${reset}
}

lsa(){
    echo -n ${orange}
    ls -l|awk '/^-/ {print $9}'
#   ls -la | grep -v "^d"
}

net()
{
	log_info_msg "Iniciando rede"
	/etc/init.d/networkmanager stop
	ip addr add 10.0.0.67/21 dev enp0s3
	ip route add default via 10.0.0.254 dev enp0s3
	ip route list
	evaluate_retval
}

as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}
export -f as_root

cpd(){
	TITLE='Copiando...'
	MSG='Copiando o diretório $ORIGEM para $DESTINO'
	INTERVALO=1       # intervalo de atualização da barra (segundos)
	PORCENTO=0        # porcentagem inicial da barra
	#................................................................
	ORIGEM="${1%/}"
	DESTINO="${2%/}"
	#................................................................
	die()    { echo "Erro: $*" ; }
	sizeof() { du -s "$1" | cut -f1; }
	running(){ ps $1 | grep $1 >/dev/null; }

	#................................................................

	# tem somente dois parâmetros?
	[ "$2" ] || die "Uso: $0 dir-origem dir-destino"

	# a origem e o destino devem ser diretórios
	#[ -d "$ORIGEM"  ] || die "A origem '$ORIGEM' deve ser um diretório"
	#[ -d "$DESTINO" ] || die "O destino '$DESTINO' deve ser um diretório"

	# mesmo dir?
	[ "$ORIGEM" = "$DESTINO" ] &&
		die "A origem e o destino são o mesmo diretório"

	# o diretório de destino está vazio?
	DIR_DESTINO="$DESTINO/${ORIGEM##*/}"
	[ -d "$DIR_DESTINO" ] && [ $(sizeof $DIR_DESTINO) -gt 4 ] &&
		die "O dir de destino '$DIR_DESTINO' deveria estar vazio"

	#................................................................

	# expansão das variáveis da mensagem
	MSG=$(eval echo $MSG)

	# total a copiar (em bytes)
	TOTAL=$(sizeof $ORIGEM)

	# início da cópia, em segundo plano
	cp $ORIGEM $DESTINO &
	CPPID=$!

	# caso o usuário cancele, interrompe a cópia
	trap "kill $CPPID" 2 15

	#................................................................

	# loop de checagem de status da cópia
	(
		# enquanto o processo de cópia estiver rodando
		while running $CPPID; do
			# quanto já foi copiado?
			COPIADO=$(sizeof $DIR_DESTINO)
			# qual a porcentagem do total?
			PORCENTAGEM=$((COPIADO*100/TOTAL))
			# envia a porcentagem para o dialog
			echo $PORCENTAGEM
			# aguarda até a próxima checagem
			sleep $INTERVALO
		done
		# cópia finalizada, mostra a porcentagem final
		echo 100
	) | dialog --title "$TITLE" --gauge "$MSG" 8 40 0
	#................................................................
	#echo OK - Diretório copiado
}

distro(){
	tar -cvpJf 				\
	balcao.tar.xz 	        \
	--exclude=/mnt          \
	--exclude=/usr/src	 	\
	--exclude=/proc		 	\
	--exclude=/dev		 	\
	--exclude=/sys		 	\
	--exclude=*.bak 		\
	--exclude=*.xz			\
	/
}

remountpts(){
    log_info_msg "Desmontando: sudo umount -rl /dev/pts"
    sudo umount -rl /dev/pts
    evaluate_retval
    log_info_msg "Remontando: sudo mount devpts /dev/pts -t devpts"
    sudo mount devpts /dev/pts -t devpts
    evaluate_retval
}

function backup()
{
    sl
    mkdir -p /home/vcatafesta/github
    mkdir -p /home/vcatafesta/sci/src.linux
    rsync --progress -Cravzp --rsh='ssh -l vcatafesta' vcatafesta@10.0.0.66:/home/vcatafesta/sci/src.linux/ /home/vcatafesta/sci/src.linux/
    rsync --progress -Cravzp --rsh='ssh -l vcatafesta' vcatafesta@10.0.0.66:/home/vcatafesta/sci/include/ /home/vcatafesta/sci/include/
    rsync --progress -Cravzp --rsh='ssh -l vcatafesta' vcatafesta@10.0.0.66:/home/vcatafesta/github/LetoDBf/ /home/vcatafesta/github/LetoDBf/
}

chrootlfs(){
	export LFS=/mnt/lfs
	mkdir -pv $LFS
	mount -v -t ext4 /dev/sdb4 $LFS
	mount -v --bind /dev $LFS/dev
	mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
	mount -vt proc proc $LFS/proc
	mount -vt sysfs sysfs $LFS/sys
	mount -vt tmpfs tmpfs $LFS/run
	if [ -h $LFS/dev/shm ]; then
	  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
	fi

	chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h
}

tolfs(){
	export LFS=/mnt/lfs
	mkdir -pv $LFS
	mount -v -t ext4 /dev/sdb4 $LFS
	swapon =v /dev/sdb3
	mkdir -v $LFS/sources
	chmod -v a+wt $LFS/sources
	mkdir -v $LFS/tools
	ln -sv $LFS/tools /
	groupadd lfs
	useradd -s /bin/bash -g lfs -m -k /dev/null lfs
	passwd lfs
	chown -v lfs $LFS/tools
	chown -v lfs $LFS/sources
	su - lfs
}

as_root()
{
  if   [ $EUID = 0 ];        then $*
  elif [ -x /usr/bin/sudo ]; then sudo $*
  else                            su -c \\"$*\\"
  fi
}
export -f as_root
#Python 3.7.3
export PYTHONDOCS=/usr/share/doc/python-3/html

which2(){
#	cat > /usr/bin/which << "EOF"
#	#!/bin/bash
	type -pa "$@" | head -n 1
#	type -pa "$@" | head -n 1 ; exit ${PIPESTATUS[0]}
#	EOF
#	chmod -v 755 /usr/bin/which
#	chown -v root:root /usr/bin/which
}

function inst()
{
    local false=1
    local true=0
    local lgenerate=$false
    BUILDDIR=/lfs/build

    log_wait_msg "Criando diretorios de trabalho..."
	mkdir -p $BUILDDIR
    pkgname=$1
    _pkgname=$1
    pkgver=$2
    pkgrel=$DESC_BUILD
    PKG=$1-$2
    test -d $BUILDDIR/$PKG || mkdir -p $BUILDDIR/$PKG

    if [ "${3}" = "G" ]; then
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
            gzip -9 $i -f
        done
    fi

    log_wait_msg "Criando pacote..."
    cd $BUILDDIR/$PKG/

    if [ "$3" = "" ]; then
        banana -g "$PKG-${DESC_BUILD}"
        cd $BUILDDIR/$PKG/info/
        #nano desc
    fi
    if [ $lgenerate = $true ]; then
        banana -g "$PKG-${DESC_BUILD}"
    fi

    cd $BUILDDIR/$PKG/
	export l=$BUILDDIR/$PKG
	export pkgdir=$BUILDDIR/$PKG
    alias l="cd $l"
    if [ $lgenerate = $false ]; then
        banana -c $PKG-${DESC_BUILD}.chi
    fi
}

function build()
{
	export r=$PWD
	export srcdir=${PWD#/} srcdir=/${srcdir%%/*}
	alias r="cd $r"
#	pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $4}'|sed 's/-/ /g')
#	pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/ /g')
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
	banana -i "$pkg-${DESC_BUILD}.chi"
   popd
	evaluate_retval
}

function gen()
{
	export r=$PWD
	export srcdir=${PWD#/} srcdir=/${srcdir%%/*}
	alias r="cd $r"
#	pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/ /g')
	pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}'|sed 's/-/_/g'| sed 's/\(.*\)_/\1 /')
	arr=($pkg)
	[[ ${#arr[*]} -gt 2 ]] && pkg="${arr[0]}_${arr[1]} ${arr[2]}"
	log_success_msg2 "Criando pacote... $pkg"
	inst $pkg "G"
	evaluate_retval
}

log_wait_msg()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${WAIT_PREFIX}${SET_COL}${WAIT_SUFFIX}"
    echo " OK" >> ${BOOTLOG}
    return 0
}

function makepy()
{
    local filepy="ex.py"
    log_wait_msg "Aguarde, criando arquivo $1..."
    if [ "${1}" != "" ]; then
        filepy="${1}"
    fi

    cat > ${filepy} << "EOF"
#!/usr/bin/python3
# -*- coding: utf-8 -*-

EOF
    chmod +x ${filepy}
    log_success_msg2 "Feito!"
}

function MK()
{
    log_wait_msg "Aguarde, criando arquivo rmake..."
    cat > rmake << "EOF"
#!/bin/bash
    . /etc/bashrc
    ./configure --prefix=/usr     \
                --sysconfdir=/etc
    make
    #make check
    #make install
EOF
    chmod +x rmake
    log_success_msg2 "Feito!"
}

function MKLIB()
{
    log_wait_msg "Aguarde, criando arquivo rmake..."
    cat > rmake << "EOF"
#!/bin/bash
    source /etc/bashrc
    ./configure --prefix=/usr --disable-static &&
    make
    #make check
    #make install
EOF
    chmod +x rmake
    log_success_msg2 "Feito!"
}

function MKCMAKE()
{
    log_wait_msg "Aguarde, criando arquivo rmake..."
    cat > rmake << "EOF"
#!/bin/bash
    source /etc/bashrc
    mkdir build &&
    cd    build &&

    cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
          -DCMAKE_PREFIX_PATH=$QT5DIR        \
          -DCMAKE_BUILD_TYPE=Release         \
          -DBUILD_TESTING=OFF                \
          -Wno-dev .. &&
    make
    #make check
    #make install
EOF
    chmod +x rmake
    log_success_msg2 "Feito!"
}

function MKX()
{
    log_wait_msg "Aguarde, criando arquivo rmake..."
    cat > rmake << "EOF"
#!/bin/bash
    ./configure $XORG_CONFIG &&
    make
    #make check
    #make install
EOF
    chmod +x rmake
    log_success_msg2 "Feito!"
}

#export LFS=/mnt/lfs
#export LFS=/mnt/build_dir
#export FORCE_UNSAFE_CONFIGURE=1
#export HOME="/root"
#export OLDPWD
#export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"
#export PWD="/"
#export SHLVL="1"
#export TERM="xterm-256color"
alias l=$PWD
alias pkgdir=$PWD
alias srcdir=${PWD#/} srcdir=/${srcdir%%/*}
alias r=$OLDPWD
alias c="cd /sources"

function bindlfs()
{
    export LFS=/mnt/build_dir
    mount -v --bind /dev $LFS/dev
    mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
    mount -vt proc proc $LFS/proc
    mount -vt sysfs sysfs $LFS/sys
    mount -vt tmpfs tmpfs $LFS/run

    if [ -h $LFS/dev/shm ]; then
        mkdir -pv $LFS/$(readlink $LFS/dev/shm)
    fi
}

function chrootlfs()
{
    export LFS=/mnt/build_dir
    chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
        TERM="$TERM"                \
        PS1='(lfs chroot) \u:\w\$ ' \
        PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
        /tools/bin/bash --login +h
}

function limpa()
{
	#!/bin/bash
	#source /lib/lsb/init-functions
	cdir=$(ls -l|awk '/^d/ {print $9}')
	blue="\e[1;34m"

	echo -e ${blue}
	log_success_msg2 "Iniciando limpeza..."

	for i in $cdir
	do
		log_info_msg "${blue}Removendo diretorio temporario... $i/"
		sudo rm -rfd $i/
		evaluate_retval
	done
	log_success_msg2 "Finish."
}
export -f limpa

repairdirvar()
{
	log_wait_msg "Iniciando reparo do /var/run..."
#	exec &> /dev/null
	sudo mv -f /var/run/* /run/  > /dev/null 2>&1
	sudo rm -rf /var/run         > /dev/null 2>&1
	sudo ln -s /run /var/run     > /dev/null 2>&1
	exec >/dev/tty
	log_success_msg2 "Feito..."
}


function ex()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.tar.xz)    tar Jxvf $1     ;;
            *.lz)        lzip -d -v $1   ;;
            *.chi)       tar Jxvf $1     ;;
            *.chi.zst)   tar -xvf $1     ;;
            *.tar.zst)   tar -xvf $1     ;;
            *.mz)        tar Jxvf $1     ;;
            *.cxz)       tar Jxvf $1     ;;
            *.chi)       tar Jxvf $1     ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function dwup()
{
	if [ "$(vercmp $2 4.0.4)" -lt 0 ]; then
		echo
	fi
}

function toupper()
{
    declare -u TOUPPER=${@}
    echo ${TOUPPER}
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


function converteOldChiPkgToNewZst()
{
	cfiles=$(ls -1 *.chi)
	for pkg in $cfiles
	do
		echo
		newpkg=$(echo $pkg|sed 's/_/-/g')
		log_info_msg "Renomeando $pkg para $newpkg"
		mv $pkg $newpkg &>/dev/null
		evaluate_retval

		cnewpkgsemext=$(echo $newpkg|sed 's/.chi//g')
		log_info_msg "Criando diretorio $cnewpkgsemext"
		mkdir $cnewpkgsemext &>/dev/null
		evaluate_retval

		log_info_msg "Extraindo arquivos $newpkg"
		tar --extract --file $newpkg -C $cnewpkgsemext
		evaluate_retval

		log_info_msg "Entrando diretorio $cnewpkgsemext"
		pushd $cnewpkgsemext/ &>/dev/null
		evaluate_retval

		fetch -g
		echo -e
		fetch create
		echo -e
		popd &>/dev/null
	done
}


function removeoldpkgarch()
{
		local nfiles=0
		local cOldDir=$PWD

		cd /var/cache/pacman/pkg
		shopt -s nullglob       # enable suppress error message of a command
		if [ $# -lt 1 ]; then
			AllFilesPackages=$(ls -1 *.{zst,xz})
		else
			AllFilesPackages=$(ls -1 $1*.{zst,xz})
		fi
		shopt -u nullglob       # disable suppress error message of a command

		log_wait_msg "wait, working on it..."
		for pkgInAll in $AllFilesPackages
		do
			pkgtar=$(echo $pkgInAll |sed 's/\// /g'|awk '{print $NF}'|sed 's/-x86_64.chi.\|zst\|xz//g'|sed 's/-any.chi.\|zst\|xz//g'|sed 's/1://g'|sed 's/2://g')
			FilteredPackages=$(echo $pkgtar | sed 's/\(.*\)-\(.*-\)/\1*\2/' |cut -d* -f1)
			FilteredPackages=$FilteredPackages"-"
			AllFilteredPackages=$(ls -1 $FilteredPackages*.{zst,xz} 2> /dev/null)
#			AllFilteredPackages=$(ls -1 $FilteredPackages*.zst 2> /dev/null)
#			AllFilteredPackages="$AllFilteredPackages $(ls -1 $FilteredPackages*.xz 2> /dev/null)"
			nfiles=0

			for y in ${AllFilteredPackages[*]}
			do
				((nfiles++))
			done

#			echo -e "${white}Verifying package ${purple}($nfiles) ${green}$pkgInAll"
			log_wait_msg "${white}Verifying package ${purple}($nfiles) ${green}$pkgInAll"
			if [[ $nfiles > 1 ]]; then
				for pkg in $AllFilteredPackages
				do
					if [[ "$(vercmp $pkgInAll $pkg)" -lt 0 ]]; then
						maxcol; replicate "=" $?
						log_info_msg "Removing ${red}OLD ${reset}package ${yellow}$pkgInAll"
						rm $pkgInAll*  >/dev/null 2>&1
						evaluate_retval
						maxcol; replicate "=" $?
					elif [[ "$(vercmp $pkgInAll $pkg)" -gt 0 ]]; then
						continue
					elif [[ "$(vercmp $pkgInAll $pkg)" -eq 0 ]]; then
						continue
					fi
				done
			fi
		done
		cd $cOldDir
}
export -f removeoldpkgarch


function removeoldpkgchili()
{
	local cHomeDir=$PWD
	local pkgdir="/github/ChiliOS/packages/"
	local cdir=

	cd "$pkgdir"
	for cdir in {a..z}
	do
		local nfiles=0
		local cOldDir=$PWD
		local AllFilesPackages=
		local pkg=
		local pkgInAll=
		local FilteredPackages=
		local AllFilteredPackages=

		shopt -s nullglob       # enable suppress error message of a command
		if [ $# -lt 1 ]; then
			log_wait_msg "${white}Verifying packages in ${green}$pkgdir$cdir/"
			pushd $cdir >/dev/null 2>&1
			AllFilesPackages=$(ls -1 *.{zst,xz} 2> /dev/null)
		else
			cdir=${1:0:1}
			log_wait_msg "${white}Verifying packages in ${green}$pkgdir$cdir/"
			pushd $cdir >/dev/null 2>&1
			AllFilesPackages=$(ls -1 $1*.{zst,xz}  2> /dev/null | grep $1)
		fi
		shopt -u nullglob       # disable suppress error message of a command

		log_wait_msg "Wait, working on it..."
		for pkgInAll in $AllFilesPackages
		do
			pkgtar=$(echo $pkgInAll |sed 's/\// /g'|awk '{print $NF}'|sed 's/-x86_64.chi.\|zst\|xz//g'|sed 's/-any.chi.\|zst\|xz//g'|sed 's/.chi.\|zst\|xz//g'|sed 's/1://g'|sed 's/2://g')
			FilteredPackages=$(echo $pkgtar | sed 's/\(.*\)-\(.*-\)/\1*\2/' |cut -d* -f1)
			FilteredPackages=$FilteredPackages"-"
			AllFilteredPackages=$(ls -1 $FilteredPackages*.{zst,xz} 2> /dev/null)
			nfiles=0
			y=
			pkg=
			cPacoteSemExt=$(echo ${pkgtar%%.*})        # https://elmord.org/blog/?entry=20121227-manipulando-strings-bash
         cPacoteSemExt=$(echo ${cPacoteSemExt%-*})  # https://elmord.org/blog/?entry=20121227-manipulando-strings-bash

			for y in ${AllFilteredPackages[*]}
			do
				((nfiles++))
			done

			log_wait_msg "${white}Checking OLD packages of ${purple}(#$nfiles found) ${green}$cPacoteSemExt"
			if [[ $nfiles -gt 1 ]]; then
				for pkg in $AllFilteredPackages
				do
					if [[ "$(vercmp $pkgInAll $pkg)" -lt 0 ]]; then
#						maxcol; replicate "=" $?; echo
						log_info_msg "Removing ${red}OLD ${reset}package ${yellow}$pkgInAll"
						shopt -s nullglob       # enable suppress error message of a command
#						rm $pkgInAll*  >/dev/null 2>&1
						rm $pkgInAll*
						evaluate_retval
#						maxcol; replicate "=" $?; echo
						shopt -u nullglob       # disable suppress error message of a command
					elif [[ "$(vercmp $pkgInAll $pkg)" -gt 0 ]]; then
						continue
					elif [[ "$(vercmp $pkgInAll $pkg)" -eq 0 ]]; then
						continue
					fi
				done
			else
				log_info_msg "Package ${yellow}$pkgInAll ${reset}is already the newest. Nothing to do. ${reset}"
				echo
			fi
		done
		popd >/dev/null 2>&1
		if [ $# -eq 1 ]; then
			break
		fi
	done
	cd $cHomeDir
}
export -f removeoldpkgchili


function limpa_tar_zst()
{
	for i in {a..z}
	do
		cd $i
		rm *.pkg.tar.zst
		cd ../
	done
}


function copiapkg()
{
	for letra in {a..z}
	do
		log_info_msg "Copiando arquivos iniciados com a letra: $letra para diretorio /github/ChiliOS/packages/$letra/"
		sudo cp $letra* /github/ChiliOS/packages/$letra/ &>/dev/null
		evaluate_retval
	done
}
export -f copiapkg

function dw()
{
	sudo pacman -Sw $* --noconfirm --quiet
	if [ $? == 0 ]; then
		sudo fetch -a $*
	fi
}
export -f dw

function mput()
{
	for x in {a..z}
	do
		log_info_msg "Trabalhando em ${x}"
		echo
    	git add ${x}* 2>&1>/dev/null
    	git commit -m "upgrade" 2>&1>/dev/null
		git push 2>&1>/dev/null
		evaluate_retval
	done
}

function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}


function cat2()
{
    exec 3<> $@
    while read line <&3
    do {
      echo "$line"
      (( Lines++ ));                   #  Incremented values of this variable
                                       #+ accessible outside loop.
                                       #  No subshell, no problem.
    }
    done
    exec 3>&-
    echo
    echo "Number of lines read = $Lines"     # 8
}


#Python 3.7.3
export PYTHONDOCS=/usr/share/doc/python-2.7.16/html
alias mkd="make install DESTDIR=$l"
#CHOST="i686-pc-linux-gnu"
#CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
#CFLAGS="-march=native -02 -pipe"
#CFLAGS="-march=athlon64 -O2 -pipe"
#CFLAGS="-march=skylake -O2 -pipe"
#CXXFLAGS="${CFLAGS}"

CHOST="x86_64-pc-linux-gnu"
#CFLAGS="-march=native -02 -pipe"
#CFLAGS="-march=pentium3 -02 -pipe"
#CFLAGS="-march=ahtlon64 -03 -pipe"
#CFLAGS="-march=generic -02 -pipe"
#Core i3/i5/i7 and Xeon E3/E5/E7 *V2
#CFLAGS="-march=ivybridge -O2 -pipe"
#Pentium
#CFLAGS="-O2 -march=pentium-m -pipe"
#CFLAGS="-march=ivybridge -mno-avx -mno-aes -mno-rdrnd -O2 -pipe"
#CFLAGS="-march=ivybridge -mno-avx -mno-aes -mno-rdrnd -O3 -pipe -fomit-frame-pointer"
#CFLAGS="-mtune=intel -O2 -pipe -fomit-frame-pointer"
#CFLAGS="-mtune=generic -O3 -pipe -fomit-frame-pointer"
#CFLAGS="-march=x86-64 -02 -pipe"
#CXXFLAGS="${CFLAGS}"
W1="-Wunused-local-typedefs"
W2="-Wunused-but-set-variable"
W3="-Wunused-function"
W4="-Wno-declaration-after-statement"
W5="-Wno-error=deprecated-declarations"
W6="-Wno-deprecated-declarations"
W7="-Wno-suggest-attribute=format"
W8="-Wno-unused-variable"
W9="-Wno-unused-but-set-variable"
W10="-Wno-unused-function"
W11="-Wno-parentheses"
W0="-mtune=generic -fPIC -Os -pipe -fomit-frame-pointer"
CFLAGS="${W0} ${W1} ${W2} ${W3} ${W4} ${W5} ${W6} ${W7} ${W8} ${W9} ${W10} ${W11}"
CXXFLAGS="${W0} ${W1} ${W2} ${W3} ${W5} ${W6} ${W7} ${W8} ${W9}"
export CHOST CFLAGS CXXFLAGS
#gcc -c -Q -march=native --help=target
#gcc -### -march=native /usr/include/stdlib.h
#gcc -v -E -x c /dev/null -o /dev/null -march=native 2>&1 | grep /cc1
#unset CXXFLAGS
export PATH="$PATH:/src/depot_tools"
#PS1="\e[32;1m\u \e[33;1m→ \e[36;1m\h \e[37;0m\w\n\e[35;1m⚡\e[m"


#!/bin/bash

#. /etc/init.d/functions

# Use step(), try(), and next() to perform a series of commands and print
# [  OK  ] or [FAILED] at the end. The step as a whole fails if any individual
# command fails.
#
# Example:
#     step "Remounting / and /boot as read-write:"
#     try mount -o remount,rw /
#     try mount -o remount,rw /boot
#     next

step() {
    echo -n "$@"
    STEP_OK=0
    [[ -w /tmp ]] && echo $STEP_OK > /tmp/step.$$
}

try() {
    # Check for `-b' argument to run command in the background.
    local BG=

    [[ $1 == -b ]] && { BG=1; shift; }
    [[ $1 == -- ]] && {       shift; }

    # Run the command.
    if [[ -z $BG ]]; then
        "$@"
    else
        "$@" &
    fi

    # Check if command failed and update $STEP_OK if so.
    local EXIT_CODE=$?

    if [[ $EXIT_CODE -ne 0 ]]; then
        STEP_OK=$EXIT_CODE
        [[ -w /tmp ]] && echo $STEP_OK > /tmp/step.$$

        if [[ -n $LOG_STEPS ]]; then
            local FILE=$(readlink -m "${BASH_SOURCE[1]}")
            local LINE=${BASH_LINENO[0]}

            echo "$FILE: line $LINE: Command \`$*' failed with exit code $EXIT_CODE." >> "$LOG_STEPS"
        fi
    fi

    return $EXIT_CODE
}

next() {
    [[ -f /tmp/step.$$ ]] && { STEP_OK=$(< /tmp/step.$$); rm -f /tmp/step.$$; }
    [[ $STEP_OK -eq 0 ]]  && echo_success || echo_failure
    echo

    return $STEP_OK
}

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try2() { "$@" || die "cannot $*"; }
asuser() { sudo su - "$1" -c "${*:2}"; }

set -o pipefail
shopt -s expand_aliases
declare -ig __oo__insideTryCatch=0

# if try-catch is nested, then set +e before so the parent handler doesn't catch us
alias try3="[[ \$__oo__insideTryCatch -gt 0 ]] && set +e;
           __oo__insideTryCatch+=1; ( set -e;
           trap \"Exception.Capture \${LINENO}; \" ERR;"
alias catch=" ); Exception.Extract \$? || "

Exception.Capture() {
    local script="${BASH_SOURCE[1]#./}"

    if [[ ! -f /tmp/stored_exception_source ]]; then
        echo "$script" > /tmp/stored_exception_source
    fi
    if [[ ! -f /tmp/stored_exception_line ]]; then
        echo "$1" > /tmp/stored_exception_line
    fi
    return 0
}

Exception.Extract() {
    if [[ $__oo__insideTryCatch -gt 1 ]]
    then
        set -e
    fi

    __oo__insideTryCatch+=-1

    __EXCEPTION_CATCH__=( $(Exception.GetLastException) )

    local retVal=$1
    if [[ $retVal -gt 0 ]]
    then
        # BACKWARDS COMPATIBILE WAY:
        # export __EXCEPTION_SOURCE__="${__EXCEPTION_CATCH__[(${#__EXCEPTION_CATCH__[@]}-1)]}"
        # export __EXCEPTION_LINE__="${__EXCEPTION_CATCH__[(${#__EXCEPTION_CATCH__[@]}-2)]}"
        export __EXCEPTION_SOURCE__="${__EXCEPTION_CATCH__[-1]}"
        export __EXCEPTION_LINE__="${__EXCEPTION_CATCH__[-2]}"
        export __EXCEPTION__="${__EXCEPTION_CATCH__[@]:0:(${#__EXCEPTION_CATCH__[@]} - 2)}"
        return 1 # so that we may continue with a "catch"
    fi
}

Exception.GetLastException() {
    if [[ -f /tmp/stored_exception ]] && [[ -f /tmp/stored_exception_line ]] && [[ -f /tmp/stored_exception_source ]]
    then
        cat /tmp/stored_exception
        cat /tmp/stored_exception_line
        cat /tmp/stored_exception_source
    else
        echo -e " \n${BASH_LINENO[1]}\n${BASH_SOURCE[2]#./}"
    fi

    rm -f /tmp/stored_exception /tmp/stored_exception_line /tmp/stored_exception_source
    return 0
}

function check_exit {
    cmd_output=$($@)
    local status=$?
    echo $status
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
    fi
    return $status
}

function run_command() {
    exit 1
}

BOOTUP=color
RES_COL=60
MOVE_TO_COL="echo -en \\033[${RES_COL}G"
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"

echo_success() {
    [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
    echo -n "["
    [ "$BOOTUP" = "color" ] && $SETCOLOR_SUCCESS
    echo -n $"  OK  "
    [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
    echo -n "]"
    echo -ne "\r"
    return 0
}

echo_failure() {
    [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
    echo -n "["
    [ "$BOOTUP" = "color" ] && $SETCOLOR_FAILURE
    echo -n $"FAILED"
    [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
    echo -n "]"
    echo -ne "\r"
    return 1
}

echo_passed() {
    [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
    echo -n "["
    [ "$BOOTUP" = "color" ] && $SETCOLOR_WARNING
    echo -n $"PASSED"
    [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
    echo -n "]"
    echo -ne "\r"
    return 1
}

echo_warning() {
    [ "$BOOTUP" = "color" ] && $MOVE_TO_COL
    echo -n "["
    [ "$BOOTUP" = "color" ] && $SETCOLOR_WARNING
    echo -n $"WARNING"
    [ "$BOOTUP" = "color" ] && $SETCOLOR_NORMAL
    echo -n "]"
    echo -ne "\r"
    return 1
}

assert_exit_status() {

  lambda() {
    local val_fd=$(echo $@ | tr -d ' ' | cut -d':' -f2)
    local arg=$1
    shift
    shift
    local cmd=$(echo $@ | xargs -E ':')
    local val=$(cat $val_fd)
    eval $arg=$val
    eval $cmd
  }

  local lambda=$1
  shift

  eval $@
  local ret=$?
  $lambda : <(echo $ret)

}

