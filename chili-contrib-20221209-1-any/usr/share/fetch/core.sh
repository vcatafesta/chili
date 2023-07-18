#!/usr/bin/env bash

#  core.sh - lib for chili utilities like fetch, chili-install, chili-clonedisk
#  Chili GNU/Linux - https://github.com/vcatafesta/ChiliOS
#  Chili GNU/Linux - https://chililinux.com
#  Chili GNU/Linux - https://chilios.com.br
#  MazonOS GNU/Linux - http://mazonos.com
#
#  Created: 2019/04/05
#  Altered: 2022/05/03
#
#  Copyright (c) 2019-2022, Vilmar Catafesta <vcatafesta@gmail.com>
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

#  fetch uses quite a few external programs during its execution. You
#  need to have at least the following installed for makepkg to function:
#     awk, bsdtar (libarchive), bzip2, coreutils, fakeroot, file, find (findutils),
#     gettext, gpg, grep, gzip, sed, tput (ncurses), xz
#  contains portion of software https://bananapkg.github.io/
#########################################################################
IFS=$' \t\n'
SAVEIFS=$IFS
# echo "$IFS" | od -h

declare -i ERR_ERROR=1
declare -i ERR_OK=0
declare -i true=1
declare -i false=0
declare -i LINSTALLED=2
declare -i LREMOVED=3
#declare -l BAIXA=${MENSAGEM}
#declare -u ALTA=${MENSAGEM}
trancarstderr=2>&-

# choosedisk
: ${ARRAY_DSK_DEVICES=()}
: ${ARRAY_DSK_DISKS=()}
: ${ARRAY_DSK_SIZE=()}
: ${ARRAY_DSK_MODEL=()}
: ${ARRAY_DSK_TRAN=()}
: ${ARRAY_DSK_LABEL=()}
: ${ARRAY_DSK_SERIAL=()}

function asort()
{
	local new=($1)
	readarray -t sorted < <(sort < <(printf '%s\n' "${array[@]}"))
#	readarray -td '' sorted < <(sort -z < <(printf '%s\0' "${array[@]}"))
	echo "${sorted[@]}"
}

function sh_sed(){
	declare -c Nom=Vilmar
	echo $nom
	: ${Nom/vi/mar}
	echo $_
	: ${Nom/Vi/ev}
	echo $_
}

function sh_basename(){
	echo ${1##*/}
}

function sh_dirname(){
	echo ${1%/*}
}

function DrawBox1
{
    string="$*";
    tamanho=${#string}
    tput setaf 4; printf "\e(0\x6c\e(B"
    for i in $(seq $tamanho)
        do printf "\e(0\x71\e(B"
    done
    printf "\e(0\x6b\e(B\n"; tput sgr0;
    tput setaf 4; printf "\e(0\x78\e(B"
    tput setaf 1; tput bold; echo -n $string; tput sgr0
    tput setaf 4; printf "\e(0\x78\e(B\n"; tput sgr0;
    tput setaf 4; printf "\e(0\x6d\e(B"
    for i in $(seq $tamanho)
        do printf "\e(0\x71\e(B"
    done
    printf "\e(0\x6a\e(B\n"; tput sgr0;
}

function DrawBox
{
    string="$*";
    tamanho=${#string}
    tput setaf 4; printf "\e(0\x6c\e(B"
    printf -v linha "%${tamanho}s" ' '
    printf -v traco "\e(0\x71\e(B"
    echo -n ${linha// /$traco}
    printf "\e(0\x6b\e(B\n"; tput sgr0;
    tput setaf 4; printf "\e(0\x78\e(B"
    tput setaf 1; tput bold; echo -n $string; tput sgr0
    tput setaf 4; printf "\e(0\x78\e(B\n"; tput sgr0;
    tput setaf 4; printf "\e(0\x6d\e(B"
    printf -v linha "%${tamanho}s" ' '
    printf -v traco "\e(0\x71\e(B"
    echo -n ${linha// /$traco}
    printf "\e(0\x6a\e(B\n"; tput sgr0;
}

#comparar dois arquivos e ver as diferencas
# awk 'NR == FNR {file1[$1]++; next} !($0 in file1)' file1 file2
#file1
#m1
#m2
#m3

#file2
#m2
#m4
#m5

#awk 'NR == FNR {file1[$0]++; next} !($0 in file1)' file1 file2
#m4
#m5

#awk 'NR == FNR {file1[$0]++; next} ($0 in file1)' file1 file2
#m2

#hat's awk command to get 'm1 and m3' ??  as in file1 and not in file2? 
#m1
#m3

# array bidimension
#a=("00 01 02 03 04" "10 11 12 13 14" "20 21 22 23 24" "30 31 32 33 34")	#Init a 4x5 matrix
#aset 2 3 9999 																				#Set a[2][3] = 9999
#for r in "${a[@]}"; do																		# Show result
#  echo $r
#done
#00 01 02 03 04																				#Outputs:
#10 11 12 13 14
#20 21 22 9999 24
#30 31 32 33 34

aset()
{
	row=$1
	col=$2
	value=$3
	IFS=' ' read -r -a tmp <<< "${a[$row]}"
	tmp[$col]=$value
	a[$row]="${tmp[@]}"
}

fcreate()
# $1 name
# $2 qtde
{
   local ini=1
   local name="$1"
   local fim="$2" 	# opcional, max 32762

	if [[ -n "$name" ]] ; then
		if [[ -z "$fim" ]] ; then
			fim=1
		elif (( fim > 32762 )) ; then
			fim=32762
		fi
		eval eval \\\>"$name"\{"$ini".."$fim"\}
#	   eval eval "\>"$name"{"$ini".."$fim"}"
		return $?
	fi
	return 1
}

sizeof_du(){ du -bs $1 | cut -f1; }
sizeof_find(){ echo $(( $(find $1 -printf %s+)0 )); }
sizeof_sfs_sed(){ echo $(( $( unsquashfs -ll $1 | sed -r ' 1,3d; /s*-root\/dev/d; s/^([^ ]+ ){2}//; s/^ *([^ ]+) .*/\1+/; $s/\+//; ' ) )); }
sizeof_sfs_awk(){ unsquashfs -ll $1 | awk '{m+=$3} END {print m}'; }
DIAHORA(){ date +"%d%m%Y-%T"|sed 's/://g'; }
sh_filedatetimestat(){ stat -c %w "$1"; }
sh_filedatetime(){ date -r "$1" +"%d/%m/%Y %T"; }
sh_filedate(){ date -r "$1" +"%d/%m/%Y"; }
sh_filetime(){ date -r "$1" +"%T"; }
sh_datetime(){ date +"%d/%m/%Y %T"; }
sh_time(){ date +"%T"; }
sh_date(){ date +"%d/%m/%Y"; }
sh_filesize(){ stat -c %s "$1"; }
sh_linecount_grep(){ grep -c ^ < "$1";}
sh_linecount_wc(){ wc -l < "$1";}
sh_linecount(){ awk 'END {print NR}' "$1"; }
alltrim(){ echo "${1// /}"; } # remover todos espacos da string
len(){ echo "${#1}"; }

sh_ascii_lines()
{
   if [[ "$LANG" =~ 'UTF-8' ]]
   then
      export NCURSES_NO_UTF8_ACS=0
   else
      export NCURSES_NO_UTF8_ACS=1
   fi
}

sh_val()
{
   if [[ ${1} =~ ^([0-9]+)$ ]];then
      echo "N"
   elif [[ ${1} =~ ^([[:alpha:]]+)$ ]];then
      echo "C"
   else
      echo "U"
   fi
}

joinBy() {
  local IFS="$1"
  echo "${*:2}"
}

#term='melancia'
#fruits=(pera uva maçã laranja kiwi)
#elementInArray3 "$term" "${fruits[@]}" && result falso
# se extglob não estiver habilitado, basta executar:
# shopt -s extglob
elementInArray3() {
  local element="$1"
  local array=("${@:2}")
  [[ "$element" == @($(joinBy '|' "${array[@]//|/\\|}")) ]]
}

containsElement() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

sh_val()
{
   if [[ ${1} =~ ^([0-9]+)$ ]];then
      echo "N"
   elif [[ ${1} =~ ^([[:alpha:]]+)$ ]];then
      echo "C"
   else
      echo "U"
   fi
}

sh_wgeturl()
{
	URL_LIST="urls.txt"

	# carrega o conteúdo do arquivo num array
	readarray URLS < ${URL_LIST}

	# para cada URL, executa o curl, extrai o status da requisição, verifica se foi bem sucedido
	# e informa o resultado
	for URL in ${URLS[@]}
	do
	    RESPONSE="$(curl -s -I ${URL})"

	    STATUS=$(echo $RESPONSE | grep "HTTP" | cut -d " " -f 2)

	    if [[ ${STATUS} -eq "200" ]]
	    then
	        echo $URL [SUCESSO]
	    fi
	done
}

timetoseconds(){
	[[ $1 && $# -le 3 ]] || { echo "Número incorreto de argumentos!"; exit 1; }

	local argv=($*)
	local s=${!#}
	local exp=1
	local base=60

	while [[ $(( ${#argv[*]} -1 )) -ge 1 ]]; do
		unset argv[-1]
		s=$(( s + ${argv[${#argv[*]} -1]} * base**exp ))
		((exp++))
	done
	echo $s
}

sh_linecount()
{
   awk 'END {print NR}' $1
}

# echo $(lenarray ${Var[@]})
# echo $(lenarray ${Var[*]})
# echo $(lenarray "$Var")
lenarray()
{
	local new=($@:1)
	echo ${#new[*]}
}

# echo $(lenarraystr "${Var[@]}")
# echo $(lenarraystr "$Var")
lenarraystr()
{
	local new=($1)
	echo "${#new[@]}"
}

lenarraystr1()
{
   local new=$1
   local count=0

   read -ra ADDR <<< "$new"
   echo "${#ADDR[@]}"
}

calc()
{
	awk 'BEGIN { printf "%.'${2:-0}'f\n", '"$1"'}'
}

sh_splitpkgawk()
{
   file=${1}
   aPKGSPLIT=()

   pkg_folder_dir=${file%/*}                    #remove arquivo deixando somente o diretorio/repo
   pkg_fullname=${file##*/}                     #remove diretorio deixando somente nome do pacote

   arr=($(echo $pkg_fullname | awk 'match($0, /(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst/, array) {
         print array[0]
         print array[1]
         print array[2]
         print array[3]
         print array[4]
         print array[5]
         print array[6]
         }'))
   pkg_fullname="${arr[0]}"
   pkg_base="${arr[1]}"
   pkg_version_build="${arr[2]}"
   pkg_version="${arr[3]}"
   pkg_build="${arr[4]}"
   pkg_arch="${arr[5]}"
   pkg_base_version="${arr[0]}-${arr[4]}"
   aPKGSPLIT=($pkg_folder_dir $pkg_fullname $pkg_arch $pkg_base $pkg_base_version $pkg_version $pkg_build)
   return $?
}

sh_disk_info()
{
  unset ARRAY_DSK_{DISKS,DEVICES,SIZE,TRAN,MODEL,LABEL,SERIAL}
  local {NAME,PATH,SIZE,TRAN,MODEL,LABEL,SERIAL}_
  while read line
  do
		eval "${line//=/_=}"
#		[[ -z "$TRAN_" ]] && continue
      ARRAY_DSK_DISKS+=( $NAME_ )
    ARRAY_DSK_DEVICES+=( $PATH_ )
       ARRAY_DSK_SIZE+=( $SIZE_ )
#      ARRAY_DSK_TRAN+=( ${TRAN_:-loop} )
       ARRAY_DSK_TRAN+=( ${TRAN_:-${TYPE_}} )
      ARRAY_DSK_MODEL+=( "${MODEL_:-unknown}" )
      ARRAY_DSK_LABEL+=( "${LABEL_:-""}" )
      ARRAY_DSK_SERIAL+=( "${SERIAL_:-""}" )
	done < <(lsblk -PAo TYPE,NAME,PATH,SIZE,TRAN,MODEL,LABEL,SERIAL | grep -P 'TYPE="(disk|loop|lvm)"' | sort -k5,5 -k2,2)
#	done < <(lsblk -Pao TYPE,NAME,PATH,SIZE,TRAN,MODEL | grep -P 'TYPE="(disk)')
#	done < <(lsblk -Pao TYPE,NAME,PATH,SIZE,TRAN,MODEL | grep disk)
#	declare -p ARRAY_DSK_{DISKS,DEVICES,SIZE,TRAN,MODEL}
}

function sh_disk_infoOLD()
{
        ARRAY_DSK_DISKS=()
      ARRAY_DSK_DEVICES=()
         ARRAY_DSK_SIZE=()
         ARRAY_DSK_TRAN=()
        ARRAY_DSK_MODEL=()
   while IFS='\ ' read -r dsk_type dsk_name dsk_path dsk_size dsk_tran dsk_model dsk_model1 dsk_model2
   do
      [[ -z $dsk_size  ]] && dsk_size="0B"
      [[ -z $dsk_tran  ]] && dsk_tran="blk"
      [[ -z $dsk_model ]] && dsk_model="unknown"
        ARRAY_DSK_DISKS+=("${dsk_name}")
      ARRAY_DSK_DEVICES+=("${dsk_path}")
         ARRAY_DSK_SIZE+=("${dsk_size}")
         ARRAY_DSK_TRAN+=("${dsk_tran}")
        ARRAY_DSK_MODEL+=("${dsk_model} ${dsk_model1} ${dsk_model2}")
   done < <(lsblk -a -o TYPE,NAME,PATH,SIZE,TRAN,MODEL | grep disk)
}

sh_backup_partitions()
{
   if [ $# -ge 2 ]; then
      local disk="${1}"
      local device="${2}"
      local cdatetime=$(sh_diahora)
      local tmpdir="/tmp/$_APP_"
      local filetmp="$tmpdir/${device}.$cdatetime.dump"

      mkdir -p $tmpdir 2> /dev/null
      sfdisk -d $disk > $filetmp 2> /dev/null
      #  alerta "BACKUP DA TABELA DE PARTICOES"    \
      #         "Dispositivo : $disk"              \
      #         "  Backup on : ${filetmp}"         \
      #        "$(replicate "=" 80)"               \
      #         "$(cat $filetmp)"
   fi
}

sh_display()
{
   if [ $(tput cols) -lt 80 ] || [ $(tput lines) -lt 24 ]; then
      dialog --backtitle "$ccabec"	\
      --title "TERMINAL TOO SMALL" 	\
      --msgbox "\n\
Before you continue, re-size your terminal\nso it measures at least 80 x 24 characters.\n\
Otherwise you will not to able to use disk partition tools." 11 68
   fi
}

display_result()
{
   local xbacktitle=$ccabec

   if [ "$3" != "" ] ; then
      xbacktitle="$3"
   fi

   dialog	                     \
      --title     "$2"           \
      --beep                     \
      --no-collapse              \
      --no-cr-wrap               \
      --backtitle "$xbacktitle"  \
      --msgbox    "$1"           \
      0 0
}

sh_restore_partitions()
{
   if [ $# -ge 2 ]; then
      local disk="${1}"
      local filetmp="${2}"
      if [ -e $filetmp ] ; then
         sfdisk $disk < $filetmp 2> /dev/null
      fi
   fi
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

function police()
{
	echo "................_@@@__"
	echo "..... ___//___?____\________"
	echo "...../--o--POLICE------@} ...."
}

function log_prefix()
{
	NORMAL="${reset}"            # Standard console grey
	SUCCESS="${green}"           # Success is green
	WARNING="${yellow}"          # Warnings are yellow
	FAILURE="${red}"             # Failures are red
	INFO="${cyan}"               # Information is light cyan
	BRACKET="${blue}"            # Brackets are blue
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
}

#hex code
barra=$'\x5c'
check=$'\0xfb'
reg=$'\0x2a'
setvarcolors
log_prefix
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
: ${aPKGARRAY=()}
: ${aPKGSPLIT=()}
: ${aPKGLIST=}
: ${PKG_FOLDER_DIR=0}
: ${PKG_FULLNAME=1}
: ${PKG_ARCH=2}
: ${PKG_BASE=3}
: ${PKG_BASE_VERSION=4}
: ${PKG_VERSION=5}
: ${PKG_BUILD=6}
: ${PKG_SIZE=7}

# SUBROUTINES

alltrim()
{
	echo "${1// /}"                  # removendo todos os espacos da string
}

#Autor Julio C. Neves
function string_rfill()
{
	local string=${1// /^}    			# Trocando eventuais espaços preexistentes
	declare -i size=$2
	local char=$3
	local fillString
	printf -v fillString %-${size}s $string
	fillString=${fillString// /$char}
	echo "${fillString//^/ }"        	# Restaurando espaços anteriores }
}

function string_alltrim()
{
	local cstr=$1
	echo "${cstr//[$'\t\r\n ']}"
}

function string_len()
{
	local cstr=$1
	#echo ${#cstr}
	printf ${#cstr}
}

function string_removespace()
{
	local string=${1// /^}    				# Trocando eventuais espaços preexistentes
	echo "${string}"
}

function firstletter()
{
	word=$1
	#firstletter="$(echo $word | head -c 1)"
	#firstletter=$(echo "$word" | sed -e "{ s/^\(.\).*/\1/ ; q }")
	#firstletter="${word%"${word#?}"}"
	#firstletter=${word:0:1}
	firstletter=${word::1}
	printf "$firstletter\n"
}

#Extract the rightmost substring of a character expression
#Syntax
# right <cString> <nLen> --> cReturn
# right 'vcatafesta' 1
# right 'vcatafesta' 15
# right 'vcatafesta' -1
right()
{
   local cString=$1
   local -i nLen=$2
   local -i i
   local -i nMaxLen=${#cString}

   [[ $nLen -eq -1       ]] && nLen=nMaxLen
   [[ $nLen -gt $nMaxLen ]] && nLen=nMaxLen
   i=${#cString}-$nLen
   echo ${cString:$i:$nLen}
}

#Returns size of a string
# Syntax
# len <cString> --> <nLength>
# nlen=$(len $(right 'vcatafesta' 3))
# echo $nlen              # 3
len()
{
   local cString=$1
   echo ${#cString}
}

function kbytestobytes()
{
	str=$1
	declare -i len=$((${#str}))
	declare -i bytes=0
	lastletter=${str:0-1}
	if [[ $lastletter == 'k' || $lastletter == 'K' ]]; then
		bytes=${str:0:$len-1}
		bytes=$(($bytes * 1024))
	elif [[ $lastletter == 'm' || $lastletter == 'M' ]]; then
		bytes=${str:0:$len-1}
		bytes=$(($bytes * 1024 * 1024))
	elif [[ $lastletter == 'g' || $lastletter == 'G' ]]; then
		bytes=${str:0:$len-1}
		bytes=$(($bytes * 1024 * 1024 * 1024))
	else
		bytes=$1
	fi
	printf "$bytes\n"
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

function cpad()
{
	#centralizar string
	COLS=$(tput cols)
	printf "%*s\n" $[$COLS/2] "${1}"
}

function rpad()
{
	#justificar à direita
	COLS=$(tput cols)
	printf "%*s\n" $COLS "${1}"
}

function lpad()
{
	#justificar à esquerda + $2 espacos
	COLS=$(tput cols)
	printf "%ds\n" ${2} "${1}"
}

function sh_cdroot()
{
	cd - >/dev/null 2>&1
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

function emailcheck()
{
	email_REGEX="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
	email_to_check=${1}

	if [ -z "${email_to_check}" ]; then
		echo "É necessário inserir um endereço de e-mail!"
	   exit 2
	else
		if [[ "${email_to_check}" =~ ${email_REGEX} ]]; then
	   	echo "O endereço '${email_to_check}' é válido!"
	   else
			echo "O endereço '${email_to_check}' não é válido!"
			exit 1
		fi
	fi
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
	printf "%s\n" "${DOTPREFIX}${@}"
	return 0
}

function log_info_msg()
{
	echo -n -e "${BMPREFIX}${@}"
	#printf "${BMPREFIX}${@}"
	#logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
	#timespec
	#echo -n -e "${STAMP} ${logmessage}" >> ${BOOTLOG}
	return 0
}

function log_info_msg2()
{
    echo -n -e "${@}"
    # Strip non-printable characters from log file
    logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
    echo -n -e "${logmessage}" >> ${BOOTLOG}
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
	printf "${DOTPREFIX}${@}\n"
	#printf "${CURS_ZERO}${FAILURE_PREFIX}${SET_COL}${FAILURE_SUFFIX}\n"
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

function log_success_msg()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${SUCCESS_PREFIX}${SET_COL}${SUCCESS_SUFFIX}"
    # Strip non-printable characters from log file
    logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
    timespec
    echo -e "${STAMP} ${logmessage} OK" >> ${BOOTLOG}
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

function log_skip_msg()
{
    echo -n -e "${BMPREFIX}${@}"
    echo -e "${CURS_ZERO}${SKIP_PREFIX}${SET_COL}${SKIP_SUFFIX}"
    # Strip non-printable characters from log file
    logmessage=`echo "${@}" | sed 's/\\\033[^a-zA-Z]*.//g'`
    echo "SKIP" >> ${BOOTLOG}
    return 0
}

function log_wait_msg()
{
	#echo -n -e "${BMPREFIX}${@}"
	#echo -e "${CURS_ZERO}${WAIT_PREFIX}${SET_COL}${WAIT_SUFFIX}"
	printf "${BMPREFIX}${@}"
	printf "${CURS_ZERO}${WAIT_PREFIX}${SET_COL}${WAIT_SUFFIX}\n"
	#echo " OK" >> ${BOOTLOG}
	return 0
}

function die()
{
	local msg=$1; shift
   log_failure_msg2 "${red}$msg" "$@" >&2
	exit 1
}

function runcmd()
{
	if (( EUID != 0 )); then
		msg "Privilege escalation required"
		if sudo -v &>/dev/null && sudo -l &>/dev/null; then
			sudo "$@"
		else
			die 'Unable to escalate privileges using sudo'
		fi
	else
		"$@"
	fi
}

function evaluate_retval()
{
   local error_value="$?"

	if [ $# -gt 0 ]; then
   	error_value="$1"
	fi

	if ! (( $grafico )); then
		if [ ${error_value} = 0 ]; then
			log_success_msg2
		else
			log_failure_msg2
		fi
	fi
	return ${error_value}
}

function is_true()
{
   [ "$1" = "1" ] || [ "$1" = "yes" ] || [ "$1" = "true" ] ||  [ "$1" = "y" ] || [ "$1" = "t" ]
}

function debug()
{
	whiptail							\
		--fb							\
		--clear						\
		--backtitle "[debug]$0"	\
		--title     "[debug]$0"	\
		--yesno     "${*}\n"	\
	0 40
	result=$?
	if (( $result )); then
		exit
	fi
	return $result
}

#	--yesno   	"${1}"			\
function info()
{
	dialog							\
	--backtitle	"\n$*\n"	   	\
	--title		"[info]$0"		\
	--yesno   	"${*}\n"			\
	0 0
	result=$?
	if (( $result )); then
		exit
	fi
	return $result
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

function dog()
{
	if [ $# -ge 1 ]; then
		echo "$(<$1)"
	fi
}

function _cat_()
{
	if [ $# -ge 1 ]; then
		echo "$(<$1)"
	fi
}

# Módulo para emular o grep
# Agradecimentos a SlackJeff
# https://github.com/slackjeff/bananapkg
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
# Está funcionando por enquanto somente para linhas.
# Agradecimentos a SlackJeff
# https://github.com/slackjeff/bananapkg
function _WC()
{
	local check="$@" 	# Recebendo args
	local inc=0    	# Var incremento

	for x in $check; do
		(( inc++ ))
	done
	printf "$inc\n"
	return 0
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
	echo -e "${TOUPPER}"
}

function tolower()
{
	declare -l TOLOWER=${@}
	echo -e "${TOLOWER}"
}


function tolowerA()
{
	$1 | tr 'A-Z' 'a-z'
}

toupperA()
{
	$1 | tr 'a-z' 'Z-A'
}

filetolower()
{
	for arquivo in $@
	do
		printf "$arquivo\n"
		mv "$arquivo" "${arquivo,,}"
	done
}

mvlower()
{
	local filepath
	local dirpath
	local filename

	for filepath in "$@"; do
		dirpath=$(dirname "$filepath")
		filename=$(basename "$filepath")
		mv "$filepath" "${dirpath}/${filename,,}"
	done
}

sh_diahora()
{
	DIAHORA=`date +"%d%m%Y-%T" | sed 's/://g'`
	printf "%s\n" $DIAHORA
}

now()
{
	printf "%(%m-%d-%Y %H:%M:%S)T\n" $(date +%s)
}

strzero()
{
	printf "%0*d" $2 $1
}

# $1 - caractere
# $2 - tamanho
replicate()
{
	#  Repete um caractere um determinado número de vezes
	#+ Recebe:
	#+  Tamanho final da cadeia
	#+  e caractere a ser repetido
	local Var
	printf -v Var %$2s " "  #  Coloca em $Var $1 espaços
	echo ${Var// /$1}       #  Troca os espaços pelo caractere escolhido
}
export -f replicate

# $1 - caractere
# $2 - tamanho
function repete()
{
   for counter in $(seq 1 $2);
   do
      printf "%s" $1
   done
}
export -f repete

# $1 - linha
# $2 - coluna
# $3 - tamanho
linhaHorizontal()
{
	printf -v Espacos %$3s
	printf -v Traco "\e(0\x71\e(B"
	tput cup $1 $2; echo ${Espacos// /$Traco}
}

function LerMatricula {
	read -p "Matricula: " cMatr
	((${#cMatr} == 6 )) && [[ -z ${cMatr//[0-9]/} ]] && return 0 || return 1; 
}


function maxcol()
{
	if [ -z "${COLUMNS}" ]; then
		COLUMNS=$(stty size)
		COLUMNS=${COLUMNS##* }
	fi
	printf $COLUMNS
}

inkey()
{
	read -t "$1" -n1 -r -p "" lastkey
}

inkey1()
{
   dialog	                  \
      --title     "$2"        \
      --backtitle "$ccabec"   \
      --pause     "$2"        \
      0 0         "$1"
}

# simulando bash com echo
# Vilmar Catafesta <vcatafesta@gmail.com>
function _cat()
{
	#echo "$(<$1)"
	printf "%s\n" "$(<$1)"
}

function unsetvarcolors()
{
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
	printf "${blue}${msg}${reset}\n"
}

spinner()
{
	spin=('\' '|' '/' '-' '+')

	while :; do
		for i in "${spin[@]}"; do
			echo -ne "${cyan}\r$i${reset}"
			#sleep 0.1
		done
	done
}

check_deps()
{
   local errorFound=0
   declare -a missing

   for d in "${DEPENDENCIES[@]}"; do
      [[ -z $(command -v $d) ]] && missing+=($d) && errorFound=1 && printf "ERRO: não encontrei o comando '$d'\n"
   done
   #[[ ${#missing[@]} -ne 0 ]]
   if (( $errorFound )); then
    echo "---IMPOSSÍVEL CONTINUAR---"
    echo "Esse script precisa dos comandos listados acima" >&2
    echo "Instale-os e/ou verifique se estão no seu \$PATH" >&2
    exit 1
  fi
}

sh_checkDependencies()
{
   local errorFound=0

   for command in "${DEPENDENCIES[@]}"; do
      log_msg "Checking dependencie : $command"
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

sh_version()
{
	printf "${orange}${0##*/} ${_VERSION_}\n"
}

scrend()
{
	exit $1
}

sh_checkroot()
{
	[[ $1 = "-Qq" ]] && return
   if [ "$(id -u)" != "0" ]; then
      printf "${red} error: You cannot perform this operation unless you are root!\n"
      exit 1
   fi
}

function criartemp()
{
	printf "Prefix    <default=T>    : "; read prefix
	printf "Extension <default=tmp>  : "; read ext
	printf "Modo      <default=0644> : "; read mode
	printf "Quantity  <default=10>   : "; read qtd

   [[ -z $prefix  ]] && prefix="T"
   [[ -z $ext     ]] && ext="tmp"
   [[ -z $qtd     ]] && qtd=10
   [[ -z $mode    ]] && mode=0644

	eval echo $prefix{0..$qtd}.$ext | xargs touch;

	#count=0
	#while [ $count -lt $qtd ]; do
   #	arq=$prefix$count
   #	>| $arq.$ext
   #  	[[ $mode != 0644 ]] && chmod $mode $arq.$ext
   # 	printf "$PWD/$arq.$ext\n"
   #	(( count++ ))
	#done
}

function as_root()
{
	if   [ $EUID = 0 ];        then $*
	elif [ -x /usr/bin/sudo ]; then sudo $*
	else                            su -c \\"$*\\"
	fi
}

which2()
{
	#cat > /usr/bin/which << "EOF"
	##!/bin/bash
	type -pa "$@" | head -n 1
	#type -pa "$@" | head -n 1 ; exit ${PIPESTATUS[0]}
	#EOF
	#chmod -v 755 /usr/bin/which
	#chown -v root:root /usr/bin/which
}

human_print()
{
	while read B dummy; do
	  [ $B -lt 1024 ] && echo ${B} bytes && break
	  KB=$(((B+512)/1024))
	  [ $KB -lt 1024 ] && echo ${KB} kilobytes && break
	  MB=$(((KB+512)/1024))
	  [ $MB -lt 1024 ] && echo ${MB} megabytes && break
	  GB=$(((MB+512)/1024))
	  [ $GB -lt 1024 ] && echo ${GB} gigabytes && break
	  echo $(((GB+512)/1024)) terabytes
	done
}

#find_char_glob_expr m "mensalao"
#retorno: posicao ou 0 se não encontrado
#echo $?
find_char_glob_expr()
{
   local char="$1"
   local str=("${@:2}")
#  eval expr match "$str" '.*f.*'
#  eval expr "$str" : '.*f.*'

   for i in ${str[*]}; do
      eval expr index $i $char
   done
}

#find_char_glob_expansao m "mensalao"
#retorno: $?
#echo $?
find_char_glob_expansao()
{
   local char="$1"
   local str=$2
   [[ $str == *"$char"* ]]
}

find_char()
{
	local char="$1"
   local str="$2"
   local len=$((${#str}))
	local size=${#str}
	local i

	for ((i=0; i<$size; i++)); do
		if [[ "${str:$i:1}" == \. ]] ; then
			echo $i
			return 0
		fi
	done
	return 1
}

#human_to_bytes "1K"
#human_to_bytes "1M"
#human_to_bytes "1G"
#human_to_bytes "1.5M"
#human_to_bytes "1.5K"
human_to_bytes()
{
   local size="$1"
	[[ "$size" == '' ]] && size="0"
   local lastletter=${size:0-1}
   local count=0
   local upper=${lastletter^^}

	size=${size/$lastletter/$upper}

	LC_ALL=C numfmt --from=iec "$size"
	return $?

   case $upper in
      B) count=0;;
      K) count=1;;
      M) count=2;;
      G) count=3;;
      T) count=4;;
   esac

   awk -v count=$count -v size=$size '
   BEGIN {
     while (count >= 1) {
         size *= 1024
         count--
      }
      sizestr = sprintf("%d", size)
      sub(/\.?0+$/, "", sizestr)
      printf("%s\n", sizestr)
   }'
}

human_to_size()
{
	human_to_bytes "$1"
	return $?
}

size_to_human()
{
	size=$1
	[[ "$size" == '' ]] && size="0"
	LC_ALL=C numfmt --to=si "$size"
	return $?

	awk -v size="$1" '
	BEGIN {
		suffix[1] = "B"
		suffix[2] = "KiB"
		suffix[3] = "MiB"
		suffix[4] = "GiB"
		suffix[5] = "TiB"
		suffix[6] = "PiB"
		suffix[7] = "EiB"
		count = 1

		while (size > 1024) {
			size /= 1024
			count++
		}

		sizestr = sprintf("%.2f", size)
		sub(/\.?0+$/, "", sizestr)
		printf("%s %s", sizestr, suffix[count])
	}'
}

function join()
{
	{
		local indelimiter="${1- }"
		local outdelimiter="${2-.}"
	}

	local car
	local cdr
	local IFS

	IFS="${indelimiter}"
	read -t 1 car cdr || return
	test "${cdr}" || { echo "${car}" ; return ; }
	echo "${car}${outdelimiter}${cdr}" | ${FUNCNAME} "${indelimiter}" "${outdelimiter}"
}

function len()
{
	return $#
}

function strlen()
{
	echo ${#1}
}

arraylen()
{
  local vetname=$1
  eval echo \${#$vetname[@]}
}

arraylen2()
{
  local vet=("$@")
  echo ${#vet[@]}
}

function arraylen1()
{
   for item in ${array[*]}
   do
      printf "   %s\n" $item
   done
   arraylength=${"$1"[*]}
}

function seek()
{
	count=0
	while [ "x${wholist[count]}" != "x" ]
	do
		(( count++ ))
	done
}

function ascan4()
{
	true=0
	false=1
	array=($(ls -1 /etc/ | sort ))
	search='passwd'

	if [[ "${array[@]}" =~ "${search}" ]]; then
		echo "${!array[*]}"
		echo "${BASH_REMATCH[0]}"
	fi
}

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
			return 0
			;;
	esac
	return 1
}

#array=("something to search for" "a string" "test2000")
#ascan "a string" "${array[@]}"
#echo $? # 0
function ascan() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

function contains()
{
	local n=$#
	local value=${!n}

	for ((i=1;i < $#;i++)) {
		if [ "${!i}" == "${value}" ]; then
			echo $i
		fi
	}
	echo $n
}

#array=("a" "b" "c" "d" "e")
#seekinarray "c" ${array[@]}"
# 3
seekinarray() {
   local arr=("${@:2}")
   local search="$1"

#  [[ "${@:2}" =~ $1 ]]
#  search=${BASH_REMATCH[0]}

#  solucao 1
 	local -i indice
 	indice=$(printf "%s\n" "${@:2}" | grep -n -m 1 "^$search$" | cut -d: -f1)
	((--indice)); echo $indice

#  solucao 2
#	declare -p arr | grep -Po "\[\K[0-9]+(?=\]=\"$search\")"
}

#arr=(a b 'c d' e)
#search=e
# get_index $search "${arr[@]}"
get_index()
{
   local lresult=1
   for ((i=2; i<=$#; i++))
   do
      [[ "${@:i:1}" == "$1" ]] && {
         echo $((i-2));
         lresult=0
         break;
         };
   done
   return $lresult
}

#arr=({a..z})
#search=v
#echo $(seekascan "${arr[@]}" $search)
seekascan()
{
   local n=$(($#-1))
   local value=${!n}

	array=("${@:1}")
	unset array[$n]
#	echo "${array[@]}"
#	echo "tamanho: $n"
#	echo "search : $value"
#	echo "search: ${!n}"
#	declare -p array

   for ((i=1;i < $#;i++)) {
      if [ "${!i}" == "${value}" ]; then
         ((--i)); echo $i
         return 0
      fi
   }
   return 1
}

function ex()
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1     ;;
			*.tar.gz)    tar xvzf $1     ;;
			*.tar.xz)    tar Jxvf $1     ;;
         *.lz)        lzip -d -v $1   ;;
         *.chi.zst)   tar --force-local -xvf "$@" ;;
         *.tar.zst)   tar --force-local -xvf "$@" ;;
         *.chi)       tar --force-local -xvf "$@";;
         *.mz)        tar --force-local Jxvf "$@";;
         *.cxz)       tar Jxvf $1     ;;
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

limpa()
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
		rm -rfd $i/
		evaluate_retval
	done
	log_success_msg2 "Finish."
}

function dwup()
{
	if [ "$(vercmp $2 4.0.4)" -lt 0 ]; then
		echo
	fi
}

quit()
{
	[ $? -ne 0 ] && { clear ; exit ;}
}

function sh_version()
{
	printf "$0 $_VERSION_\n"
}

alerta()
{
   dialog	                           \
      --title  "$1"                    \
      --backtitle "$ccabec"            \
      --msgbox    "$2\n$3\n$4\n$5\n$6" \
      10 60
}

function conf()
{
	read -p "$1 [Y/n]"
	[[ ${REPLY^} == "" ]] && return $true
	[[ ${REPLY^} == N ]]  && return $false || return $true
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
	[[ ${REPLY^} == "" ]] && return 0
	[[ ${REPLY^} == N  ]] && return 0 || return 1
}

function limpa_tar_zst()
{
	for i in {a..z}
	do
		cd $i
		rm *.pkg.tar.zst
		cd ../
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

function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; } 	# Creates an archive (*.tar.gz) from given directory.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }					# Create a ZIP archive of a file or folder.

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

function newtemp()
{
	#!/bin/bash
	if [ $# -lt 2 ]
	then
		# Imprime o nome do script "$0" (isso eh bom para tornar um template de script) e como usá-lo 
		echo "usar $0 <qtde> <ext>"
		# Sai do script com código de erro 1 (falha)
	else
		for((i=1; i<=${1}; i++))
		do
			touch tmp-${i}.${2}
			echo -e tmp-${i}.${2}
		done
	fi
}

function take()
{
	mkdir -p $@ && cd ${@:$#}
}

function colors()
{
	for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done
}

function colortable()
{
	for ((i=0; i<256; i++)) ;do
  	 echo -n '  '
    tput setab $i
    tput setaf $(( ( (i>231&&i<244 ) || ( (i<17)&& (i%8<2)) ||
        (i>16&&i<232)&& ((i-16)%6 <(i<100?3:2) ) && ((i-16)%36<15) )?7:16))
    printf " C %03d " $i
    tput op
    (( ((i<16||i>231) && ((i+1)%8==0)) || ((i>16&&i<232)&& ((i-15)%6==0)) )) &&
        printf "\n" ''
	done
}

function DOT()
{
	printf "${blue}:: ${reset}"
	return
}

function sh_adel()
{
#  local arr=("${@:1}")
   local arr=($@)
   local new=()
   local nfiles=${#arr[*]}

   if (( nfiles )); then
#     new=($(sort -u <<< "$(printf '%s\n' "${arr[@]}")"))
      new=($(uniq -u <<< "$(printf '%s\n' "${arr[@]}")"))
      printf '%s\n' "${new[@]}"
      return 0
   fi
   printf '%s\n' "${new[@]}"
   return 1
}

function sh_adelOLD()
{
#  local arr=("${@:1}")
	local arr=($@:1)
   local item
   local nfiles=${#arr[*]}

   if (( nfiles )); then
      for item in ${arr[*]}; {
         echo $item >> /tmp/.array    #imprime o conteudo da matriz
      }
      deps=($(sort -u /tmp/.array ))
      rm /tmp/.array >/dev/null 2>&1
      return 0
   fi
   return 1
}

function print()
{
	[[ "$printyeah" = '1' ]] && echo -e "$@"
}

function fmt()
{
	printf "${pink}(${ncount}:5/${ntotalpkg}:${nfullpkg})${reset}"
	return $?
}

function checkDependencies()
{
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

function checkDependencies()
{
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
parseopts()
{
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

