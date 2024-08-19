#!/usr/bin/env bash
#shellcheck disable=SC2033
#shellcheck source=/dev/null

#bash -c "help declare"
#echo "blacklist sbridge" >> /etc/modprobe.d/blacklist.conf
#export XDG_RUNTIME_DIR ; XDG_RUNTIME_DIR=/run/user/$(id -g)
#HISTIGNORE='+([a-z])'
#HISTIGNORE=$'*([\t ])+([-%+,./0-9\:@A-Z_a-z])*([\t ])'
#export TMPDIR=/tmp
export TMPDIR=/dev/shm
#trancastderr 2>&-
PROMPT_DIRTRIM=0
export LC_ALL="pt_BR.UTF-8"
export SBCL_HOME=/usr/lib/sbcl
#IFS=$' \t\n'
SAVEIFS=$IFS
LIBRARY=${LIBRARY:-'/usr/share/fetch'}
source /usr/lib/lsb/init-functions
source "$LIBRARY"/core.sh

have() {
	unset -v have
	# Completions for system administrator commands are installed as well in
	# case completion is attempted via `sudo command ...'.
	PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
	have="yes"
}

append_path() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*)PATH="${PATH:+$PATH:}$1";;
	esac
}

appendpath() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*) PATH="${PATH:+$PATH:}$1";;
	esac
}

pathremove() {
	local IFS=':'
	local NEWPATH
	local DIR
	local PATHVARIABLE=${2:-PATH}
	for DIR in ${!PATHVARIABLE}; do
		[[ "$DIR" != "$1" ]] && NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
	done
	export $PATHVARIABLE="$NEWPATH"
}

pathprepend() {
	pathremove $1 $2
	local PATHVARIABLE=${2:-PATH}
	export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend() {
	pathremove $1 $2
	local PATHVARIABLE=${2:-PATH}
	export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}
export -f pathremove pathprepend pathappend

sh_bashrc_configure() {
	#alias sc="sudo sftp -P 65002 u356719782@185.211.7.40:/home/u356719782/domains/chililinux.com/public_html/packages/core/"
	#alias hs="sudo ssh -X -p 65002 u356719782@185.211.7.40"
	alias hs="sudo ssh -X -p 65002 u537062342@154.49.247.66"
	alias sc="sudo sftp -P 65002 u537062342@154.49.247.66:/home/u537062342/domains/chililinux.com/public_html/packages/core/"
	alias hpb="sudo ssh -X -p 2222 root@vcatafesta.ddns.net"

	# Definir a variável de controle para restaurar a formatação original
	reset=$(tput sgr0)

	# Definir os estilos de texto como variáveis
	bold=$(tput bold)
	underline=$(tput smul)   # Início do sublinhado
	nounderline=$(tput rmul) # Fim do sublinhado
	reverse=$(tput rev)      # Inverte as cores de fundo e texto

	# Definir as cores ANSI como variáveis
	black=$(tput bold)$(tput setaf 0)
	red=$(tput bold)$(tput setaf 196)
	green=$(tput bold)$(tput setaf 2)
	yellow=$(tput bold)$(tput setaf 3)
	blue=$(tput setaf 4)
	pink=$(tput setaf 5)
	magenta=$(tput setaf 5)
	cyan=$(tput setaf 6)
	white=$(tput setaf 7)
	gray=$(tput setaf 8)
	orange=$(tput setaf 202)
	purple=$(tput setaf 125)
	violet=$(tput setaf 61)
	light_red=$(tput setaf 9)
	light_green=$(tput setaf 10)
	light_yellow=$(tput setaf 11)
	light_blue=$(tput setaf 12)
	light_magenta=$(tput setaf 13)
	light_cyan=$(tput setaf 14)
	bright_white=$(tput setaf 15)

	# Cores - Substitua pelos códigos ANSI do seu terminal, se necessário
	GREEN="\033[1;32m"   # Verde
	RED="\033[1;31m"     # Vermelho
	YELLOW="\033[1;33m"  # Amarelo
	BLUE="\033[1;34m"    # Azul
	MAGENTA="\033[1;35m" # Magenta
	CYAN="\033[1;36m"    # Ciano
	RESET="\033[0m"      # Resetar as cores

	#eval "$(dircolors -b $HOME/.dircolors)"
	#source /github/benshmark/v3.sh
	#alias benshmark=benshmark-v3
	alias maketar="chili-maketar"
	alias dmesg="dmesg -T -x"
	alias dmesgerr="dmesg -T -x | grep -P '(:err |:warn )'"
	#alias bat="bat -l bash"
	#alias nproc="nproc --ignore=18"
	#shopt -s cdspell
	#shopt -s dotglob       # ls *bash*
	#shopt -s extglob       # ls file?(name); ls file*(name); ls file+(name); ls file+(name|utils); ls file@(name|utils)
	#shopt -s nullglob		# suppress error message of a command
	#shopt -s dotglob # * expande tudo, começando ou não com ponto, menos . e ..
	#set +h
	#set -o noclobber   #bloquear substituicao de arquivo existente
	set +o noclobber #liberar  substituicao de arquivo existente. operator >| ignore the noclobbeer

	#ulimit -S -c 0 # Don't want coredumps.
	#ulimit -n 32767
	#export PS1='\u@\h:\w\$\[\033[01;31m\]\u@\h[\033[01;34m\]\w \[\e[1;31m\]\$ \[\033[00m\]'
	#export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\$\[\033[01;34m\]\w\[\e[1;31m\]\$ \[\033[00m\]'
	#export PS1='\[\033[01;31m\]${debian_chroot:+($debian_chroot)}\u@\h[\033[01;34m\]\w \[\e[1;31m\]\$ \[\033[00m\]'
	#export DISPLAY=10.0.0.80:0.0
	#export TZ=America/Porto_Velho
	export ROOTDIR=${PWD#/}
	export ROOTDIR=/${ROOTDIR%%/*}
	export PATH=".:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:$HOME/sbin:$HOME/.cargo/bin:/github/chili:/github/void-installer"
	export CDPATH=".:..:~"
	#export LD_LIBRARY_PATH=/lib:/usr/lib
	export VISUAL=nano
	export EDITOR=nano
	#umask 022
	#export LFS=/mnt/lfs
	#export LC_ALL=POSIX
	#export LFS_TGT=$(uname -m)-lfs-linux-gnu
	export MAKEFLAGS='-j 36'
	alias lvma="lvm vgchange -a y -v" $1
	alias src="cd /sources/blfs"
	alias wget="wget --no-check-certificate"
	alias cdx="cd /var/www/html"
	alias pxe="cd /mnt/NTFS/software"
	alias discos="udisksctl status"
	alias dd="dd status=progress"
	alias ack="ack -n --color-match=red"
	alias tmm="tail -f /var/log/mail.log | grep ."
	alias win="lightdm"
	alias dir="dir -lh --group-directories-first"
	alias DIR=dir
	alias github="cd /github ; ls"
	alias backuptheme="rsync --progress -Cravzp --rsh='ssh -l root' root@10.0.0.80:/mnt/usr/share/grub/themes/ /usr/share/grub/themes/"
	alias dude="wine /root/.wine/drive_c/'Program Files'/Dude/dude &"
	alias sci="cd /home/sci-work/; ./sci"
	alias sl="cd /home/vcatafesta/sci/src.linux ; ls"
	#alias tree="tree -Cush"
	#alias tree="tree -Chv"
	#alias fft="find . -type f -exec du -Sh {} + | sort -rh | head -n 20"

	# newbiew from windows
	alias ren=mv
	alias ls="ls -CF -h --color=auto --group-directories-first"
	alias dirm="ls -h -ls -Sr --color=auto"
	#alias dir="ls -la -c --color=auto"
	#alias dir="exa -la -g --icons --color=auto"
	#alias dir="exa --long --header --git --all --icons"
	alias dir="exa -all --long --modified --group"
	alias dir="ls -CF -la -h --color=auto --group-directories-first"
	alias dir="exa -all --long --modified --group --icons --color=auto"
	alias l=dir
	alias dirt="la -h -ls -Sr -rt --color=auto"
#	alias dir="ls -h -ls -X --color=auto"
	alias ed=nano
	alias ED=nano
	alias copy=cp
	alias md=mkdir
	alias rd=rmdir
	alias del=rm
	alias deltraco="rm --"
	alias df="df -hT --total"
	alias dfc="dfc -afTnc always | sort -k2 -k1"
	alias fs="file -s"
	alias mem="free -h"
	alias cls=clear
	alias vgs="sudo vgs"
	alias gvs="sudo vgs"
	alias pvs="sudo pvs"
	alias lvs="sudo lvs"
	alias CD=cd
	#alias ddel1="rm -fvR"
	#alias ddel2="find -iname $1 -type d | xargs rm -fvR"
#	alias mmv="mv -f /diretorio01/{.*,*} /diretorio0/"
	alias fdisk="fdisk -l"
	alias ouvindo="netstat -anp | grep :69"
	alias ouvindo="netstat -anp | grep :"
	alias listen="netstat -anp | grep :"
#	alias portas="sockstat | grep ."
#	alias portas="nmap -p- localhost | grep ."
#	alias portas="nmap -v \$1"
#	alias portas="nmap --scan-delay 3s 172.31.255.2 -p 80,22"
#	alias portas="nmap -v localhost"
	alias portas="sudo nmap -sS -p- localhost | grep ."
	alias portas1="sudo lsof -i | grep ."
	alias port="sudo sockstat | grep ."
	alias cdi="cd /home/vcatafesta/SYS/sci ; ls"
	alias cds="cd /etc/rc.d/init.d ; ls"
	alias cdd="cd /etc/systemd/system/ ; ls"
	alias du="du -h"
	alias dut="du -hs * | sort -h"
	#alias xcopy="cp -Rpvn"
	alias xcopyn="cp -Rpvan"
	alias xcopy="cp -Rpva"
	alias xcopyu="cp --recursive -p --verbose --archive --update"
	#alias cp="rsync -ahu --info=progress2"
	#alias cpr="rsync -ahur --info=progress2"
	alias versao="lsb_release -a"
	#alias rdel="find -iname -exec rm -v {} \;"
	#alias rdel="find -name $1 -exec rm -fv {} \;"
	#alias rdel='find . -name "$1" | xargs -i bash -c "mv {} dir; echo Removido: {}"'
	#alias rdel='find . -name '$1' -print0 | xargs -0 rm -v'
	alias ver="lsb_release -a"
	alias cdg="cd /github/ChiliOS/packages/core"
	alias cdr="cd /github/ChiliOS/repo"
	alias cdp="cd /var/cache/pacman/pkg"
	alias cda="cd /var/cache/fetch/archives"
	alias cda="cd $HOME/.local/share/applications/"
	alias cdb="cd /github/bcc/"
	alias dira="dir $HOME/.local/share/applications/"
	alias dirb="dir /github/bcc/"
	alias cds="cd /var/cache/fetch/search"
	alias cdd="cd /var/cache/fetch/desc"
	alias cdl="cd /github/sci/linux"
	alias cdf="cd /github/fenix"
	alias cdgo="cd /chili/go/"
	alias .1='cd ..'
	alias .2='cd ../..'
	alias .3='cd ../../..'
#	alias pacman="pacman -S --overwrite \*" # sudo pacman -S --overwrite "*"
	alias start=sr
	alias stop=st
	alias restart="systemctl restart"
	alias status="systemctl status"
#	alias reload="systemctl reload"
	alias disable="systemctl disable"
	alias enable="systemctl enable"
	alias ativo="systemctl is-enabled"
	alias nm-ativo="systemctl --type=service"
#	alias reload="systemctl daemon-reload"
#	alias jornal="journalctl -xe"
#	alias jornal="journalctl -b -p err"
	alias jornal="journalctl -p 0..3 -xb"
	alias jornalclear="sudo journalctl --rotate; journalctl --vacuum-time=1s"
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
	alias rsync="rsync --progress -Cravzp"
	alias dcomprimtar="tar -vzxf"
	alias targz="tar -xzvf"
	alias tarxz="tar -Jxvf"
	alias tarbz2="tar -xvjf"
	alias untar="tar -xvf"
	alias pyc="python -OO -c 'import py_compile; py_compile.main()'"
	alias tml="tail -f /var/log/lastlog"
	#alias tms="tail -f /var/log/syslog"
	#alias tmm="tail -f /var/log/messages"
	#alias tmk="tail -f /var/log/mikrotik/10.0.0.254.2018.01.log | grep: '^[0-9\.]*'"
	alias tmk="multitail -f /var/log/mikrotik/10.0.0.254.2018.01.log"
	alias tmd="tail -f /var/log/dnsmasq.log"
	alias smbmount="mount -t cifs -o username=vcatafesta,password=451960 //10.0.0.68/c /root/windows"
	alias ip="ip -c"

	#	alias rmake="hbmk2 -info"
	alias rmake="[ ! -d /tmp/.hbmk ] && { mkdir -p /tmp/.hbmk; }; hbmk2 -debug -info -comp=gcc -cpp=yes -jobs=36"
	#	alias rmake="hbmk2 -info -comp=clang -cpp=yes -jobs=36"

	#man colour
	export LESS_TERMCAP_mb=$'\e[1;32m'
	export LESS_TERMCAP_md=$'\e[1;32m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_se=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[01;33m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[1;4;31m'

	if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
		export TERM='gnome-256color'
	elif infocmp xterm-256color >/dev/null 2>&1; then
		export TERM='xterm-256color'
	fi

	#Python 3.7.3
	PYTHONDOCS=/usr/share/doc/python-2.7.16/html
	PYTHONDOCS=/usr/share/doc/python-3/html
	#CHOST="i686-pc-linux-gnu"
	#CFLAGS="-march=prescott -O2 -pipe -fomit-frame-pointer"
	#CFLAGS="-march=native -02 -pipe"
	#CFLAGS="-march=athlon64 -O2 -pipe"
	#CFLAGS="-march=skylake -O2 -pipe"
	#CXXFLAGS="${CFLAGS}"

	CHOST="x86_64-pc-linux-gnu"
#	CFLAGS="-march=native -02 -pipe"
#	CFLAGS="-march=pentium3 -02 -pipe"
#	CFLAGS="-march=ahtlon64 -03 -pipe"
#	CFLAGS="-march=generic -02 -pipe"
#	Core i3/i5/i7 and Xeon E3/E5/E7 *V2
#	CFLAGS="-march=ivybridge -O2 -pipe"
#	Pentium
#	CFLAGS="-O2 -march=pentium-m -pipe"
#	CFLAGS="-march=ivybridge -mno-avx -mno-aes -mno-rdrnd -O2 -pipe"
#	CFLAGS="-march=ivybridge -mno-avx -mno-aes -mno-rdrnd -O3 -pipe -fomit-frame-pointer"
#	CFLAGS="-mtune=intel -O2 -pipe -fomit-frame-pointer"
#	CFLAGS="-mtune=generic -O3 -pipe -fomit-frame-pointer"
#	CFLAGS="-march=x86-64 -02 -pipe"
#	CXXFLAGS="${CFLAGS}"
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
#	W12="-Werror=maybe-uninitialized"
	W12="-Wmaybe-uninitialized"
	W0="-mtune=generic -fPIC -Os -pipe -fomit-frame-pointer"

#	CFLAGS="${W0} ${W1} ${W2} ${W3} ${W4} ${W5} ${W6} ${W7} ${W8} ${W9} ${W10} ${W11} ${W12}"
#	CXXFLAGS="${W0} ${W1} ${W2} ${W3} ${W5} ${W6} ${W7} ${W8} ${W9}"
#	export CHOST CFLAGS CXXFLAGS

	#gcc -c -Q -march=native --help=target
	#gcc -### -march=native /usr/include/stdlib.h
	#gcc -v -E -x c /dev/null -o /dev/null -march=native 2>&1 | grep /cc1
	#unset CXXFLAGS
	export PATH="$PATH:/src/depot_tools"
	#PS1="\e[32;1m\u \e[33;1m→ \e[36;1m\h \e[37;0m\w\n\e[35;1m⚡\e[m"

	if [[ "${USER}" == "root" ]]; then
		userStyle="${red}"
	else
		userStyle="${orange}"
	fi

	if [[ "${SSH_TTY}" ]]; then
		hostStyle="${bold}${red}"
	else
		hostStyle="${yellow}"
	fi

	# Set the terminal title and prompt.
	#	PS1="\[\033]0;\W\007\]"; # working directory base name
	#	PS1+="\[${bold}\]\n"; # newline
	#	PS1+="\[${userStyle}\][SYSTEMD]\u@[$HOSTNAME]"; # username
	#	PS1+="\[${white}\] at ";
	#	PS1+="\[${hostStyle}\]\h"; # host
	#	PS1+="\[${white}\] in ";
	#	PS1+="\[${green}\]\w"; # working directory full path
	#	PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
	#	PS1+="\n";
	#	PS1+="\[${white}\]\e[35;1m⚡\e[m\[${reset}\]"; # `#` (and reset color)
	#	PS1='\e[32;1m\u \e[33;1m→ \e[36;1m\h \e[37;0m\w\n\e[35;1m�# \e[m'
	#	export PS1
	#export LFS=/mnt/lfs
	#export LFS=/mnt/build_dir
	#export FORCE_UNSAFE_CONFIGURE=1
	#export HOME="/root"
	#export OLDPWD
	#export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"
	#export PWD="/"
	#export SHLVL="1"
	#export TERM="xterm-256color"
	alias l='echo $PWD'
	alias pkgdir='echo $PWD'
	srcdir="${PWD#/}"
	alias mkd='make install DESTDIR=$l'
	alias srcdir='/${srcdir%%/*}'
	alias r='echo $OLDPWD'
	alias c="cd /sources"
	alias ddel="find -name $1 | xargs rm -fvR"
}

# Function to run upon exit of shell.
_exit() {
	echo -e "${BRed}Hasta la vista, baby${NC}"
}
trap _exit EXIT

# Função para obter o status do último comando
get_exit_status() {
	local status="$?"
	if [ $status -eq 0 ]; then
		echo -e "${GREEN}✔"
	else
		echo -e "${RED}✘${MAGENTA}${status}"
	fi
}

as_root() {
	if   [ $EUID = 0 ];        then $*
	elif [ -x /usr/bin/sudo ]; then sudo $*
	else                            su -c \\"$*\\"
	fi
}
export -f as_root

has()			{ command -v "$1" >/dev/null; }
chili-count-extension() {	ls | cut -sf2- -d. | sort | uniq -c ; }
chili-count-vogal() { local word="$1"; tr '[:upper:]' '[:lower:]' <<< "$word" | grep -o '[aeiou]' | sort | uniq -c ; }
#xdel()   { find . -name "*$1*" | xargs rm -fv ; }
ddel2()   { find . -iname $1 -print0 | xargs rm --verbose; }
tolower() { find . -name "*$1*" | while read; do mv "$REPLY" "${REPLY,,}"; done; }
toupper() { find . -name "*$1*" | while read; do mv "$REPLY" "${REPLY^^}"; done; }
path()    { echo -e "${PATH//:/\\n}"; }
load()    { source $1; }
rdel() {
	find . -iname "$1" -exec rm -f {} +
}
export -f rdel
delr() {
	find . -iname "$1" -exec rm -f {} \;
}
export -f delr
chili-toSpaceFixer() {
	local novo_nome
	find . -name "*$1*" | while read; do
		novo_nome="${REPLY// /_}"
		mv "$REPLY" "$novo_nome"
	done;
}
export -f chili-toSpaceFixer
alias toSpaceFixer=chili-toSpaceFixer

#xdel() {
#   [ "$1" ] || {
#		echo "   Uso: xdel <file>"
#		echo "        xdel \*.log"
#		echo "        xdel '*.log'"
#		return 1
#	}
##	sudo find .	-iname '*'"$1"'*'| xargs rm --force --verbose
#	sudo find .	-iname "$1" | xargs rm --force --verbose
#}

xdel() {
	local filepath=$1
	local num_arquivos=$2
	local intervalo=$3
	local resultado

	[ "$filepath" ] || {
		echo "   Uso: xdel <file>"
		echo "        xdel \*.log"
		echo "        xdel '*.log'"
		return 1
	}

	local find_command="sudo find . -iname '$filepath'"

	if [[ -n "$intervalo" ]]; then
		find_command+=" -mmin -${intervalo}"
	fi

#	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
#	find_command+=" -printf \"$format_string\" | sort"

	if [[ -n "$num_arquivos" ]]; then
		find_command+=" | tail -n $num_arquivos"
	fi

	find_command+=" | xargs rm --verbose --force"

	resultado=$(eval "$find_command")
	echo "=== Resultado ==="
	echo "$resultado" | nl
	echo "=== Parâmetros informados ==="
	echo "Searching              : ${green}($find_command)${reset}"
	echo "Padrão             (\$1): ${filepath}"
	echo "Número de arquivos (\$2): ${num_arquivos:-Todos}"
	echo "Intervalo de tempo (\$3): ${intervalo:-Todos} (minutos)"
}

lsa() {
	echo -n ${orange}
#	ls -l | awk '/^-/ {print $9}'
#	ls -la | grep -v "^d"
	find . -type f -exec basename {} \;
}

lsd() {
	#	printf "%s\n" "${orange}"
	#	ls -l | awk '/^d/ {print $9}'
	#	ls -la | grep "^d"
	#	find . -type d
	#	printf "%s" "${reset}"
	ls -ld --color=always -- */ 2>/dev/null
}

chili-session() {
	local _session="$XDG_SESSION_TYPE"
	echo "Desktop: $XDG_CURRENT_DESKTOP"
	echo "Session: $_session"
}

setkeyboardX() {
#	local _session=$(loginctl show-session "$XDG_SESSION_ID" -p Type --value)
	local _session="$XDG_SESSION_TYPE"
	echo "Desktop: $XDG_CURRENT_DESKTOP"
	echo "Session: $_session"

	case $_session in
		x11) setxkbmap -model abnt2 -layout br -variant abnt2 ;;
		wayland) sudo localectl set-x11-keymap br abnt2 ;;
	esac
#	sudo setxkbmap -query
#	sudo setxkbmap -print -verbose 10
	localectl status
}

rsync-fs() {
	_source=$1
	_target=$2

	rsync \
		--human-readable \
		--archive \
		--delete-delay \
		--verbose \
		--recursive \
		--links \
		--perms \
		--times \
		--partial \
		--compress \
		--progress \
		--hard-links \
		--exclude 'proc' \
		--exclude 'sys' \
		--exclude 'dev' \
		--exclude 'vg' \
		$_source \
		$_target
}
#     --delete-delay    \
#     --delay-updates   \

prompt_git() {
	local s=''
	local branchName=''

	# Check if the current directory is in a Git repository.
	if [ "$(
		git rev-parse --is-inside-work-tree &>/dev/null
		echo "${?}"
	)" == '0' ]; then
		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" == 'false' ]; then
			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null
			# Check for uncommitted changes in the index.
			if ! git diff --quiet --ignore-submodules --cached; then
				s+='+'
			fi
			# Check for unstaged changes.
			if ! git diff-files --quiet --ignore-submodules --; then
				s+='!'
			fi
			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?'
			fi
			# Check for stashed files.
			if git rev-parse --verify refs/stash &>/dev/null; then
				s+='$'
			fi
		fi

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2>/dev/null ||
			git rev-parse --short HEAD 2>/dev/null ||
			echo '(unknown)')"
		[ -n "${s}" ] && s=" [${s}]"
		echo -e "${1}${branchName}${2}${s}"
	else
		return
	fi
}

chili-pkgorfao() {
	local cOldDir=$PWD
	local nc=0

	[[ -f '/etc/fetch/fetch.conf' ]] && source '/etc/fetch/fetch.conf'
	pushd "$LOCALDIR/packages/" >/dev/null 2>&- || return

	for cdir in {a..z}; do
		cOldDir=$PWD
		cd $cdir >/dev/null 2>&- || return 1
		pkgs=$(echo -- *.zst)
		for i in $pkgs; do
			[[ -e "$i.desc" ]] || {
				((++nc))
				printf "%s\n" "$LOCALDIR/packages/$cdir/$i"
			}
		done
		cd "$cOldDir" >/dev/null 2>&- || return
	done
	popd >/dev/null 2>&- || return
	return $nc
}
export -f chili-pkgorfao
alias pkgorfao=chili-pkgorfao

chili-filehoracerta() {
	export SOURCE_DATE_EPOCH
	SOURCE_DATE_EPOCH=$(date +%s)
	find . -exec touch -h -d @$SOURCE_DATE_EPOCH {} +
}
export -f chili-filehoracerta
alias filehoracerta=chili-filehoracerta

horacerta() {	sudo ntpd -q -g; 	sudo hwclock --systohc; }
export -f horacerta

GREP_OPTIONS() { GREP_OPTIONS='--color=auto'; }
export -f GREP_OPTIONS

printeradd() { addprinter "$@"; }
export -f printeradd

addprinter() {
	sudo cupsctl --remote-any --share-printers
	sudo lpadmin -p LPT1 -E -v ipp://10.0.0.99/p1 -L "EPSON LX300 em Atendimento" -m everywhere -o print-is-shared=true -u allow:all
	#	sudo lpadmin -p LPT1 -E -v socket://10.0.0.99 -m everywhere -o print-is-shared=true -u allow:all
	sudo lpadmin -p LPT2 -E -v ipp://10.0.0.99/p2 -m everywhere -o print-is-shared=true -u allow:all
	sudo lpadmin -p LPT3 -E -v ipp://10.0.0.99/p3 -m everywhere -o print-is-shared=true -u allow:all
	sudo lpadmin -p SAMSUNG2070 -E -v ipp://10.0.0.77/ipp/print -m everywhere -o print-is-shared=true -u allow:all
	#	sudo lpadmin -p DeskJet -E -v parallel:/dev/lp0 -m everywhere -u allow:all
	#	sudo lpadmin -p DotMatrix -E -m epson9.ppd -v serial:/dev/ttyS0?baud=9600+size=8+parity=none+flow=soft -u allow:all
	#	sudo lpadmin -p PRINTERNAME -E -v smb://10.0.0.68/P1 -L "LOCATION" -o auth-info-required=negotiate -u allow:all
	sudo lpadmin -d LPT1
}
export -f addprinter

mostra() {
	sudo lpstat -s
	sudo lpq
}
export -f mostra

cancela() {
	sudo systemctl stop lprng
	sudo rm -rf /var/spool/lpd
	sudo rm /home/sci/LPT*
	sudo rm /home/sci/COM*
	sudo checkpc -f
	sudo systemctl start lprng
	sudo lprm
	sudo systemctl status lprng
}
export -f cancela

direxist() {
	dir="$1"
	if [[ -e "$dir" ]]; then
		echo "o diretório {$dir} existe"
	else
		echo "o diretório {$dir} não existe"
	fi
}
export -f direxist

email() {
	echo "CORPO" | mail -s "Subject" -A /etc/bashrc vcatafesta@balcao
}
export -f email

modo() {
	echo -n 'atual mode : '
	if ! systemctl get-default; then
		if [[ $1 = @(grafico|on|g|graphical) ]]; then
			systemctl set-default graphical.target
		else
			systemctl set-default multi-user.target
		fi
	fi
	echo -n 'new mode   : '
	systemctl get-default
}
export -f modo

sshsemsenha() {
	USUARIO=${USER}
#	SERV="10.0.0.72"
	SERV=$1
	echo $1

	ssh-keygen -t rsa
#	scp /home/$USER/.ssh/id_rsa.pub $USER@$SERV:/tmp
#	scp ~/.ssh/id_rsa.pub $USUARIOR@$SERV:/tmp
#	ssh $USUARIO@$SERV
#	cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
	ssh-copy-id -p 22 -f -i ~/.ssh/id_rsa.pub $SERV
}
export -f sshsemsenha

sshsemsenhahs() {
	USUARIO=u356719782
	REMOTO=185.211.7.40
	echo $1

#	ssh-keygen -t rsa
	ssh-copy-id -p 65002 -f -i ~/.ssh/id_rsa.pub $USUARIO@$REMOTO
}

sshsemsenhadito() {
	USUARIO=vcatafesta
	REMOTO=200.98.137.64
	echo $1

	#	ssh-keygen -t rsa
	ssh-copy-id -p 22 -f -i ~/.ssh/id_rsa.pub $USUARIO@$REMOTO
}

xdel1() {
	#!/usr/bin/env bash
	#find -name $1 | xargs rm -v
	#!/bin/bash
	arr=$(find . -iname "${1}")

	echo "${arr[*]}"
	for i in "${arr[@]}"; do
		rm -f $i
	done
}

chili-ramdisk() {
	#!/bin/bash
	mkdir /mnt/ramdisk
	mount -t tmpfs -o size=4096M tmpfs /mnt/ramdisk
	#fstab
	#tmpfs       /mnt/ramdisk tmpfs   nodev,nosuid,noexec,nodiratime,size=512M   0 0
}

chili-qemuimg() {
	if test $# -ge 1; then
		#qemu-system-x86_64 -cdrom tails-amd64-3.1.iso
		qemu-system-x86_64 -no-fd-bootchk -nographic $1
	else
		cat <<EOF
usage:
	chili-qemuimg <file>
EOF
	fi
}

chili-qemu() {
	#!/bin/bash
	#qemu-system-x86_64 -cdrom tails-amd64-3.1.iso
	qemu-system-x86_64 -m 4096 -no-fd-bootchk -nographic -cdrom $1
}

chili-qemux() {
	#!/bin/bash
	#qemu-system-x86_64 -cdrom tails-amd64-3.1.iso
	qemu-system-x86_64 -curses -no-fd-bootchk -nographic -cdrom $1
}

chili-qemukvm() {
	#qemu-system-x86_64 -enable-kvm -m 2048 -name 'CHILI OS' -boot d -hda ubuntu17.qcow2 -cdrom $1
	qemu-system-x86_64 -enable-kvm -m 2048 -name 'CHILI OS' -boot -cdrom $1
}

chili-qemurunraw() {
	if test $# -ge 1; then
		#		qemu-system-x86_64 -m 4096 -display curses -no-fd-bootchk -no-reboot -drive format=raw,file=$1
		#		qemu-system-x86_64 -m 4096 -display curses -no-fd-bootchk -drive format=raw,file=$1
		qemu-system-x86_64 \
			-display curses \
			-no-fd-bootchk \
			-drive format=raw,file=$1 \
			-m "size=8128,slots=0,maxmem=$((8128 * 1024 * 1024))"
	else
		cat <<EOF
usage:
	chili-qemurunraw file.img
EOF
	fi
}
#			-k br-abnt2
#        -smp 18 \

chili-create-img-truncate() {
	local image=$1
	local type=$2
	local size=$3

	if test $# -ge 3; then
		truncate $image --size size
		qemu-img info $image
	else
		cat <<EOF
usage:
   chili-create-img-truncate <filename> <size>
   ===========================================
   'size' is the disk image size in bytes. Optional suffixes
   'k' or 'K' (kilobyte, 1024),
   'M' (megabyte, 1024k),
   'G' (gigabyte, 1024M),
   'T' (terabyte, 1024G),
   'P' (petabyte, 1024T) and
   'E' (exabyte, 1024P)

   chili-create-img-truncate chili.img 10G
EOF
	fi
}

chili-qemu-img-create() {
	local image=$1
	local type=$2
	local size=$3

	if test $# -ge 3; then
		qemu-img create $image -f $type $size
		qemu-img info $image
	else
		cat <<EOF
usage:
	chili-qemu-img-create filename type size
	=========================================
	${pink}Raw${reset} 		Raw is default format if no specific format is specified while creating disk images.
	Qcow2		Qcow2 is opensource format developed against Vmdk and Vdi. Qcow2 provides features like compression,
	Qed		Qed is a disk format provided by Qemu. It provides support for overlay and sparse images. Performance of Qed is better than Qcow2 .
	Qcow		Qcow is predecessor of the Qcow2.
	Vmdk		Vmdk is default and popular disk image format developed and user by VMware.
	Vdi		Vdi is popular format developed Virtual Box. It has similar features to the Vmdk and Qcow2
	Vpc		Vps is format used by first generation Microsoft Virtualization tool named Virtual PC. It is not actively developed right now.
	=========================================
	'size' is the disk image size in bytes. Optional suffixes
	'k' or 'K' (kilobyte, 1024),
	'M' (megabyte, 1024k),
	'G' (gigabyte, 1024M),
	'T' (terabyte, 1024G),
	'P' (petabyte, 1024T) and
	'E' (exabyte, 1024P)

	chili-qemu-img-create chili.img raw 10M
	chili-qemu-img-create debian.qcow2 qcow2 10G
EOF
	fi
}

chili-qemu-img-convert-raw-to-qcow2() {
	if test $# -ge 2; then
		qemu-img convert -f raw $1 -O qcow2 $2
	else
		cat <<EOF
usage:
	chili-qemu-img-convert-img-to-qcow2 hda0.img hda1.qcow2
EOF
	fi
}

chili-qemu-img-convert-vdi-to-raw() {
	if test $# -ge 2; then
		qemu-img convert -f vdi -O raw $1 $2
	else
		cat <<EOF
usage:
	chili-qemu-img-convert-vdi-to-raw image.vdi image.img
EOF
	fi
}

chili-qemurunqcow2() {
	#		-hda $1				\
	qemu-system-x86_64 \
		-drive file=$1,if=none,id=disk1 \
		-device ide-hd,drive=disk1,bootindex=1 \
		-m "size=8192,slots=0,maxmem=$((8192 * 1024 * 1024))" \
		-k br-abnt2 \
		-vga virtio \
		-smp 16 \
		-machine type=q35,smm=on,accel=kvm,usb=on \
		-enable-kvm
}

chili-qemurunuefi() {
	local ovmf_code
	local ovmf_vars
	local working_dir
	image=$1

	if test $# -ge 1; then
		ovmf_code='/usr/share/edk2-ovmf/x64/OVMF_CODE.fd'
		ovmf_vars='/usr/share/edk2-ovmf/x64/OVMF_VARS.fd'
		working_dir="$(mktemp -dt run_archiso.XXXXXXXXXX)"

		sudo qemu-system-x86_64 \
			-enable-kvm \
			-cpu host \
			-smp 36 \
			-m 8192 \
			-drive file=${image},if=virtio,format=raw \
			-hda /archlive/qemu/hda.img \
			-hdb /archlive/qemu/hdb.img \
			-hdc /archlive/qemu/hdc.img \
			-hdd /archlive/qemu/hdd.img \
			-m "size=8128,slots=0,maxmem=$((8128 * 1024 * 1024))" \
			-device virtio-net-pci,netdev=net0 -netdev user,id=net0 \
			-vga virtio \
			-display gtk \
			-device intel-hda \
			-audiodev pa,id=snd0,server=localhost \
			-device hda-output,audiodev=snd0 \
			-net nic,model=virtio \
			-net user \
			-drive if=pflash,format=raw,unit=0,file=${ovmf_code},read-only=off \
			-drive if=pflash,format=raw,unit=1,file=${ovmf_vars} \
			-enable-kvm \
			-serial stdio
	else
		cat <<EOF
usage:
	chili-qemurunuefi file.img
	chili-qemurunuefi file.qcow2
EOF
	fi
}

frfloppy() {
    if test $# -ge 1; then
        IMG="$1"
        [[ -f "$IMG" ]] || { echo "Imagem $IMG não encontrada!"; return; }
        sudo qemu-system-i386 \
            -drive file=$IMG,format=raw,index=0,if=floppy
			-drive file=/archlive/qemu/hda.img,format=raw \
			-name frfloppy,process=archiso_0 \
			-device virtio-scsi-pci,id=scsi0 \
            -machine accel=kvm \
            -cpu host \
            -smp "$(nproc)" \
            -m 4G \
            -machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0 \
            "${qemu_options[@]}" \
            -serial stdio
    else
        cat <<EOF
usage:
   frfloppy file.img
   frfloppy file.qcow2
EOF
    fi
}

#qemu-system-x86_64 -monitor stdio -smp "$(nproc)" -k pt-br -machine accel=kvm -m 4096 -cdrom "$1" -hda "/home/vcatafesta/.aqemu/Linux_2.6_HDA.img" -boot once=d,menu=off -net nic -net user -rtc base=localtime -name "runcdrom"
chili-qemurunfile() {
	declare -a qemu_options=()

	if test $# -ge 1; then
		[[ -e "$1" ]] || { echo "Imagem/Device $1 não encontrada!"; return; }
#		[[ -r "$1" ]] || { echo "Imagem/Device $1 sem permissão de leitura!"; return; }
		qemu_options+=(-monitor stdio)
		qemu_options+=(-no-fd-bootchk)
		qemu_options+=(-machine accel=kvm)
		qemu_options+=(-cpu host)
		qemu_options+=(-smp "$(nproc)")
		qemu_options+=(-m 8G)
		qemu_options+=(-k pt-br)
		qemu_options+=(-drive file=${1},if=none,id=disk1,format=raw)
		qemu_options+=(-device ide-hd,drive=disk1,bootindex=1)
		qemu_options+=(-drive file=/archlive/qemu/hda.img,format=raw)
		qemu_options+=(-name "chili-qemurunfile $*",process=archiso_0)
		qemu_options+=(-device virtio-scsi-pci,id=scsi0)
		qemu_options+=(-netdev user,id=net0)
		qemu_options+=(-device e1000,netdev=net0)
#		qemu_options+=(-audiodev pa,id=snd0)
#		qemu_options+=(-audiodev pipewire,id=snd0)
		qemu_options+=(-audiodev alsa,id=snd0)
#        qemu_options+=(-device hda-duplex,audiodev=snd0,mixer=off)
#        qemu_options+=(-rtc base=localtime,clock=host)
        qemu_options+=(-device ich9-intel-hda)
		qemu_options+=(-device hda-output,audiodev=snd0)
#		qemu_options+=(-global ICH9-LPC.disable_s3=1)
		qemu_options+=(-machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0)
		sudo qemu-system-x86_64 "${qemu_options[@]}"
	else
		cat <<EOF
usage:
   chili-qemurunfile file.img
   chili-qemurunfile file.qcow2
EOF
	fi
}

#    qemu_options+=(-device hda-duplex,audiodev=snd0,mixer=off)
#    qemu_options+=(-rtc base=localtime,clock=host)
#    qemu_options+=(-device ich9-intel-hda)
#    qemu_options+=(-device hda-output,audiodev=snd0)
#    qemu_options+=(-global ICH9-LPC.disable_s3=1)
#    qemu_options+=(-machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0)
#    qemu_options+=(-serial stdio)
#
#
#
#
#			-drive file=~/archlive/qemu/hdb.img,format=raw \
#			-drive file=~/archlive/qemu/hdc.img,format=raw \
#			-drive file=~/archlive/qemu/hdd.img,format=raw \
#			-name 'Chili' \
#			-audiodev alsa,id=snd0 \
#		-audiodev pa,id=snd0,server=localhost \
#		-vga qxl \
#       -display curses    \
#       -vga virtio \
#       -vga virtio     \
#       -display "sdl" \
#       -device qxl-vga,vgamem_mb=128 \
#       -k br-abnt2 \
#       -net nic,model=virtio -net bridge,br=br0 \
#       -device virtio-net-pci,romfile=,netdev=net0\
#       -netdev user,id=net0,hostfwd=tcp::60022-:22 \

chili-qemufilerun() { chili-qemurunfile $@; }
filerun() { chili-qemurunfile $@; }
fr() { chili-qemurunfile "$@"; }
fru() { chili-qemurunuefi $@; }
frr() { chili-qemurunimg $@; }
fileinfo() { for i in "${@}"; do qemu-img info $i; echo; done; }
export -f fr
export -f chili-qemurunfile

#qemu-system-x86_64 -net nic,model=virtio -net bridge,br=br0 -hda void.img

#if [[ ${1: -4} == ".iso" ]]; then

chili-runcdrom() {
	if test $# -ge 1; then
		sudo qemu-system-x86_64 \
			-no-fd-bootchk \
			-machine accel=kvm \
			-cpu host \
			-smp "$(nproc)" \
			-m 4G \
			-boot d -cdrom ${1} \
			-drive file=/archlive/qemu/hda.img,format=raw \
			-name "frcdrom $*",process=archiso_0 \
			-device virtio-scsi-pci,id=scsi0 \
			-netdev user,id=net0 \
			-device e1000,netdev=net0 \
			-audiodev alsa,id=snd0 \
			-device ich9-intel-hda \
			-device hda-output,audiodev=snd0 \
			-global ICH9-LPC.disable_s3=1 \
			-machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0 \
			"${qemu_options[@]}" \
			-serial stdio
	else
		cat <<EOF
usage:
   chili-runcdrom file.iso
EOF
	fi
}


frc() {
	if test $# -ge 1; then
		sudo qemu-system-x86_64 \
			-no-fd-bootchk \
			-drive file=${1},if=none,id=disk1 \
			-device ide-hd,drive=disk1,bootindex=1 \
			-hda /archlive/qemu/hda.img \
			-hdb /archlive/qemu/hdb.img \
			-hdc /archlive/qemu/hdc.img \
			-hdd /archlive/qemu/hdd.img \
			-m "size=8128,slots=0,maxmem=$((8128 * 1024 * 1024))" \
			-name archiso,process=archiso_0 \
			-device virtio-scsi-pci,id=scsi0 \
			-audiodev pa,id=snd0,server=localhost \
			-device ich9-intel-hda \
			-device hda-output,audiodev=snd0 \
			-global ICH9-LPC.disable_s3=1 \
			-machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0 \
			-display curses \
			"${qemu_options[@]}" \
			-smp 36 \
			-enable-kvm \
			-serial stdio
	else
		cat <<EOF
usage:
	frc file.img
	frc file.qcow2
EOF
	fi
}
#        -device virtio-net-pci,romfile=,netdev=net0 -netdev user,id=net0,hostfwd=tcp::60022-:22 \

frc_old() {
	if test $# -ge 1; then
		qemu-system-x86_64 \
			-display curses \
			-m "size=8128,slots=0,maxmem=$((8128 * 1024 * 1024))" \
			-hda ${1} \
			-smp 36 \
			-enable-kvm
	else
		cat <<EOF
usage:
	rfn hda.qcow2
	rfn hdb.img
EOF
	fi
}

frc_new() {
	# Verificar se o caminho para a imagem do disco foi fornecido
	if [ -z "$1" ]; then
		echo "Você precisa fornecer o caminho para a imagem do disco como argumento."
		echo "Exemplo: $0 <caminho_para_imagem_hd>"
		exit 1
	fi

	# Verificar se o arquivo de imagem do disco existe
	if [ ! -f "$1" ]; then
		echo "O arquivo de imagem do disco não existe: $1"
		exit 1
	fi

	# Executar o QEMU com ncurses
	sudo qemu-system-x86_64 \
		-drive file=${1},if=none,id=disk1,format=raw -device ide-hd,drive=disk1 \
		-m 8G \
		-device virtio-scsi-pci,id=scsi0 \
		-audiodev pa,id=snd0,server=localhost \
		-device ich9-intel-hda -device hda-output,audiodev=snd0 \
		-machine type=q35,accel=kvm,usb=on,pcspk-audiodev=snd0,smm=on \
		-smp 36 \
		-enable-kvm
	#	-nographic
	#	-display curses \

	#sudo qemu-system-x86_64 \
	#  -drive file=${1},format=raw \
	#  -display curses \
	#  -smp 36 \
	#  -enable-kvm \
	#  -nographic
}

rf() {
	if test $# -ge 1; then
		qemu-system-x86_64 \
			-m "size=8128,slots=0,maxmem=$((8128 * 1024 * 1024))" \
			-hda ${1} \
			-smp 18 \
			-enable-kvm
	else
		cat <<EOF
usage:
	rf hda.qcow2
	rf hdb.img
EOF
	fi
}

chili-qemurunimg() {
	if test $# -ge 1; then
		qemu-system-x86_64 \
			-drive file=${1},format=raw,if=none,id=disk1 \
			-device ide-hd,drive=disk1,bootindex=1 \
			-m "size=8128,slots=0,maxmem=$((8128 * 1024 * 1024))" \
			-k br-abnt2 \
			-name archiso,process=archiso_0 \
			-device virtio-scsi-pci,id=scsi0 \
			-display "sdl" \
			-vga virtio \
			-audiodev pa,id=snd0,server=localhost \
			-device ich9-intel-hda \
			-device hda-output,audiodev=snd0 \
			-device virtio-net-pci,romfile=,netdev=net0 -netdev user,id=net0,hostfwd=tcp::60022-:22 \
			-machine type=q35,smm=on,accel=kvm,usb=on,pcspk-audiodev=snd0 \
			-global ICH9-LPC.disable_s3=1 \
			-smp 16 \
			-enable-kvm \
			"${qemu_options[@]}" \
			-serial stdio
	else
		cat <<EOF
usage:
	qemurun hda.img
	qemurun hdb.img
EOF
	fi
}

chili-qemu-dos() {
	#!/bin/bash
	#qemu-img create -f qcow2 /home/vcatafesta/Downloads/qemu/dos7.qcow2 1G
	#qemu-img info /home/vcatafesta/Downloads/qemu/dos7.qcow2
	#qemu-system-x86_64 -hda dos7.qcow2 -cdrom dos71cd.iso -boot d
	#qemu-system-x86_64 -enable-kvm -m 2048 -name 'UBUNTU 17.10' -boot d -hda ubuntu17.qcow2 -cdrom ubuntu-17.10-desktop-amd64.iso
	#qemu-system-x86_64 -hda /home/vcatafesta/Downloads/qemu/dos7.qcow2
	#qemu-system-x86_64 -enable-kvm -m 1 -name 'Microsoft MSDO 7.1' -hda /home/vcatafesta/Downloads/qemu/dos7.qcow2
	qemu-system-x86_64 -m 128 -name 'Microsoft MSDO 7.1' -hda /home/vcatafesta/Downloads/qemu/dos7.qcow2
}

criartap() {
	#criar ponte
	modprobe tun
	echo "tun" | sudo tee -a /etc/modules-load.d/modules.conf
	ip tuntap add tap0 mode tap
	ip link set tap0 up
	ifconfig tap0 0.0.0.0 promisc up
	ifconfig enp6s0 0.0.0.0 promisc up
	brctl addbr br0
	brctl addif br0 tap0
	brctl show
	ifconfig br0 up
#	ifconfig br0 10.7.7.66/24
	ip link show
}

criartapOLD() {
#	apt-get install uml-utilities
	#criar ponte
	modprobe tun
	tunctl -t tap0
	ifconfig tap0 0.0.0.0 promisc up
	ifconfig enp6s0 0.0.0.0 promisc up
	brctl addbr br0
	brctl addif br0 tap0
#	brctl addif br0 enp3s0
	brctl show
	ifconfig br0 up
	ifconfig br0 10.7.7.66/24
}

vlanubnt() {
	#telnet 10.0.0.51
	#ssh 10.0.0.51
	vconfig add br0 5
	vconfig add br0 10
	ifconfig br0.5 x.x.x.x netmask x.x.x.x up
	ifconfig br0.10 x.x.x.x netmask x.x.x.x up
}

chili-videoultrahd() {
	sudo xrandr --newmode "2560x1080_60.00" 230.00 2560 2720 2992 3424 1080 1083 1093 1120 -hsync +vsync
	sudo xrandr --addmode HDMI-0 2560x1080_60.00
}

tms() {
#	sudo journalctl -f
	sudo dmesg -w -T -x
}

sr() {
	sudo systemctl restart $1
	sudo systemctl status $1
}

st() {
	sudo systemctl stop $1
	sudo systemctl status $1
}

lsvideo() {
	echo -e "1. xrandr"
	sudo xrandr
	echo
	echo -e "2. grep -i chipset /var/log/Xorg.0.log"
	sudo grep -i chipset /var/log/Xorg.0.log
	echo
	echo -e "3. lshw -C video"
	sudo lshw -C video
	echo
	echo -e "4. sudo lspci -k | grep -A 2 -E '(VGA|3D)'"
	sudo lspci -k | grep -A 2 -E '(VGA|3D)'
	echo -e '5. sudo lspci -nnkd::0300'
	sudo lspci -nnkd::0300
}
export -f lsvideo

ddel3() {
	find . -iname $1 -print0 | xargs rm --verbose
}
export -f ddel3

stsmb() {
	systemctl restart smbd
	systemctl restart nmbd
	systemctl status smbd
}
export -f stsmb

bindmnt() {
	for i in /dev /dev/pts /proc /sys /run; do
		sudo mkdir -pv $1/$i
		sudo mount -v -B $i $1/$i
	done
}
export -f bindmnt

chroot-lfs() {
	#export LFS=$1
	export LFS=/mnt/lfs
	info $LFS
	mount -v -t ext4 /dev/sda7 $LFS
	mkdir -pv $LFS/{dev,proc,sys,run}

	#Creating Initial Device Nodes
	mknod -m 600 $LFS/dev/console c 5 1
	mknod -m 666 $LFS/dev/null c 1 3

	#Mounting and Populating /dev
	mount -v --bind /dev $LFS/dev
	#Mounting Virtual Kernel File Systems
	mount -v --bind /dev/pts $LFS/dev/pts
	mount -vt proc proc $LFS/proc
	mount -vt sysfs sysfs $LFS/sys
	mount -vt tmpfs tmpfs $LFS/run

	if [ -h $LFS/dev/shm ]; then
		mkdir -pv "$LFS/$(readlink $LFS/dev/shm)"
	fi

	#Entering the Chroot Environment
	chroot "$LFS" /usr/bin/env -i \
		HOME=/root \
		TERM="$TERM" \
		PS1='(lfs chroot) \u:\w\$ ' \
		PATH=/usr/bin:/usr/sbin \
		/bin/bash --login
}

chrootmount() {
	sudo mount "$@"
}

chilichroot() {
	if test $# -ge 1; then
		CHROOTDIR="$1"
		[[ ${CHROOTDIR} = '.' ]] && CHROOTDIR=${PWD}
		log_wait_msg "Generate dirs in $CHROOTDIR"
		for i in /proc /sys /dev /dev/pts /dev/shm /run /tmp; do
			mkdir -pv ${CHROOTDIR}${i}
		done
		log_wait_msg "Mounting on $CHROOTDIR"
		chrootmount proc "${CHROOTDIR}/proc" -t proc -o nosuid,noexec,nodev &&
			chrootmount sys "${CHROOTDIR}/sys" -t sysfs -o nosuid,noexec,nodev,ro &&
			chrootmount udev "${CHROOTDIR}/dev" -t devtmpfs -o mode=0755,nosuid &&
			chrootmount devpts "${CHROOTDIR}/dev/pts" -t devpts -o mode=0620,gid=5,nosuid,noexec &&
			chrootmount shm "${CHROOTDIR}/dev/shm" -t tmpfs -o mode=1777,nosuid,nodev &&
			chrootmount /run "${CHROOTDIR}/run" --bind &&
			chrootmount tmp "${CHROOTDIR}/tmp" -t tmpfs -o mode=1777,strictatime,nodev,nosuid
		log_wait_msg "Iniciando CHROOT at $CHROOTDIR"
		sudo chroot ${CHROOTDIR}
		log_wait_msg "Unbinding $CHROOTDIR"
		sudo umount -r "${CHROOTDIR}/proc"
		sudo umount -r "${CHROOTDIR}/sys"
		sudo umount -r "${CHROOTDIR}/dev/pts"
		sudo umount -r "${CHROOTDIR}/dev/shm"
		sudo umount -r "${CHROOTDIR}/dev"
		sudo umount -r "${CHROOTDIR}/run"
		sudo umount -r "${CHROOTDIR}/tmp"
		#sudo grub-install /dev/sdb
		#sudo update-grub /dev/sdb
	else
		printf "%s\n" "ERROR: No chroot directory specified"
	fi
}

chili-conf() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--mandir=/usr/man
	sudo make
}

chili-conflib() {
	./configure --prefix=/usr --disable-static &&
		sudo make
}

net() {
	log_info_msg "Iniciando rede"
	sudo systemctl stop NetworkManager
	ip addr add 10.0.0.67/21 dev enp0s3
	ip route add default via 10.0.0.254 dev enp0s3
	ip route list
	evaluate_retval
}

netsysv() {
	log_info_msg "Iniciando rede"
	/etc/init.d/networkmanager stop
	ip addr add 10.0.0.67/21 dev enp0s3
	ip route add default via 10.0.0.254 dev enp0s3
	ip route list
	evaluate_retval
}
export -f netsysv

mput() {
	for x in {a..z}; do
		log_info_msg "Trabalhando em ${x}"
		echo
		git add ${x}* >/dev/null 2>&1
		git commit -m "upgrade" >/dev/null 2>&1
		git push >/dev/null 2>&1
		evaluate_retval
	done
}
export -f mput

gbare() {
	log_wait_msg "${red}Iniciando git push ${reset}"
	sudo git config credential.helper store
	git init
	git clone --bare . /mnt/pendrive/projeto.git
	git remote add origin /mnt/pendrive/projeto.git
	touch qualquermerda.txt
	git add -A
	git commit -m "$(date) Vilmar Catafesta (vcatafesta@gmail.com)"
	git push origin master
}
export -f gbare

grmbranch() {
	local str="$*"
	local branch="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)

	if test $# -eq 0; then
		echo "uso: ${cyan}gmbranch <branch> [--remote]${reset}"
		echo "     ${cyan}gmbranch testing-2024-08-16_21-08 --remote${reset} #remover do remoto também"
		echo "     ${cyan}gmbranch testing-2024-08-16_21-08${reset}          #remove somente local"
		echo "branchs locais:"
		git branch
		return 1
	fi

	if [[ -z "$branch" ]] ;then
		echo "${red}error: Deu ruim para o branch ${yellow}'${branch}'${red}, não é valido'${reset}"
		git branch
	  return 1
	fi
	# Remover um branch local:
	# git branch -d "$branch"

	if [[ $str =~ '--remote' ]]; then
		# Remover um branch remoto:
		git push origin --delete "$branch"
	fi
	# Se você deseja forçar a remoção de um branch que ainda não foi mesclado, use:
	git branch -D "$branch"

	#limpar as referências locais para branches remotos excluídos
	git fetch --prune
	git branch
	return $?
}
export -f grmbranch

gmerge() {
	local branch="$1"
	local cabec="$2"		# ex: weblib.sh: sh_webapp_backup - Erro ao fazer o backup
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local commit

	if test $# -eq 0; then
		echo "uso: ${cyan}gmerge <branch>${reset}"
		echo "     ${cyan}gmerge testing-2024-08-16_21-08${reset}  #mescla com main local"
		echo "branchs locais:"
		git branch
		return 1
	fi

	if [[ -z "$branch" ]] ;then
		echo "${red}error: Deu ruim para o branch ${yellow}'${branch}'${red}, não é valido'${reset}"
		git branch
	  return 1
	fi

	# Verificar se o branch local já existe
	if git show-ref --quiet refs/heads/$branch; then
	  echo "Branch local '$branch_name' já existe."
	else
	  echo "Branch local '$branch_name' não existe. Criando..."
	  git checkout -b $branch
	  echo "Branch '$branch_name' criado e alterado para o novo branch."
	fi

#	# Verificar se o branch remoto já existe
#	if git ls-remote --heads origin $branch | grep -q 'refs/heads/'$branch; then
#	  echo "Branch remoto '$branch' já existe."
#	else
#	  echo "Branch remoto '$branch' não existe. Enviando o novo branch para o remoto..."
#	  git push origin $branch_name
#	  echo "Branch '$branch' enviado para o remoto."
#	fi

	log_wait_msg "${red}Iniciando git commit no branch ${yellow}'main' ${reset}"
	#alterne para ele:
	git checkout main
	#export GIT_CURL_VERBOSE=1
	sudo git config --global http.postBuffer 524288000
	sudo git config credential.helper store
	#Faça as alterações desejadas nos arquivos e, em seguida, adicione-as e comite-as:
	git add -A
	if [[ -z "$cabec" ]]; then
		commit="$(date) Vilmar Catafesta (vcatafesta@gmail.com)"
	else
		commit="$cabec"
	fi
	git commit -m "$commit"

	#Envie as alterações do main para o repositório remoto:
	git push origin main

	# Mude para o branch ${branch}
	git checkout "$branch"

	#Para trazer as alterações que você acabou de fazer no main para o branch ${branch}, execute:
	git merge main

	#Se houver conflitos durante o merge, o Git solicitará que você resolva esses conflitos.
	# Edite os arquivos conflitantes, marque-os como resolvidos e finalize o merge:
	git add -A
	git commit -m "$commit"

	#Envie o branch atualizado para o repositório remoto
	git push origin "$branch"

	#Por fim, verifique que ambos os branches foram enviados corretamente ao repositório remoto:
	git status

	#voltar ao branch main
	git checkout main
	return $?
}
export -f gmerge

gcommit() {
	local cabec="$1"		# ex: weblib.sh: sh_webapp_backup - Erro ao fazer o backup
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	log_wait_msg "${red}Iniciando commit in ${yellow}${mainbranch}'${reset}"
	#export GIT_CURL_VERBOSE=1
	git checkout "$mainbranch"
	git config --global http.postBuffer 524288000
	git config credential.helper store
	git add -A
	if [[ -z "$cabec" ]]; then
		git commit -m "$(date) Vilmar Catafesta (vcatafesta@gmail.com)"
	else
		git commit -m "$cabec"
	fi
	git log origin/$mainbranch..$mainbranch
	return 0
}
export -f gcommit

gpull() {
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)

	log_wait_msg "${blue}Iniciando git pull ${reset}"
	git config credential.helper store
	#	sudo git config pull.ff only
	#	sudo git pull
	git pull --no-ff
}
export -f gpull

gpush() {
	local branch="$1"		# ex: weblib.sh: sh_webapp_backup - Erro ao fazer o backup
	local cabec="$2"		# ex: weblib.sh: sh_webapp_backup - Erro ao fazer o backup
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	log_wait_msg "${red}Iniciando git push in ${yellow}${mainbranch}'${reset}"
	#export GIT_CURL_VERBOSE=1
	git checkout "$mainbranch"
	git config --global http.postBuffer 524288000
	git config credential.helper store

#	git pull origin "$mainbranch"
	git add -A
	if [[ -z "$cabec" ]]; then
		git commit -m "$(date) Vilmar Catafesta (vcatafesta@gmail.com)"
	else
		git commit -m "$cabec"
	fi
	if [[ -n "$branch" ]]; then
#		gitbranch "$branch"
		if ! gbranch "$branch"; then
			git branch
			return 1
		fi
	fi
	git push --force
	git log origin/$mainbranch..$mainbranch
	return 0
}
export -f gpush

gaddupstream() {
	local remote="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	if test $# -eq 0; then
		echo "uso: ${cyan}gaddupstream <repositorio>${reset}"
		echo "     ${cyan}gaddupstream https://github.com/biglinux/big-store${reset}"
		echo "branchs locais:"
		git remote -v
		return 1
	fi
	git remote add upstream $remote
	git remote -v
}
export -f gaddupstream

grmupstream() {
	local remote="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	if test $# -eq 0; then
		echo "uso: ${cyan}grmupstream <repositorio>${reset}"
		echo "     ${cyan}grmupstream https://github.com/biglinux/big-store${reset}"
		echo "branchs locais:"
		git remote -v
		return 1
	fi
	git remote remove upstream
	git remote -v
}
export -f grmupstream

gpullupstream() {
	local remote="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	if test $# -eq 0; then
		echo "uso: ${cyan}gpullupstream <repositorio>${reset}"
		echo "     ${cyan}gpullupstream https://github.com/biglinux/big-store${reset}"
		echo "branchs locais:"
		git remote -v
		return 1
	fi
	git checkout $mainbranch
	# Adicionar o repositório upstream (se ainda não foi adicionado)
	git remote add upstream $remote
	# Para obter atualizações do repositório original (upstream) e sincronizá-las com o seu fork (origin):
	# Primeiro, traga as atualizações do upstream para sua cópia local
	git fetch upstream
	# Mescle as atualizações da branch principal (geralmente 'main' ou 'master')
	git checkout $mainbranch
	git merge upstream/main
	# Atualizar o repositório remoto (opcional)
	# Depois de atualizar o seu branch local, você pode querer enviar essas mudanças para o seu repositório remoto no GitHub:
	# Agora, envie essas atualizações para seu fork no GitHub (origin)
	git push origin $mainbranch
	git remote -v
}
export -f gpullupstream

getbranch() {
	local branch
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)

	# Check if 'main' branch exists
	if git rev-parse --verify origin/main >/dev/null 2>&1; then
		branch="main"
	elif git rev-parse --verify origin/master >/dev/null 2>&1; then
		branch="master"
	fi
	echo "$branch"
}
export -f getbranch

gbranch() {
	local branch="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	if [[ ! "$branch" =~ ^(stable|testing)$ ]] ;then
		echo "${red}error: Deu ruim para o branch ${yellow}'${branch}'${red}, não é valido, escolha entre ${yellow}'testing' ou 'stable'${reset}"
		git branch
	  return 1
	fi
	atualBranch=$(git status | grep -i 'on branch' | awk '{print $3}')	# Branch Atual
	newBranch=$1-$(date +%Y-%m-%d_%H-%M)																# Branch a ser Criado
	git checkout -b $newBranch																					# Criar novo Branch localmente
	git rebase $mainbranch  																						# Atualize o novo branch:b
	git push --set-upstream origin $newBranch														# Enviar novo Branch para cGitHub
	git push origin $newBranch																					# Faça o push do novo branch:
	git checkout $atualBranch																						# Voltando ao Branch anterior a criação do novo Branch
}
export -f gbranch

gto() {
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	log_wait_msg "${red}Mudando para ${reset}: $1"
	git checkout $1
}
export -f gto

gclean() {
	local clean="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

  if [[ $# -eq 0 ]] || [[ "$clean" != '--confirm' ]] ; then
    echo "Uso: ${cyan}gclean --confirm${reset}"
    return 1
  fi

	log_msg "${yellow}$clean ${red}checado. ${black}Prosseguindo com a limpeza no branch atual${reset}"
	log_msg "Faça um backup do branch atual"
	git branch backup_branch
  log_msg "Crie um novo branch a partir do atual, mas sem histórico de commits"
	git checkout --orphan new_branch
	log_msg "Adicione todos os arquivos ao staging area"
	git add .
	log_msg "Faça o commit dos arquivos com uma mensagem de confirmação"
	git commit -m "Restart commit"
	log_msg "Exclua o branch antigo (opcional, se você deseja substituir o branch atual)"
	git branch -D $mainbranch  # ou master, conforme o nome do branch atual
	log_msg "Renomeie o novo branch para o nome do branch original"
	git branch -m new_branch main  # ou master, conforme o nome do branch original
	log_msg "Faça push do novo branch para o remoto e sobrescreva o histórico remoto"
	git push --force origin $mainbranch  # ou master
	log_msg "Exclua o branch de backup"
  git branch -D backup_branch
	echo
	log_msg "${green}Feito! #####################################################################${reset}"
	git log
	git branch
	log_msg "${green}Feito! #####################################################################${reset}"
}
export -f gclean

gettokengithub() {
	echo "$(< $HOME/GITHUB_TOKEN)"
}
export -f gettokengithub

ginit() {
  local your_repository_name="$1"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

  # Verifique se o argumento foi fornecido
  if [ $# -eq 0 ]; then
    echo "Uso: ${cyan}ginit <repositorio>${reset}"
    return 1
  fi

  # Defina seu nome de usuário GitHub e token pessoal
  local GITHUB_USER="vcatafesta"  # Use o nome de usuário do GitHub
  local GITHUB_TOKEN="$(gettokengithub)"

  # Defina o nome do repositório
  local REPO_NAME="$your_repository_name"

  # Verifique se o diretório já existe
  if [ -d "$REPO_NAME" ]; then
		log_err "${red}O diretório ${yellow}'$REPO_NAME' ${red}já existe. Escolha um nome diferente.${reset}"
    return 1
  fi

  # Verifique se o repositório já existe no GitHub
	local check_response
  check_response=$(curl -s -o /tmp/github_check_response.txt -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" \
    https://api.github.com/repos/$GITHUB_USER/$REPO_NAME)

  if [ "$check_response" -eq 200 ]; then
    cat /tmp/github_check_response.txt
    log_err "${red}O repositório ${yellow}'$REPO_NAME' ${red}já existe no GitHub. Escolha um nome diferente.${reset}"
    return 1
  fi

  # Crie o repositório local
  mkdir "$REPO_NAME" || { echo "Falha ao criar o diretório '$REPO_NAME'"; return 1; }
  cd "$REPO_NAME" || { echo "Falha ao acessar o diretório '$REPO_NAME'"; return 1; }

  # Inicialize o repositório Git
  git init || { echo "Falha ao inicializar o repositório Git"; return 1; }

  # Crie o repositório no GitHub usando a API
  local response
  response=$(curl -s -o /tmp/github_response.txt -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" \
    -X POST https://api.github.com/user/repos \
    -d "{\"name\":\"$REPO_NAME\"}")

  # Verifique a resposta da API
  if [ "$response" -ne 201 ];then
    log_err "${red}Falha ao criar o repositório no GitHub. Código de status: ${yellow}$response${reset}"
    cat /tmp/github_response.txt
    return 1
  fi

  # Crie um commit inicial e faça o push para o GitHub
  echo "# $REPO_NAME" > README.md
  git add README.md || { echo "Falha ao adicionar o README.md"; return 1; }
  git commit -m "Initial commit" || { echo "Falha ao criar o commit inicial"; return 1; }
  git branch -M main || { echo "Falha ao renomear a branch para 'main'"; return 1; }
  git remote add origin "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git" || { echo "Falha ao adicionar o repositório remoto"; return 1; }
  git push -u origin main || { echo "Falha ao fazer o push para o GitHub"; return 1; }
  log_msg "${green}Repositório ${yellow}${REPO_NAME} ${cyan}local ${reset}e no ${cyan}GitHub ${green}criado com sucesso!${reset}"
}
export -f ginit

gremove() {
  local your_repository_name="$1"
  local delete_local="$2"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

  if [ $# -eq 0 ]; then
    echo "uso: ${cyan}gremove <repositorio>${reset} 				# remove repositorio origin/remote"
    echo "uso: ${cyan}gremove <repositorio> --local${reset} # remove repositorio local e origin/remote"
    return 1
  fi

  # Defina seu nome de usuário GitHub e token pessoal
  local GITHUB_USER="vcatafesta"
  local GITHUB_TOKEN="$(gettokengithub)"

  # Defina o nome do repositório
  local REPO_NAME="$your_repository_name"

  echo "Usuário GitHub: $GITHUB_USER"
  echo "Nome do Repositório: $REPO_NAME"

  # Remova o repositório no GitHub usando a API
  local response
  response=$(curl -s -w "%{http_code}" -u "$GITHUB_USER:$GITHUB_TOKEN" -X DELETE "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME")

  # Extraia o código de status da resposta
  local http_code="${response: -3}"  # Pega os últimos 3 caracteres (código de status HTTP)
  local response_body="${response%$http_code}"  # Remove o código de status da resposta

  # Verifique o código de status HTTP retornado
  if [ "$http_code" -eq 204 ]; then
    log_msg "${green}Repositório no GitHub ${yellow}'$REPO_NAME' ${green}removido com sucesso.${reset}"
    # Verifique se o repositório local existe e o remova
		if [ -n "$delete_local" ]; then
	    if [ -d "$REPO_NAME" ]; then
  	    rm -rf "$REPO_NAME" > /dev/null 2>&1
    	  log_msg "${green}Repositório local ${yellow}'$REPO_NAME' ${reset}removido."
	    else
  	    log_err "${red}Repositório local ${yellow}'$REPO_NAME' ${reset}não encontrado."
    	fi
    fi
  else
    log_err "${red}error: Falha ao remover o repositório no GitHub. Código de status: ${yellow}$http_code${reset}"
    log_err "Resposta completa: ${cyan}$response_body${reset}"
    log_err "${red}hint: Verifique se o nome do usuário ${yellow}'$GITHUB_USER' ${red}e o repositório ${yellow}'$REPO_NAME' ${red}estão corretos e se o token tem permissões administrativas.${reset}"
  fi
}
export -f gremove

gclone_all_repo_from_organization() {
	local ORG_NAME="$1"
	local GITHUB_TOKEN="$(gettokengithub)"
	local DEST_DIR="$PWD"
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

	if [ -z "$ORG_NAME" ]; then
	  echo "Uso: gclone_all_repo_from_organization <organization_name>"
	  return 1
	fi

	# Crie o diretório de destino se não existir
	mkdir -p "$DEST_DIR"
	cd "$DEST_DIR" || return

	page=1
	while : ; do
	  echo "Obtendo repositórios da página $page..."
	  # Obtendo a resposta da API
	  response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
	                    -H "Accept: application/vnd.github.v3+json" \
	                    "https://api.github.com/orgs/$ORG_NAME/repos?per_page=100&page=$page")

	  # Verifique se a resposta está vazia
	  if [ -z "$response" ]; then
	    echo "Nenhuma resposta recebida. Verifique a conexão com a API ou o token de acesso."
	    return 1
	  fi

	  # Verifique se a resposta é um JSON válido
	  if ! echo "$response" | jq . > /dev/null 2>&1; then
	    echo "Resposta não é um JSON válido. Verifique a saída da API."
	    echo "Resposta: $response"
	    return 1
	  fi

	  # Extraia URLs de clonagem
	  repos=$(echo "$response" | jq -r '.[].clone_url')

	  # Verifique se há URLs para clonar
	  if [ -z "$repos" ]; then
	    echo "Nenhum repositório encontrado na página $page. Finalizando."
	    break
	  fi

	  # Clone cada repositório
	  for repo in $repos; do
	    echo "Clonando $repo..."
			git clone "$repo"
	  done
	  page=$((page + 1))
	done
}
export -f gclone_all_repo_from_organization

gcreate_all_repo_into_github() {
  local ORIGINAL_REPO_USER="$1"  # Usuário do repositório original (upstream)
  local GITHUB_USER="vcatafesta"
  local GITHUB_TOKEN="$(gettokengithub)"
  local DEST_DIR="$PWD"  # Diretório onde os repositórios estão clonados
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

  # Verifique se o argumento foi fornecido
  if [ $# -eq 0 ]; then
    echo "Uso: ${cyan}gcreate_all_repo_into_github <original_github_repo_user>${reset}"
    echo "     ${cyan}gcreate_all_repo_into_github biglinux${reset}"
    echo "     ${cyan}gcreate_all_repo_into_github BigLinux-Package-Build${reset}"
    return 1
  fi

  if [ -z "$DEST_DIR" ]; then
    echo "Defina DEST_DIR para o diretório onde os repositórios foram clonados."
    return 1
  fi

  # Navegue até o diretório de destino
  cd "$DEST_DIR" || return 1

  # Obtenha a lista de repositórios clonados
  for repo_dir in */; do
    # Remove a barra final e obtenha o nome do repositório
    repo_name=$(basename "${repo_dir%%/}")

    echo "Processando repositório: $repo_name"

    cd "$repo_dir" || continue

    # Verifique se o repositório já existe no GitHub
    response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
                      -H "Accept: application/vnd.github.v3+json" \
                      "https://api.github.com/repos/$GITHUB_USER/$repo_name/forks")

    if echo "$response" | grep -q '"Not Found"'; then
      # Crie o repositório no GitHub usando a API
      response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
                        -H "Accept: application/vnd.github.v3+json" \
                        -X POST \
                        -d "{\"name\":\"$repo_name\",\"private\":false}" \
                        "https://api.github.com/user/repos")

      # Verifique se o repositório foi criado com sucesso
      http_code=$(echo "$response" | jq -r '.id // empty')

      if [ -n "$http_code" ]; then
        echo "Repositório no GitHub '$repo_name' criado com sucesso."
      else
        echo "Falha ao criar o repositório no GitHub '$repo_name'."
        echo "Resposta: $response"
        cd ..
        continue
      fi
    else
      echo "Repositório '$repo_name' já existe no GitHub."
    fi

    # Configure o remote 'origin' e 'upstream'
    remote_url="https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$repo_name.git"
    upstream_url="https://github.com/$ORIGINAL_REPO_USER/$repo_name.git"

    # Adicione ou atualize o remote 'origin' com a URL correta
    git remote set-url origin "$remote_url"
    echo "Remote 'origin' atualizado para o repositório '$repo_name'."

    # Adicione o remote 'upstream' com a URL do repositório original se não estiver configurado
    if ! git remote get-url upstream &>/dev/null; then
      git remote add upstream "$upstream_url"
      echo "Remote 'upstream' adicionado para o repositório '$repo_name'."
    fi

    # Faça o push de todos os branches
    git push --all origin

    # Faça o push de todas as tags
    git push --tags origin

    # Retorne ao diretório anterior
    cd ..
  done
}
export -f gcreate_all_repo_into_github

gfork_repo_into_github() {
  # Defina variáveis
  local ORIGINAL_REPO_USER="$1"		# Usuário do repositório original (upstream)
  local repo="$2"									# repo para clonear --all para todos
  local GITHUB_USER="vcatafesta"  # teu user no github
 	local GITHUB_TOKEN="$(gettokengithub)"
  local DEST_DIR="$PWD"						# Diretório onde os repositórios serão clonados
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

  # Verifique se o argumento foi fornecido
  if [ $# -lt 2 ]; then
    echo "Uso: ${cyan}gfork_repo_into_github <original_github_repo_user> <repo>|<--all>${reset}"
    echo "     ${cyan}gfork_repo_into_github biglinux <repo>|<--all>${reset}"
    echo "     ${cyan}gfork_repo_into_github BigLinux-Package-Build <repo>|<--all> ${reset}"
    return 1
  fi

  if [ -z "$DEST_DIR" ]; then
    echo "Defina DEST_DIR para o diretório onde os repositórios devem ser clonados."
    return 1
  fi

#  #Lista de repositórios a serem processados
#  repos=(
#    auto-hooks-archlinux
#    auto-hooks-AUR
#    auto-update-AUR
#    big-releases
#    build-iso
#    build-iso-arm
#    build-package
#    build-package-archlinux
#    build-package-ARM
#    build-package-tmate
#    distrobox-images
#    manjaro-mirror
#    simple-action-tester
#    sync-fork
#  )

	if [[ -z "$repo" ]] || [[ "$repo" = '--all' ]]; then
		# Obtenha a lista de repositórios do usuário/organização
		mapfile -t repos < <(curl -q -s -H "Authorization: token $GITHUB_TOKEN" \
    	            -H "Accept: application/vnd.github.v3+json" \
      	          "https://api.github.com/users/$ORIGINAL_REPO_USER/repos?per_page=100" | jq -r '.[].name')
	else
		repos=("$repo")
	fi

	for repo_name in "${repos[@]}"; do
	  cd "$DEST_DIR"
    echo "Criando fork do repositório: $repo_name"

    # Crie o fork no GitHub usando gh
    fork_response=$(gh repo fork "$ORIGINAL_REPO_USER/$repo_name" --clone=false 2>&1)
    if echo "$fork_response" | grep -q "already exists"; then
      log_err "O repositório '$repo_name' já foi forkado."
    else
      # Verifique se o fork foi criado com sucesso
      if [[ -z "$fork_response" ]]; then
        log_msg "Fork do repositório '$repo_name' criado com sucesso."
      else
        log_err "Falha ao criar o fork para o repositório '$repo_name'."
        log_err "Resposta: $fork_response"
      fi
    fi

    # Obtenha a URL do fork
    fork_url=$(gh repo view "$GITHUB_USER/$repo_name" --json url -q ".url")

    # Clone o repositório forkado
    log_msg "Clonando repositório forkado: $repo_name"
    git clone "$fork_url" "$repo_name"
    cd "$repo_name" || continue

    # Adicione o remote 'upstream' se ainda não existir
    upstream_url="https://github.com/$ORIGINAL_REPO_USER/$repo_name.git"
    if ! git remote get-url upstream &>/dev/null; then
      git remote add upstream "$upstream_url"
      log_msg "Remote 'upstream' adicionado para o repositório '$repo_name'."
    fi

    # Configure o remote 'origin' com a URL do fork
    git remote set-url origin "$fork_url"
    log_msg "Remote 'origin' configurado para o repositório '$repo_name'."

    # Faça o push de todos os branches
    git push --all origin

    # Faça o push de todas as tags
    git push --tags origin

    # Retorne ao diretório anterior
    cd ..
  done
}
export -f gfork_repo_into_github

gremove_all_repo_into_github() {
	local ORG_NAME="vcatafesta"
	local GITHUB_USER="vcatafesta"
	local GITHUB_TOKEN="$(gettokengithub)"
	local DEST_DIR="$PWD"
	local response
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local mainbranch="$(getbranch)"

  echo "Usuário GitHub: $GITHUB_USER"
  echo "Nome do Repositório: $REPO_NAME"

	# Para cada repositório no diretório
	for REPO_NAME in */; do
		REPO_NAME="${REPO_NAME%%/}"
		gremove "$REPO_NAME" "--local"
	done
}
export -f gremove_all_repo_into_github

cpd() {
	TITLE='Copiando...'
	MSG="Copiando o diretório $ORIGEM para $DESTINO"
	INTERVALO=1 # intervalo de atualização da barra (segundos)
	PORCENTO=0  # porcentagem inicial da barra
	#................................................................
	ORIGEM="${1%/}"
	DESTINO="${2%/}"
	#................................................................
	die() { echo "Erro: $*"; }
	sizeof() { du -s "$1" | cut -f1; }
	running() { pgrep -f $1; }

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
	[ -d "$DIR_DESTINO" ] && [ "$(sizeof $DIR_DESTINO)" -gt 4 ] &&
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
	trap 'kill "$CPPID"' 2 15

	#................................................................

	# loop de checagem de status da cópia
	(
		# enquanto o processo de cópia estiver rodando
		while running $CPPID; do
			# quanto já foi copiado?
			COPIADO=$(sizeof $DIR_DESTINO)
			# qual a porcentagem do total?
			PORCENTAGEM=$((COPIADO * 100 / TOTAL))
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

chili-distro() {
	tar -cvpJf \
		balcao.tar.xz \
		--exclude=/mnt \
		--exclude=/usr/src \
		--exclude=/proc \
		--exclude=/dev \
		--exclude=/sys \
		--exclude=*.bak \
		--exclude=*.xz \
		/
}
export -f chili-distro

remountpts() {
	log_info_msg "Desmontando: sudo umount -rl /dev/pts"
	umount -rl /dev/pts
	evaluate_retval
	log_info_msg "Remontando: sudo mount devpts /dev/pts -t devpts"
	mount devpts /dev/pts -t devpts
	evaluate_retval
}

backup() {
	sl
	mkdir -p /home/vcatafesta/github
	mkdir -p /home/vcatafesta/sci/src.linux
	rsync --progress -Cravzp --rsh='ssh -l vcatafesta' vcatafesta@10.0.0.66:/home/vcatafesta/sci/src.linux/ /home/vcatafesta/sci/src.linux/
	rsync --progress -Cravzp --rsh='ssh -l vcatafesta' vcatafesta@10.0.0.66:/home/vcatafesta/sci/include/ /home/vcatafesta/sci/include/
	rsync --progress -Cravzp --rsh='ssh -l vcatafesta' vcatafesta@10.0.0.66:/home/vcatafesta/github/LetoDBf/ /home/vcatafesta/github/LetoDBf/
}
export -f backup

tolfs() {
	export LFS=/mnt/lfs
	mkdir -pv $LFS
	mount -v -t ext4 /dev/sdb4 $LFS
	swapon -v /dev/sdb3
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

inst() {
	local false=1
	local true=0
	local lgenerate=$false
	local BUILD_DIR='/lfs/build'

	log_wait_msg "Criando diretorios de trabalho..."
	mkdir -p "$BUILD_DIR"
	pkgname=$1
	_pkgname=$1
	pkgver=$2
	pkgrel=$DESC_BUILD
	PKG=$1-$2
	test -d "$BUILD_DIR/$PKG" || mkdir -p "$BUILD_DIR/$PKG"

	if [ "${3}" = "G" ]; then
		lgenerate=$true
	fi

	log_wait_msg "Instalando pacote em $BUILD_DIR/$PKG..."
	if [ $lgenerate = $false ]; then
		make -j1 install DESTDIR=$BUILD_DIR/$PKG/
		log_wait_msg "Striping arquivos..."
		strip -s $BUILD_DIR/$PKG/usr/bin/* >/dev/null 2>&1
		strip -s $BUILD_DIR/$PKG/usr/sbin/* >/dev/null 2>&1

		log_wait_msg "Gziping arquivos..."
		pushd $BUILD_DIR/$PKG || return
		find . -name '*[0-9]' -type f -exec gzip -9 -f {} \;
		popd || return
	fi

	log_wait_msg "Criando pacote..."
	cd $BUILD_DIR/$PKG/ || return

	if [ "$3" = "" ]; then
		banana -g "$PKG-${DESC_BUILD}"
		cd $BUILD_DIR/$PKG/info/ || return
		#nano desc
	fi
	if [ $lgenerate = $true ]; then
		banana -g "$PKG-${DESC_BUILD}"
	fi

	cd $BUILD_DIR/$PKG/ || return
	export l=$BUILD_DIR/$PKG
	export pkgdir=$BUILD_DIR/$PKG
	alias l='cd $l'
	if [ $lgenerate = $false ]; then
		banana -c $PKG-${DESC_BUILD}.chi
	fi
}

build() {
	export r="$PWD"
	export srcdir=${PWD#/};	srcdir=/${srcdir%%/*}
	alias r='cd $r'
	pkg=$(echo $PWD | sed 's/\// /g' | awk '{print $NF}' | sed 's/-/_/g' | sed 's/\(.*\)_/\1 /')
	arr=($pkg)
	[[ ${#arr[*]} -gt 2 ]] && pkg="${arr[0]}_${arr[1]} ${arr[2]}"
	log_success_msg2 "Criando pacote... $pkg"
	inst $pkg
	evaluate_retval
}

gen() {
	export r="$PWD"
	export srcdir="${PWD#/}"; srcdir="/${srcdir%%/*}"
	alias r='cd $r'
	pkg=$(echo "$PWD" | sed 's/\// /g' | awk '{print $NF}' | sed 's/-/_/g' | sed 's/\(.*\)_/\1 /')
	arr=($pkg)
	[[ ${#arr[*]} -gt 2 ]] && pkg="${arr[0]}_${arr[1]} ${arr[2]}"
	log_success_msg2 "Criando pacote... $pkg"
	inst $pkg "G"
	evaluate_retval
}

makepy() {
	local filepy="ex.py"
	log_wait_msg "Aguarde, criando arquivo $1..."
	if [ "${1}" != "" ]; then
		filepy="${1}"
	fi

	cat >${filepy} <<"EOF"
#!/usr/bin/python3
# -*- coding: utf-8 -*-
EOF
	chmod +x ${filepy}
	log_success_msg2 "Feito! ${cyan}'$filepy' ${reset}criado on $PWD"
}

mkpy() { makepy "$@"; }
makescript() { makebash "$@"; }
mks() { makebash "$@"; }

mkpyenv() {
	#	python3 -m venv tutorial_env
	#	source tutorial_env/bin/activate
	if test $# -eq 0; then
		echo 'uso:'
		echo '	mkpyenv env_test'
		return
	fi
	python3 -m venv $1
	source $1/bin/activate
#	deactivate
}

sh_setLogPrefix() {
    COL_NC='\e[0m' # No Color
    COL_LIGHT_GREEN='\e[1;32m'
    COL_LIGHT_RED='\e[1;31m'
    TICK="${white}[${COL_LIGHT_GREEN}✓${COL_NC}${white}]"
    CROSS="${white}[${COL_LIGHT_RED}✗${COL_NC}${white}]"
    INFO="[i]"
    # shellcheck disable=SC2034
    DONE="${COL_LIGHT_GREEN} done!${COL_NC}"
    OVER="\\r\\033[K"
    NORMAL="${reset}"
    SUCCESS="${green}"
    WARNING="${yellow}"
    FAILURE="${red}"
    INFO="${cyan}"
    BRACKET="${blue}"
    BMPREFIX="     "
    DOTPREFIX="  ${blue}::${reset} "
    #  SUCCESS_PREFIX="${SUCCESS}  ↑  ${NORMAL}"
    SUCCESS_PREFIX=" $TICK "
    SUCCESS_SUFFIX="${BRACKET}[${SUCCESS}  OK  ${BRACKET}]${NORMAL}"
    #  FAILURE_PREFIX="${FAILURE}  ↓  ${NORMAL}"
    FAILURE_PREFIX=" $CROSS "
    FAILURE_SUFFIX="${BRACKET}[${FAILURE} FAIL ${BRACKET}]${NORMAL}"
    WARNING_PREFIX="${WARNING}  W  ${NORMAL}"
    WARNING_SUFFIX="${BRACKET}[${WARNING} WARN ${BRACKET}]${NORMAL}"
    SKIP_PREFIX="${INFO}  S  ${NORMAL}"
    SKIP_SUFFIX="${BRACKET}[${INFO} SKIP ${BRACKET}]${NORMAL}"
    WAIT_PREFIX="${WARNING}  R  ${NORMAL}"
    WAIT_SUFFIX="${BRACKET}[${WARNING} WAIT ${BRACKET}]${NORMAL}"
}

log_msg() {
	printf " %b %s\\n" "${TICK}" "${*}"
}

log_err() {
	printf " %b %s\\n" "${CROSS}" "${*}"
}

mkl() {
    prg='script.lua'
    if test $# -ge 1; then
        prg="$1"
        [[ -e "$prg" ]] && {
            log_err "${red}error: ${reset}Arquivo ${cyan}'$1'${reset} já existe. Abortando..."
            return
        }
    fi
    log_msg "Criando arquivo Lua ${cyan}'$prg'${reset} on $PWD"
    cat >"$prg" <<"EOF"
#!/usr/bin/env lua

EOF
    sudo chmod +x $prg
    #echo $(replicate '=' 80)
    #cat $prg
    #echo $(replicate '=' 80)
    log_msg "Feito! arquivo ${cyan}'$prg' ${reset}criado on $PWD"
}

makebash() {
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local prg='script.sh'

	if test $# -ge 1; then
		prg="$1"
		[[ -e "$prg" ]] && {
			log_err "${red}error: ${reset}Arquivo ${cyan}'$1'${reset} já existe"
			return
		}
	fi
	log_msg "Criando script bash ${cyan}'$prg'${reset} on $PWD"
	cat >"$prg" <<-EOF
#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# shellcheck shell=bash disable=SC1091,SC2039,SC2166
#
#  $prg
#  Created: $(date +'%Y/%m/%d') - $(date +'%H:%M')
#  Altered: $(date +'%Y/%m/%d') - $(date +'%H:%M')
#
#  Copyright (c) $(date +'%Y')-$(date +'%Y'), Vilmar Catafesta <vcatafesta@gmail.com>
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##############################################################################
#export LANGUAGE=pt_BR
export TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAIN=$prg

# Definir a variável de controle para restaurar a formatação original
reset=\$(tput sgr0)

# Definir os estilos de texto como variáveis
bold=\$(tput bold)
underline=\$(tput smul)   # Início do sublinhado
nounderline=\$(tput rmul) # Fim do sublinhado
reverse=\$(tput rev)      # Inverte as cores de fundo e texto

# Definir as cores ANSI como variáveis
black=\$(tput bold)\$(tput setaf 0)
red=\$(tput bold)\$(tput setaf 196)
green=\$(tput bold)\$(tput setaf 2)
yellow=\$(tput bold)\$(tput setaf 3)
blue=\$(tput setaf 4)
pink=\$(tput setaf 5)
magenta=\$(tput setaf 5)
cyan=\$(tput setaf 6)
white=\$(tput setaf 7)
gray=\$(tput setaf 8)
orange=\$(tput setaf 202)
purple=\$(tput setaf 125)
violet=\$(tput setaf 61)
light_red=\$(tput setaf 9)
light_green=\$(tput setaf 10)
light_yellow=\$(tput setaf 11)
light_blue=\$(tput setaf 12)
light_magenta=\$(tput setaf 13)
light_cyan=\$(tput setaf 14)
bright_white=\$(tput setaf 15)

#debug
export PS4='\${red}\${0##*/}\${green}[\$FUNCNAME]\${pink}[\$LINENO]\${reset}'
#set -x
#set -e
shopt -s extglob

#system
declare APP="\${0##*/}"
declare _VERSION_="1.0.0-$(date +'%Y%m%d')"
declare distro="\$(uname -n)"
declare DEPENDENCIES=(tput)
source /usr/share/fetch/core.sh

MostraErro {
  echo "erro: \${red}\$1\${reset} => comando: \${cyan}'\$2'\${reset} => result=\${yellow}\$3\${reset}"
}
trap 'MostraErro "\$APP[\$FUNCNAME][\$LINENO]" "\$BASH_COMMAND" "\$?"; exit 1' ERR

EOF
	sudo chmod +x $prg
	#echo $(replicate '=' 80)
	#cat $prg
	#echo $(replicate '=' 80)
	log_msg "Feito! arquivo ${red}'$prg' ${reset}criado on $PWD"
}

mkcobol() {
	prg='script.cob'
	if test $# -ge 1; then
		prg="$1"
		[[ -e "$prg" ]] && {
			log_err "${red}error: ${reset}Arquivo ${cyan}'$1'${reset} já existe. Abortando..."
			return
		}
	fi
	log_msg "Aguarde, criando arquivo ${cyan}'$prg'${reset} on $PWD"
	cat >"$prg" <<-'EOF'
      *=================================================================
      * Author    :
      * Date      :
      * Purpose   :
      * Tectonics : cobc -x -j -O
      *=================================================================
      *>>SOURCE FORMAT FREE.
       IDENTIFICATION DIVISION.
        PROGRAM-ID.     YOUR-PROGRAM-NAME.
        AUTHOR.         Vilmar Catafesta.
        INSTALLATION.   Vilmar Catafesta.
        DATE-WRITTEN.   05/12/2023.
        DATE-COMPILED.  05/12/2023.
      *
      * PROJ DESC : SAMPLE COBOL PROGRAM TO DISPLAY EMPLOYEE
      *              NAME in SPOOL.
      *
      *=================================================================
       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
      *
      *
       DATA DIVISION.
      *
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       77 black         pic 9 value 0.
       77 blue          pic 9 value 1.
       77 green         pic 9 value 2.
       77 cyan          pic 9 value 3.
       77 red           pic 9 value 4.
       77 magenta       pic 9 value 5.
       77 brown         pic 9 value 6.
       77 white         pic 9 value 7.
       77 cinza         pic 9 value 8.
       77 lightblue     pic 9 value 9.
       77 ligthgreen    pic 99 value 10.
       77 ligthcyan     pic 99 value 11.
       77 ligthred      pic 99 value 12.
       77 ligthmagenta  pic 99 value 13.
       77 yellow        pic 99 value 14.
       77 lightwhite    pic 99 value 15.

       01 NR1 PIC +ZZZ9.
       01 NR2 PIC +9999.
       01 NR3 PIC S9999.
       01 WRK-DATA.
           02 WRK-ANO PIC 9(04)  VALUE ZEROS.
           02 WRK-MES PIC 9(02)  VALUE ZEROS.
           02 WRK-DIA PIC 9(02)  VALUE ZEROS.
      *
      *
       PROCEDURE DIVISION.
      *
       0100-main-logic.
            display "Copyright (c) 2023 Vilmar Catafesta"
                    " <vcatafesta@gmail.com>"
            display "Hello World!"
            perform main-procedure.

       main-procedure.
           MOVE 2      TO NR1
           MOVE 3      TO NR2
           MOVE 2023   TO NR3
           DISPLAY NR1
           DISPLAY NR2
           DISPLAY NR3
           ACCEPT WRK-DATA FROM DATE YYYYMMDD.
           DISPLAY 'DATA ' WRK-DIA ' DE ' WRK-MES ' DE ' WRK-ANO.
           STOP RUN.
       END PROGRAM YOUR-PROGRAM-NAME.
EOF
    log_msg "Feito! arquivo ${cyan}'$prg' ${reset}criado on $PWD"
}

mkcpp() { make_cpp_file "$@"; }

make_cpp_file() {
	prg='main.cpp'
	if test $# -ge 1; then
		prg="$1"
		[[ -e "$prg" ]] && {
			msg "${red}Arquivo $1 já existe. Abortando..."
			return
		}
		[[ -e "$prg.cpp" ]] && {
			msg "${red}Arquivo $1.cpp já existe. Abortando..."
			return
		}
	fi
	#! [[ "$prg" =~ ".cpp" ]]   && prg+=".cpp"
	[[ ${prg: -4} != ".cpp" ]] && prg+=".cpp"
	log_wait_msg "Aguarde, criando arquivo $prg on $PWD"
	cat >"$prg" <<-EOF
		// $prg, Copyright (c) 1991,2024 Vilmar Catafesta <vcatafesta@gmail.com>
		#ifdef __cplusplus
		   #include <iostream>  // std::cout
		   #include <filesystem>
		   #include <cstddef>   // std::size_t
		   #include <valarray>  // std::valarray, std::slice
   		   #include <sstream>   // std::stringstream
		   #include <string>
		   #include <cctype>
		   #include <array>
		   #include <algorithm>
		   #include <functional>
		   #include <map>
		   #include <vector>
		   #include <chrono>
		   #include <thread>
		   #include <cwchar>
		   #include <clocale>
		#endif
		#include <stdio.h>
		#include <stdlib.h>
		#include <stdbool.h>
		#include <string.h>
		#include <signal.h>
		#include <sys/wait.h>
		#ifdef _WIN32
		   #include <Windows.h>
		   #include <dos.h>
		#else
		   #include <unistd.h>
		#endif
		#include "color.h"

		#ifdef __cplusplus
		   using namespace std;
		#endif /* __cplusplus */

		#if defined( __GNUC__ )
		   //#pragma GCC diagnostic ignored "-Wwrite-strings"
		   //#pragma GCC diagnostic ignored "-Wunused-parameter"
		   //#pragma GCC diagnostic ignored "-Wuninitialized"
		   //#pragma GCC diagnostic ignored "-Wunused-function"
		   //#pragma GCC diagnostic ignored "-Wduplicated-cond"
		   #pragma GCC diagnostic ignored "-Wunused-variable"
		   #pragma GCC diagnostic ignored "-Wformat"
		   #pragma GCC diagnostic ignored "-Wformat-extra-args"
		#endif

		#define CURSOR(top, bottom)  (((top) << 8) | (bottom))
		#define getrandom(min, max)  ((rand()%(int)(((max) + 1)-(min)))+ (min))

		//=================================================================

		void qqout() {}
		template <typename T, typename... Args>
		void qqout(T arg, Args... args) {
		   std::cout << arg << "";
		   qqout(args...);
		}

		void qout() { std::cout << '\n'; }
		template <typename T, typename... Args>
		void qout(T arg, Args... args) {
		   std::cout << arg << "";
		   qout(args...);
		}

		template <class T, typename X>
		std::string replicate(T ch, X tam) {
		   std::string replicate;
		   replicate.assign(tam, ch);
		   return replicate;
		}

		size_t my_strlen(char *c) {
		   size_t i = 0;
		   while(*c != NULL) {
		      c++;
		      i++;
		   }
		   return i;
		}

		size_t LenArray(char **a) {
		   size_t i = 0;
		   //while(*(a+i)){
		   while( a[i] ){
		      i++;
		   }
		   return i;
		}

		//=================================================================

		int main(int argc, char **argv) {
		   qout(RED,"\u2630 $prg, Copyright \u24d2  2023 Vilmar Catafesta <vcatafesta@gmail.com>\u21b4", RESET, '\n');

		   qout(GREEN, "Hello, World!", RESET, '\n');
		   return EXIT_SUCCESS;
		}

	EOF
    log_success_msg2 "Feito! ${cyan}'$prg' ${reset}criado on $PWD"
}

mkc() { make_c_file "$@"; }

make_c_file() {
	local red=$(tput bold)$(tput setaf 196)
	local cyan=$(tput setaf 6)
	local reset=$(tput sgr0)
	local prg='main.c'

	if test $# -ge 1; then
		prg="$1"
		[[ -e "$prg" ]] && {
			msg "${red}Arquivo $1 já existe. Abortando..."
			return
		}
		[[ -e "$prg.c" ]] && {
			msg "${red}Arquivo $1.c já existe. Abortando..."
			return
		}
	fi
	#! [[ "$prg" =~ ".c" ]]   && prg+=".c"
	[[ ${prg: -2} != ".c" ]] && prg+=".c"
	log_wait_msg "Criando arquivo $prg on $PWD"
	if cat >"$prg" <<-EOF; then
		// $prg, Copyright (c) 1991,2024 Vilmar Catafesta <vcatafesta@gmail.com>
		#include <stdio.h>
		#include <stdlib.h>
		#include <stdbool.h>
		#include <stdint.h>
		#include <string.h>
		#include <ctype.h>
		#include <time.h>
		#include <unistd.h>
		#include <sys/ioctl.h>

		#define BLACK        "\033[30m"
		#define RED          "\033[31m"
		#define GREEN        "\033[32m"
		#define YELLOW       "\033[33m"
		#define BLUE         "\033[34m"
		#define MAGENTA      "\033[35m"
		#define CYAN         "\033[36m"
		#define WHITE        "\033[37m"
		#define GRAY         "\033[90m"
		#define LIGHTWHITE   "\033[97m"
		#define LIGHTGRAY    "\033[37m"
		#define LIGHTRED     "\033[91m"
		#define LIGHTGREEN   "\033[92m"
		#define LIGHTYELLOW  "\033[93m"
		#define LIGHTBLUE    "\033[94m"
		#define LIGHTMAGENTA "\033[95m"
		#define LIGHTCYAN    "\033[96m"
		#define RESET        "\033[0m"
		#define BOLD         "\033[1m"
		#define FAINT        "\033[2m"
		#define ITALIC       "\033[3m"
		#define UNDERLINE    "\033[4m"
		#define BLINK        "\033[5m"
		#define INVERTED     "\033[7m"
		#define HIDDEN       "\033[8m"

		int main(int argc, char **argv) {
		   printf("%s$prg, Copyright (c) 1991,2024 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
		   printf("%sHello World\n%s", GREEN, RESET);
		   return EXIT_SUCCESS;
		}

	EOF
		log_success_msg2 "Feito! ${cyan}'$prg' ${reset}criado on $PWD"
	else
		msg "${red}Erro. Abortando..."
	fi
}

MK() {
	log_wait_msg "Aguarde, criando arquivo rmake..."
	cat >rmake <<"EOF"
#!/bin/bash
	source /etc/bashrc
   ./configure --prefix=/usr     \
               --sysconfdir=/etc
   sudo make
   #sudo make check
   sudo make install DESTDIR="/github/ChiliOS/packages/core/${PWD##*/}-1"
EOF
	sudo chmod +x rmake
	log_success_msg2 "Feito!"
}

MKLIB() {
	log_wait_msg "Aguarde, criando arquivo rmake..."
	cat >rmake <<"EOF"
#!/bin/bash
   source /etc/bashrc
   ./configure --prefix=/usr --disable-static &&
   sudo make
   #sudo make check
   #sudo make install
EOF
	sudo chmod +x rmake
	log_success_msg2 "Feito!"
}

MKCMAKE() {
	log_wait_msg "Aguarde, criando arquivo rmake..."
	cat >rmake <<"EOF"
#!/bin/bash
   source /etc/bashrc
   mkdir build &&
   cd    build &&

   cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
         -DCMAKE_PREFIX_PATH=$QT5DIR        \
         -DCMAKE_BUILD_TYPE=Release         \
         -DBUILD_TESTING=OFF                \
         -Wno-dev .. &&
   sudo make
   #sudo make check
   #sudo make install
EOF
	sudo chmod +x rmake
	log_success_msg2 "Feito!"
}

MKX() {
	log_wait_msg "Aguarde, criando arquivo rmake..."
	cat >rmake <<"EOF"
#!/bin/bash
   ./configure $XORG_CONFIG &&
   sudo make
   #sudo make check
   #sudo make install
EOF
	sudo chmod +x rmake
	log_success_msg2 "Feito!"
}

chili-bindlfs() {
	export LFS=/mnt/build_dir
	mount -v --bind /dev $LFS/dev
	mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
	mount -vt proc proc $LFS/proc
	mount -vt sysfs sysfs $LFS/sys
	mount -vt tmpfs tmpfs $LFS/run

	if [ -h $LFS/dev/shm ]; then
		mkdir -pv "$LFS/$(readlink $LFS/dev/shm)"
	fi
}

chili-repairdirvar() {
	log_wait_msg "Iniciando reparo do /var/run..."
	#  exec &> /dev/null
	mv -f /var/run/* /run/ >/dev/null 2>&1
	rm -rf /var/run >/dev/null 2>&1
	ln -s /run /var/run >/dev/null 2>&1
	exec >/dev/tty
	log_success_msg2 "Feito..."
}

ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xvjf $1 ;;
		*.tar.gz) tar xvzf $1 ;;
		*.tar.xz) tar Jxvf $1 ;;
		*.lz) lzip -d -v $1 ;;
		*.chi) tar Jxvf $1 ;;
		*.chi.zst) tar -xvf $1 ;;
		*.tar.zst) tar -xvf $1 ;;
		*.mz) tar Jxvf $1 ;;
		*.cxz) tar Jxvf $1 ;;
		*.tar) tar xvf $1 ;;
		*.tbz2) tar xvjf $1 ;;
		*.tgz) tar xvzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

chili-converteOldChiPkgToNewZst() {
	cfiles=$(ls -1 -- *.chi)

	for pkg in $cfiles; do
		echo
		newpkg="${pkg//_/\-}"
		log_info_msg "Renomeando $pkg para $newpkg"
		mv $pkg $newpkg &>/dev/null
		evaluate_retval
		cnewpkgsemext="${newpkg//.chi/}"
		log_info_msg "Criando diretorio $cnewpkgsemext"
		mkdir $cnewpkgsemext &>/dev/null
		evaluate_retval

		log_info_msg "Extraindo arquivos $newpkg"
		tar --extract --file $newpkg -C $cnewpkgsemext
		evaluate_retval

		log_info_msg "Entrando diretorio $cnewpkgsemext"
		pushd $cnewpkgsemext/ &>/dev/null || return
		evaluate_retval

		fetch -g
		echo -e
		fetch create
		echo -e
		popd &>/dev/null || return
	done
}

chili-removeoldpkgarch() {
	local nfiles=0
	local cOldDir=$PWD
	cd /var/cache/pacman/pkg || return

	shopt -s nullglob # enable suppress error message of a command
	if [ $# -lt 1 ]; then
		AllFilesPackages=$(ls -1 -- *.{zst,xz})
	else
		AllFilesPackages=$(ls -1 -- $1*.{zst,xz})
	fi
	shopt -u nullglob # disable suppress error message of a command

	log_wait_msg "wait, working on it..."
	for pkgInAll in $AllFilesPackages; do
		pkgtar=$(echo $pkgInAll | sed 's/\// /g' | awk '{print $NF}' | sed 's/-x86_64.chi.\|zst\|xz//g' | sed 's/-any.chi.\|zst\|xz//g' | sed 's/1://g' | sed 's/2://g')
		FilteredPackages=$(echo $pkgtar | sed 's/\(.*\)-\(.*-\)/\1*\2/' | cut -d* -f1)
		FilteredPackages=$FilteredPackages"-"
		AllFilteredPackages=$(ls -1 $FilteredPackages*.{zst,xz} 2>/dev/null)
		#		AllFilteredPackages=$(ls -1 $FilteredPackages*.zst 2> /dev/null)
		#		AllFilteredPackages="$AllFilteredPackages $(ls -1 $FilteredPackages*.xz 2> /dev/null)"
		nfiles=0

		for y in "${AllFilteredPackages[@]}"; do
			((nfiles++))
		done
		#		echo -e "${white}Verifying package ${purple}($nfiles) ${green}$pkgInAll"
		log_wait_msg "${white}Verifying package ${purple}($nfiles) ${green}$pkgInAll"
		if [[ $nfiles -gt 1 ]]; then
			for pkg in $AllFilteredPackages; do
				if [[ "$(vercmp $pkgInAll $pkg)" -lt 0 ]]; then
					maxcol
					replicate "=" $?
					log_info_msg "Removing ${red}OLD ${reset}package ${yellow}$pkgInAll"
					rm $pkgInAll* >/dev/null 2>&1
					evaluate_retval
					maxcol
					replicate "=" $?
				elif [[ "$(vercmp $pkgInAll $pkg)" -gt 0 ]]; then
					continue
				elif [[ "$(vercmp $pkgInAll $pkg)" -eq 0 ]]; then
					continue
				fi
			done
		fi
	done
	cd $cOldDir || return
}

removeoldpkgchili() { chili-removeoldpkgchili "$@"; }
chili-removeoldpkgchili() {
	local arr=
	local cdir=
	local nfiles=
	local pkg=
	local cOldDir=
	local AllFilesPackages=
	local pkg=
	local pkgInAll=
	local FilteredPackages=
	local AllFilteredPackages=

	cd /github/ChiliOS/packages/ || return
	shopt -s nullglob # enable suppress error message of a command

	for cdir in {a..z}; do
		#echo -e "${white}Verifying packages in ${green}$cdir"
		cOldDir=$PWD
		pkgInAll=
		FilteredPackages=
		AllFilesPackages=
		AllFilteredPackages=

		if [ $# -lt 1 ]; then
			pushd $cdir >/dev/null 2>&1 || return
			AllFilesPackages=$(ls -1 -- *.{zst,xz})
		else
			#cdir=${1:0:1}
			pushd $cdir >/dev/null 2>&1 || return
#			AllFilesPackages=$(ls -1 -- *.zst | grep ^$1)
			AllFilesPackages=$(grep ^$1 -- *.zst)
		fi

		#log_wait_msg "wait, working on it..."
		for pkgInAll in $AllFilesPackages; do
			sh_splitpkg ${pkgInAll}
			#pkgtar=$(echo $pkgInAll |sed 's/\// /g'|awk '{print $NF}'|sed 's/-x86_64.chi.\|zst\|xz//g'|sed 's/-any.chi.\|zst\|xz//g'|sed 's/.chi.\|zst\|xz//g'|sed 's/1://g'|sed 's/2://g')
			#FilteredPackages=$(echo $pkgtar | sed 's/\(.*\)-\(.*-\)/\1*\2/' |cut -d* -f1)
			#FilteredPackages=$FilteredPackages"-"

			FilteredPackages=${aPKGSPLIT[$PKG_BASE]}
			AllFilteredPackages=$(ls -1 $FilteredPackages*.{zst,xz} 2>/dev/null)
			#info "$pkgInAll \n $FilteredPackages \n $AllFilteredPackages"
			pkg=
			arr=(${AllFilteredPackages[*]})
			nfiles=${#arr[*]}

			#log_wait_msg "${white}Verifying package ${purple}($nfiles) ${green}$pkgInAll"
			if [[ $nfiles -gt 1 ]]; then
				log_wait_msg "${white}Verifying candidate package ${purple}($nfiles) ${green}$FilteredPackages"
				for pkg in $AllFilteredPackages; do
					#info "$pkgInAll \n$pkg"
					if [[ "$(vercmp $pkgInAll $pkg)" -lt 0 ]]; then
						#maxcol; replicate "=" $?
						log_info_msg "Removing ${red}OLD ${reset}package ${yellow}$pkgInAll"
						rm $pkgInAll* >/dev/null 2>&1
						evaluate_retval
						#maxcol; replicate "=" $?
						if [[ $nfiles -eq 2 ]]; then
							break
						fi
					elif [[ "$(vercmp $pkgInAll $pkg)" -gt 0 ]]; then
						continue
					elif [[ "$(vercmp $pkgInAll $pkg)" -eq 0 ]]; then
						continue
					fi
				done
			fi
		done
		popd >/dev/null 2>&1 || return
	done
	shopt -u nullglob # disable suppress error message of a command
}
export -f removeoldpkgchili
export -f chili-removeoldpkgchili

chili-calc() {
	awk 'BEGIN { printf "%.'${2:-0}'f\n" '"$1"'}'
}

chili-copiapkg() { copiapkg "$@"; }

copiapkg() {
	for letra in {a..z}; do
		log_info_msg "Copiando arquivos iniciados com a letra: $letra para diretorio /github/ChiliOS/packages/$letra/"
		sudo cp $letra* /github/ChiliOS/packages/$letra/ &>/dev/null
		#		sudo cp $letra* /var/cache/fetch/archives/ &>/dev/null
		#		log_info_msg "Copiando arquivos iniciados com a letra: $letra para diretorio /mnt/c/github/ChiliOS/packages/$letra/"
		#		cp $letra* /mnt/c/github/ChiliOS/packages/$letra/ &>/dev/null
		evaluate_retval
	done
}

dw() {
	if pacman -Sw "$@" --noconfirm --quiet; then
		paccache -k1 -r
		fetch -Sa "$@" -f
	fi
}
export -f dw

# Make your directories and files access rights sane.
sanitize() {
	chmod -R u=rwX,g=rX,o= "$@"
}

sc1() {
	pid=$(cat /run/$1.pid 2>/dev/null)
	if [ -n "${pid}" ]; then
		statusproc /usr/sbin/$1
	else
		service $1 start
	fi
}

chili-services() {
	local idx=0
	local adir=
	local adaemon=

	servers=('sshd' 'unbound' 'nginx' 'cups')
	dirs=('/run' '/run' '/run' '/run/cups')
	daemons=('sshd' 'unbound' 'nginx' 'cupsd')

	for srv in "${servers[@]}"; do
		adir=${dirs[$idx]}
		adaemon=${daemons[$idx]}
		pid=$(cat $adir/$adaemon.pid 2>/dev/null)
		if [ -n "${pid}" ]; then
			statusproc /usr/sbin/$srv
		else
			service $srv start
		fi
		((idx++))
	done
}
export -f chili-services
alias services=chili-services

renane() {
	for f in $1; do
		mv "$f" ${f/$1/$2 }
	done
}
export -f renane

zerobyte() {
	for f in "${1[@]}"; do echo >"$f"; done
}
export -f zerobyte

xwinserver() {
	export LIBGL_ALWAYS_INDIRECT
	export WSL_VERSION
	export WSL_HOST
	export DISPLAY

	# Windows XSrv config
	export "$(dbus-launch)"
	LIBGL_ALWAYS_INDIRECT=1
	WSL_VERSION=$(wsl.exe -l -v | grep -a '[*]' | sed 's/[^0-9]*//g')
	WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
	DISPLAY=$WSL_HOST:0
}
export -f xwinserver

chili-pkgsemdesc() {
	local nconta=0

	for letra in {a..z}; do
		pushd /github/ChiliOS/packages/$letra/ &>/dev/null || return
		for i in *.zst; do
			if ! test -e $i.desc; then
				((nconta++))
				printf "%s\n" "${red}%04d ${yellow}$i" $nconta
			fi
		done
		popd &>/dev/null || return
	done
	printf "%s\n" "${green}Done!"
}
export -f chili-pkgsemdesc

chili-makeramdrive() {
	sudo modprobe zram >/dev/null
	sudo umount -f /dev/ram0 >/dev/null
	[ ! -e /dev/ram0 ] && mknod -m 0777 /dev/ram0 b 1 0 >/dev/null
	[ ! -e /dev/ram0 ] && dd if=/dev/zero of=/dev/ram0
	[ ! -d /run/ramdrive ] && mkdir -p /run/ramdrive >/dev/null
	mkfs.ext4 -F /dev/ram0 -L RAMDRIVE
	mount /dev/ram0 /run/ramdrive
	ln -sf /run/ramdrive /rafunction sh_m

	#vgcreate VG0 /dev/ram0
	#vgextend VG0 /dev/ram1
	#lvcreate -L 8G -n DADOS VG0
	#mkfs.ext4 /dev/mapper/VG0-DADOS
	#mount /dev/mapper/VG0-DADOS /run/ramdrive
}
export -f chili-makeramdrive

#Criando um novo repositório por linha de comando
makegit() { chili-makegitcodeberg "$@"; }
chili-makegitcodeberg() {
	touch README.md
	git init
	git checkout -b main
	git add README.md
	git commit -m "first commit"
	git remote add origin https://codeberg.org/vcatafesta/chili.git
	git push -u origin main
}

#Realizando push para um repositório existente por linha de comando
makepush() { chili-makepush "$@"; }
chili-makepush() {
	git remote add origin https://codeberg.org/vcatafesta/chili.git
	git push -u origin main
}

ssherror() { chili-correctionssherror "$@"; }
chili-correctionssherror() {
	{
		echo -n 'Ciphers '
		ssh -Q cipher | tr '\n' ',' | sed -e 's/,$//'
		echo
		echo -n 'MACs '
		ssh -Q mac | tr '\n' ',' | sed -e 's/,$//'
		echo
		echo -n 'HostKeyAlgorithms '
		ssh -Q key | tr '\n' ',' | sed -e 's/,$//'
		echo
		echo -n 'KexAlgorithms '
		ssh -Q kex | tr '\n' ',' | sed -e 's/,$//'
		echo
	} >>~/.ssh/config
}

hsync() { chili-hsync "$@"; }
chili-hsync() {
	rsync --progress -Cravzp --rsh='ssh -l u356719782 -p 65002' \
		/github/ChiliOS/packages/core/ \
		u356719782@185.211.7.40:/home/u356719782/domains/chililinux.com/public_html/packages/core/
}
export -f chili-hsync

sh_ascii-lines() {
	if [[ "$LANG" =~ 'UTF-8' ]]; then
		export NCURSES_NO_UTF8_ACS=0
	else
		export NCURSES_NO_UTF8_ACS=1
	fi
}

chili-mountmazon() {
	cd /root/tmp/ || return
	if losetup -P -f --show mazon.img; then
		mount /dev/loop11p4 /mnt/tmp
		cd /mnt/tmp || return
		ls -la
	fi
}

chili-mountvoid() {
	if losetup -P -f --show /root/tmp/void.img; then
		losetup
	fi
}

virtualbox-add-nic() {
	for nic in {2..10}; do
		VBoxManage modifyvm "chr" --nic$nic bridged --nictype$nic 82540EM --bridgeadapter$nic enp6s0
	done
}

fcopy() {
	find . -name "*$1*" -exec cp -v {} /tmp \;
}

glibc-version() {
	ldd --version
	ldd "$(which ls)" | grep libc
	/lib/libc.so.6
}
export -f glibc-version

chili-mkfstab() {
	#cp /proc/mounts >> /etc/fstab
	sed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ --table-right PASS,FREQ
}

chili-mapadd() { sudo kpartx -uv $1; }
chili-mapdel() { sudo kpartx -dv $1; }

fid() {
	if [ $# -eq 0 ]; then
		echo 'Uso: fid "*.c"'
		echo '     fid "*"'
		find . -iname "*" -type f | wc -l
		return
	fi
	filepath=$1
	#	echo Arquivos: $(ls -la |grep '^-'|wc -l)"
	find . -iname "$filepath" -type f | wc -l
}

ff() {
	local filepath=$1
	local num_arquivos=$2
	local intervalo=$3
	local resultado

	if [ $# -eq 0 ]; then
		filepath='*.*'
	fi

	local find_command="sudo find . -type d -name .git -prune -o -type f,l -iname '$filepath'"

	if [[ -n "$intervalo" ]]; then
		find_command+=" -mmin -${intervalo}"
	fi

	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	find_command+=" -printf \"$format_string\" | sort"

	if [[ -n "$num_arquivos" ]]; then
		find_command+=" | tail -n $num_arquivos"
	fi

	resultado=$(eval "$find_command")
	echo "=== Resultado ==="
	echo "$resultado" | nl
	echo "=== Parâmetros informados ==="
	echo "Searching              : ${green}($find_command)${reset}"
	echo "Padrão             (\$1): ${filepath}"
	echo "Número de arquivos (\$2): ${num_arquivos:-Todos}"
	echo "Intervalo de tempo (\$3): ${intervalo:-Todos} (minutos)"
	echo "Uso: ${red}ff "*.c"${reset} or ${red}ff "*.c" 10 | xargs commando${reset} or ${red}ff "*.c" | xargs cp -v /tmp${reset}"
}

ffTesting() {
	local filepath
	local num_arquivos
	local intervalo
	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	local resultado

	set -f # Desabilita temporariamente a expansão de caminhos
#	filepath="${@:1:1}"
#	num_arquivos="${@:2:1}"
#	intervalo="${@:3:1}"
	filepath="${*:1:1}"
	num_arquivos="${*:2:1}"
	intervalo="${*:3:1}"

	[[ $# -eq 0 ]] && filepath=('*.*')
#	local find_command="sudo find . -type f,l -iname '${filepath[@]}' "
	local find_command="sudo find . -type f,l -iname '${filepath[*]}' "
	[[ -n "$intervalo" ]] && find_command+=" -mmin -${intervalo}"
	find_command+=" -printf \"$format_string\" | sort"
	[[ -n "$num_arquivos" ]] && find_command+=" | tail -n ${num_arquivos}"
	echo "${green}Searching : ($find_command)${reset}"
	resultado=$(eval "$find_command")
	echo "=== Resultado ==="
	echo "$resultado" | nl
	echo "=== Parâmetros informados ==="
	echo "Padrão             (\$1): $filepath"
	echo "Número de arquivos (\$2): ${num_arquivos:-Todos}"
	echo "Intervalo de tempo (\$3): ${intervalo:-Todos} (minutos)"
	echo "Uso: ${red}ff "*.c"${reset} or ${red}ff "*.c" 10 | xargs commando${reset} or ${red}ff "*.c" | xargs cp -v /tmp${reset}"
	set +f # Habilita a expansão de caminhos novamente
}

ffOLD() {
	local filepath=$1
	if [ $# -eq 0 ]; then
		filepath='*'"$*"'*'
		#sudo find . -type f -iname '*'"$*"'*' -ls
	fi
	#sudo find . -type f,l -name "$filepath" -ls
	#sudo find . -type f,l -iname "$filepath" -exec ls -ld --color=auto {} \;
	sudo find . -type f,l -iname "$filepath" -exec ls -ld --color=auto {} +
	echo
	echo "Uso: ${red}ff "*.c"${reset} or ${red}ff "*.c" | xargs commando${reset} or ${red}ff "*.c" | xargs cp -v /tmp${reset}"
}

ffe() {
	[ "$1" ] || {
		echo "Uso: ffe 'grep search'   | xargs comando"
		echo "     ffe 'grep search"
		echo "     ffe 'executable' | xargs rm -fv"
		echo "     ffe 'ELF|ASCII|MP4' | xargs rm -fv"
		echo "     ffe 'ELF|ASCII|MP4' | xargs cp -v /tmp"
		return
	}
	#	sudo find . -type f,d,l -exec file {} + | grep -iE '(jpe?g|jpg|wav|mp3|MPEG)' | cut -d: -f1
	sudo find . -type f,d,l -exec file {} + | grep -iE "($1)" | cut -d: -f1
}

ffs() {
	[ "$1" ] || {
		echo "Uso: ffs 'search' '*.doc' | xargs comando"
		echo "     ffs 'def |function ' '*.prg'"
		echo "     ffs '#include' '*.*'"
		echo "     ffs 'search|search|texto' '*.txt' | xargs rm -fv"
		echo "     ffs 'ELF|ASCII|MP4' '*.doc' | xargs cp -v /tmp"
		return
	}
	#	sudo find . -type f -iname '*'"$2"'*' -exec grep --text -iE "($1)" {} +;
	#	sudo grep -r --color=auto -n -iE "($1)" $2;
	#	sudo find . -type d -name bcc-archived -prune -o -type f -iname '*'"$2"'*' -exec grep --color=auto -n -iE "($1)" {} +;
	sudo find . -type d -name bcc-archived -prune -o -type f \( -iname '*'"$2"'*' -and ! -iname '*.pot' -and ! -iname '*.mo' -and ! -iname '*.po' \) -exec grep --color=auto -n -iE "($1)" {} +
}

chili-fft() {
	local num_arquivos=$1
	local intervalo=$2
	local find_command="find . -type d -name .git -prune -o -type f"
	local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
	local resultado

	if [[ -n "$intervalo" ]]; then
		find_command+=" -mmin -${intervalo}"
		#    else
		#        # Se o intervalo não foi fornecido, use -mtime -1 para listar os arquivos do último dia
		#       find_command+=" -mtime -1"
	fi

	find_command+=" -printf \"$format_string\" | sort"

	if [[ -n "$num_arquivos" ]]; then
		# Se num_arquivos foi fornecido, use tail -n para exibir somente os últimos arquivos
		find_command+=" | tail -n $num_arquivos"
	fi

	resultado=$(eval "$find_command")
	echo "=== Resultado ==="
	echo "$resultado" | nl
	echo "=== Parâmetros passados ==="
	echo "Intervalo de tempo: ${intervalo:-Todos}"
	echo "Número de arquivos: ${num_arquivos:-Todos}"
}
export -f chili-fft
alias fft=chili-fft

chili-xcopyr() {
	local args=("$@") # Coloca todos os argumentos em um array

	if [ "${#args[@]}" -lt 2 ]; then
		echo "Descrição: Esta função copia arquivos e diretórios da origem para o destino preservando a estrutura de diretórios."
		echo -e "\e[1;31mErro: Esta função requer exatamente dois parâmetros: origem e destino.\e[0m"
		echo "   Uso: xcopyr <origem> <destino>"
		echo "        xcopyr *.log   /lixo/archived"
		echo "        xcopyr .       /lixo/archived"
		echo "        xcopyr $HOME/files/.  /lixo/archived"
		return 1
	fi
#	local origem="${@:1:$#-1}" # Todos os parâmetros exceto o último são a origem
#	local destino="${@: -1}"   # Último parâmetro é o destino
	local origem="${*:1:$#-1}" # Todos os parâmetros exceto o último são a origem
	local destino="${*: -1}"   # Último parâmetro é o destino
	set -f                     #Desabilita temporariamente a expansão de caminhos
	eval "rsync -av --progress --remove-source-files --relative $origem \"$destino\""
	set +f # Habilita a expansão de caminhos novamente
}
export -f chili-xcopyr
alias xcopyr=chili-xcopyr

chili-xcopyc() {
	local args=("$@") # Coloca todos os argumentos em um array

	if [ "${#args[@]}" -lt 2 ]; then
		echo "Descrição: Esta função copia arquivos e diretórios da origem para o destino preservando a estrutura de diretórios."
		echo -e "\e[1;31mErro: Esta função requer exatamente dois parâmetros: origem e destino.\e[0m"
		echo "   Uso: xcopyc <origem> <destino>"
		echo "        xcopyc *.log   /lixo/archived"
		echo "        xcopyc .       /lixo/archived"
		echo "        xcopyc $HOME/files/.  /lixo/archived"
		return 1
	fi
#	local origem="${@:1:$#-1}" # Todos os parâmetros exceto o último são a origem
#	local destino="${@: -1}"   # Último parâmetro é o destino
	local origem="${*:1:$#-1}" # Todos os parâmetros exceto o último são a origem
	local destino="${*: -1}"   # Último parâmetro é o destino
	set -f                     #Desabilita temporariamente a expansão de caminhos
	eval "rsync -av --perms --progress --relative $origem \"$destino\""
	set +f # Habilita a expansão de caminhos novamente
}
export -f chili-xcopyc
alias xcopyc=chili-xcopyc

chili-ccp() {
    local filepath="$1"
    local diretorio_destino="$2"
    local total_bytes=0

    if [ $# -eq 0 ]; then
        echo "Uso: ccp <padrão_do_arquivo> <diretório_destino>"
        return 1
    fi

    if [ -z "$filepath" ]; then
        filepath='*.*'
    fi

    local find_command="find . -type d -iname .git -prune -o -type f -iname '$filepath' -exec cp {} \"$diretorio_destino\" \\; -exec du -sb {} +"
    local format_string="\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n"
    find_command+=" -printf \"$format_string\""
    resultado=$(eval "$find_command" 2>&1)

    while read -r line; do
        if [[ $line =~ ^[0-9]+ ]]; then
            total_bytes=$((total_bytes + ${BASH_REMATCH[0]}))
        fi
    done <<<"$resultado"

    total_human_readable=$(numfmt --to=iec --format='%3.f' $total_bytes)

    echo "=== Resultado ==="
    echo "$resultado" | grep -vE '^[0-9]+[[:space:]]+'
    echo -e "=== Total Bytes Copiados === \033[1;31m$total_bytes bytes ($total_human_readable)\033[0m"
    echo "=== Parâmetros informados ==="
    echo -e "Padrão (\$1)               : \033[1;34m${filepath}\033[0m"
    echo -e "Diretório de Destino (\$2) : \033[1;34m${diretorio_destino}\033[0m"
    echo -e "Uso : \033[1;36mccp \"*.c\" /tmp\033[0m"
}
export -f chili-ccp
alias ccp=chili-ccp

fftOLD() {
	find . -type f -printf "\033[1;32m%TY-%Tm-%Td %TH:%TM:%TS\033[0m \033[1;34m%p\033[0m\n" | sort
}

chili-xcopynparallel() {
	#	find $1 | parallel -j+0 --dryrun cp -Rpvan {} $2
	find $1 | parallel -j+0 cp -Rpvan {} $2
}
export -f chili-xcopynparallel
alias xcopynparallel=chili-xcopynparallel

greset() {
	git checkout --orphan new_branch
	git add -A
	git commit -m "$(date) Vilmar Catafesta (vcatafesta@gmail.com)"
	git branch -D main
	git branch -m main
	git push -f origin main
	git push --set-upstream origin main
}

sh_bashrc_configure
sh_ascii-lines
setkeyboardX
GREP_OPTIONS
sh_setLogPrefix

#export PS1='\e[32;1m\u \e[33;1m→ \e[36;1m\h \e[37;0m\w\n\e[35;1m�# \e[m'
#export PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#if (( EUID != 0 )); then
##	export PS1="$green\u$yellow@$cyan\h$red in $reset\w\n#"
#   export PS1="${green}\u${yellow}@${cyan}\h${red}:\w\$(get_exit_status) ${reset}\$ "
#else
##	export PS1="$red\u$yellow@$cyan\h$red in $reset\w\n#"
#   export PS1="${red}\u${yellow}@${reverse}${orange}${reset}\h${red}:\w\$(get_exit_status) ${reset}# "
#	fi
#export PS2="\[${yellow}\]→ \[${reset}\]";
#export PS4=$'${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} '

: <<'codeberg'
#sudo kpartx -a -n /dev/mapper/vg-alfs
#sudo kpartx -a -n /dev/mapper/vg-dell
#sudo kpartx -a -n /dev/mapper/vg-slackware

#cfdisk -z /dev/sdc # escolher type LVM
#pvcreate /dev/sdc1
#pvs
#vgextend vg /dev/sdc1

#vgcreate vg /dev/sdc1
#vgs

#lvcreate -l 100%FREE -n lv1 vg
#lvs

#necessario formatar só o primeiro disco
#mkfs.xfs /dev/mapper/data-lv1
#mkfs.ext4 /dev/mapper/data-lv1

#lvcreate --name mysql --size 25G lfs-lvm
#lvcreate -L32G -n chili vg
#lvcreate -L42G -n gentoo vg /dev/sda1
#lvextend -L+20G /dev/vg/iso -r
#lvextend -L+10G /dev/data/lv1 -r
#lvextend /dev/data/lv1 /dev/sdc1
#vgextend vg /dev/sdc1
#mount /dev/mapper/data-lv1 /mnt
#resize2fs /dev/mapper/data-lv1
#xfs_growfs /mnt
#
#lvresize -L 100G /dev/data/lv1

#A maneira mais simples de corrigir o GPT de backup é:
# sgdisk -e /dev/sda

#raid btrfs
#mkfs.btrfs -d raid1 -m RAID1 /dev/sdx1 /dev/sdy1

#lvreduce -L -2.5G -r /dev/vg00/vol_projects
#lvextend -l +100%FREE -r /dev/vg00/vol_backups
#lvextend -L +20G -r /dev/vg/alfs

#resize btrfs
#lvextend -L52G /dev/vg/base
#btrfs filesystem resize +10G /mnt
#btrfs filesystem resize -4g /mnt
#btrfs filesystem resize 20g /mnt
#btrfs filesystem resize max /mnt

# Indo direto ao assunto mova todos os blocos em uso do disco problemático com o comando pvmove, assim (considerando que /dev/sdc1 é a partição do disco danificado que está no LVM):
#pvmove -v /dev/sdc1 								# Note que este procedimento poderá levar muitos minutos, ou até algumas horas (um disco com 500GB de partição levou cerca de 1h e 30m).
#vgreduce vg /dev/sdc1								# Em seguida remova o disco do grupo de volumes com o comando vgreduce (considerando que VirtualMachine é o grupo com o disco problemático):
#pvremove /dev/sdc1									# Informe ao LVM que o disco em questão não faz parte mais do “sistema LVM”.
#vgextend pool /dev/sdc1 --restoremissing   # LVM - Missing device reappeared but still missing
#vgreduce --removemissing vg --force
#sudo pacman -Fyx libcrypto.so.3

#renomeando nome do VG
#sudo vgdisplay
#sudo vgchange -an nome_atual_do_vg
#sudo vgrename nome_atual_do_vg novo_nome_do_vg
#sudo vgchange -ay novo_nome_do_vg
#sudo vgdisplay

#Para montar um volume de grupo (VG) em um ambiente chroot, você precisará seguir os seguintes passos:
#vgchange -ay nome_do_vg
#mount /dev/nome_do_vg/root_lv /mnt
#mount /dev/nome_do_vg/home_lv /mnt/home
#mount /dev/nome_do_vg/var_lv /mnt/var
#swapon /dev/nome_do_vg/swap_lv

:<<'como remover um disco danificado do VG'
Se um disco em um volume de grupo (VG) estiver danificado ou falhando, você precisará removê-lo
do VG antes de poder substituí-lo por um novo disco. Para remover um disco danificado do VG, você pode seguir os seguintes passos:

1	Identifique o disco que está danificado executando o comando "sudo vgdisplay nome_do_vg" no terminal,
substituindo "nome_do_vg" pelo nome do VG em questão. Na saída do comando, verifique a seção "PV Name" para encontrar o caminho do dispositivo do disco danificado.
2	Desative o VG executando o comando "sudo vgchange -an nome_do_vg" no terminal, substituindo "nome_do_vg" pelo nome do VG.
3	Remova o disco danificado do VG executando o comando "sudo vgreduce nome_do_vg caminho_do_disco_danificado" no terminal,
substituindo "nome_do_vg" pelo nome do VG e "caminho_do_disco_danificado" pelo caminho do dispositivo do disco danificado encontrado no passo 1.
4Verifique se o disco danificado foi removido com sucesso do VG executando o comando "sudo vgdisplay nome_do_vg" novamente no terminal.
5	Se você tiver substituído o disco danificado por um novo disco, adicione-o ao VG executando o comando "sudo pvcreate caminho_do_novo_disco" no terminal,
substituindo "caminho_do_novo_disco" pelo caminho do dispositivo do novo disco.
6	Adicione o novo disco ao VG executando o comando "sudo vgextend nome_do_vg caminho_do_novo_disco" no terminal, substituindo "nome_do_vg" pelo nome do VG
e "caminho_do_novo_disco" pelo caminho do dispositivo do novo disco.
7	Verifique se o novo disco foi adicionado com sucesso ao VG executando o comando "sudo vgdisplay nome_do_vg" novamente no terminal.
8	Ative o VG novamente executando o comando "sudo vgchange -ay nome_do_vg" no terminal.
WARNING: Lembre-se de que, ao remover um disco de um VG, você pode perder dados se não tiver um backup adequado. Certifique-se de entender completamente as
implicações antes de realizar qualquer operação em volumes de grupo ou volumes lógicos. Além disso, certifique-se de ter um backup atualizado de seus
dados antes de fazer qualquer alteração em seus discos ou volumes.
'como remover um disco danificado do VG'
#sudo vgdisplay nome_do_vg
#sudo vgchange -an nome_do_vg

#vgcreate vc /dev/sdb
#lvcreate --type thin-pool -n ThinPool -l 95%FREE vc
#lvcreate -n lv1 -V 30G --thinpool ThinPool vc

:<<'como remover um disco faltante do VG'
Se um disco estiver faltando em um volume de grupo (VG), isso significa que o disco não está mais disponível no sistema. Nesse caso, você pode remover o disco faltante do VG executando os seguintes passos:
    Identifique o disco faltante executando o comando "sudo vgdisplay nome_do_vg" no terminal, substituindo "nome_do_vg" pelo nome do VG em questão. Na saída do comando, verifique a seção "PV Name" para encontrar o caminho do dispositivo do disco faltante.
    Desative o VG executando o comando "sudo vgchange -an nome_do_vg" no terminal, substituindo "nome_do_vg" pelo nome do VG.
    Remova o disco faltante do VG executando o comando "sudo vgreduce --removemissing nome_do_vg" no terminal, substituindo "nome_do_vg" pelo nome do VG.
    Verifique se o disco faltante foi removido com sucesso do VG executando o comando "sudo vgdisplay nome_do_vg" novamente no terminal.
    Se você tiver um disco de substituição, adicione-o ao VG executando o comando "sudo pvcreate caminho_do_novo_disco" no terminal, substituindo "caminho_do_novo_disco" pelo caminho do dispositivo do novo disco.
    Adicione o novo disco ao VG executando o comando "sudo vgextend nome_do_vg caminho_do_novo_disco" no terminal, substituindo "nome_do_vg" pelo nome do VG e "caminho_do_novo_disco" pelo caminho do dispositivo do novo disco.
    Verifique se o novo disco foi adicionado com sucesso ao VG executando o comando "sudo vgdisplay nome_do_vg" novamente no terminal.
    Ative o VG novamente executando o comando "sudo vgchange -ay nome_do_vg" no terminal.
Lembre-se de que, ao remover um disco faltante de um VG, você pode perder dados se não tiver um backup adequado. Certifique-se de entender completamente as implicações antes de realizar qualquer operação em volumes de grupo ou volumes lógicos. Além disso, certifique-se de ter um backup atualizado de seus dados antes de fazer qualquer alteração em seus discos ou volumes.
:<<'como remover um disco faltante do VG'

# pihole
#stat -c "sudo chmod %a %n" /etc/pihole/* | column -t
#stat -c "sudo chown %U:%G %n" /etc/pihole/* | column -t
#stat -c "sudo chmod %a %n" /etc/pihole/* | column -t
#stat -c "%U:%G %a %n" /etc/pihole/* | column -t
#ps -o uid,user,gid,group,pid,cmd -C nginx

#network
#ip link show
#1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
#    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
#       link/ether ff:ff:ff:ff:ff:ff brd ff:ff:ff:f

# cp -R /etc/sv/dhcpcd-eth0 /etc/sv/dhcpcd-enp3s0
# sed -i 's/eth0/enp3s0/' /etc/sv/dhcpcd-enp3s0/run
# ln -s /etc/sv/dhcpcd-enp3s0 /var/service/

# /etc/rc.local
# ip link set dev eth0 up
# ip addr add 192.168.1.2/24 brd + dev eth0
# ip route add default via 192.168.1.1
#ip link set dev enp1s0f1 up
# enp1s0f1

# xbps-install wpa_supplicant
# xbps-install -S dhcpcd
# wpa_passphrase <MYSSID> <passphrase> >> /etc/wpa_supplicant/wpa_supplicant-<device_name>.conf
# ln -s /etc/sv/dhcpcd         /var/service/dhcpcd
# ln -s /etc/sv/wpa_supplicant /var/service/wpa_supplicant
# sv start dhcpcd
# sv start wpa_supplicant
# nmtui

Se você deseja redefinir todos os commits antigos em seu repositório Git, pode seguir as seguintes etapas:
    Abra o terminal e navegue até o diretório do seu repositório Git.
    Certifique-se de que não há alterações não salvas em seu repositório usando o comando git status.
    Execute o comando git log para visualizar o histórico de commits e anote o hash do commit mais antigo que deseja manter.
    Execute o comando git reset --hard <hash_do_commit> para redefinir seu branch para esse commit específico e descartar todos os commits anteriores.
    Isso também descarta todas as alterações não salvas em seu repositório.
    Use o comando git push --force para atualizar o branch remoto com as alterações redefinidas.
Observe que, ao usar o comando git reset --hard, você perderá permanentemente todos os commits e alterações após o commit especificado,
portanto, faça isso com cuidado e verifique se você tem um backup de suas alterações, se necessário. Além disso, tenha em mente que essa 
ação pode afetar outros colaboradores do repositório se você estiver trabalhando em um projeto em equipe, então certifique-se de comunicar claramente suas intenções com seus colegas de equipe.

Para deixar apenas o último commit no repositório GitHub,
você precisará realizar algumas etapas.
No entanto, tenha em mente que isso irá reverter o histórico do seu repositório e
excluir permanentemente todos os commits anteriores.
Aqui está o procedimento básico para realizar essa ação:
	Certifique-se de ter um backup do seu repositório atual,
caso deseje preservar o histórico de commits. Você pode fazer isso clonando o repositório em um local diferente no seu computador.
    Abra o terminal ou prompt de comando e navegue até o diretório do seu repositório clonado.
    Execute os seguintes comandos na sequência:

#git checkout --orphan new_branch
#git add -A
#git commit -m "Initial commit"
#git branch -D master
#git branch -m master
#git push -f origin master
#git push --set-upstream origin master

Esses comandos criarão um novo branch órfão chamado "new_branch",
moverão todos os arquivos atuais para esse novo branch, criarão um novo commit inicial e,
em seguida, renomearão o branch para "master". Por fim, eles forçarão o push das alterações para o repositório remoto.

Após executar esses comandos, o seu repositório GitHub conterá apenas o último commit.
Certifique-se de ter um backup adequado do histórico anterior, pois não será possível recuperá-lo após esse procedimento.

Lembre-se de que essa ação é irreversível, então tome cuidado ao executá-la.


#ATUALIZAR FORK COM MAIN
Para atualizar um fork de um repositório no GitHub sem perder seus commits atuais, você precisará realizar alguns passos básicos. Aqui está um guia passo a passo para ajudá-lo:
    Abra o terminal em seu ambiente de desenvolvimento ou use o Git Bash, se estiver no Windows.
    Navegue até o diretório do projeto local, onde você clonou seu fork usando o comando cd <diretório>.
    Adicione o repositório original como um novo remote. Isso permitirá que você sincronize as alterações do repositório original com seu fork. Você pode fazer isso executando o seguinte comando no terminal:
git remote add upstream <URL_do_repositório_original>
	Substitua <URL_do_repositório_original> pela URL do repositório original que você fez o fork.
	Verifique se o remote foi adicionado corretamente, executando o seguinte comando:
git remote -v
	Você deverá ver o origin apontando para o seu fork e o upstream apontando para o repositório original.
	Atualize seu repositório local com as últimas alterações do repositório original usando o comando fetch:
git fetch upstream
	Isso buscará todas as branches e commits mais recentes do repositório original.
	Mude para a branch principal do seu fork (normalmente chamada de master ou main), executando o seguinte comando:
git checkout master
	Substitua master pelo nome da branch principal do seu fork, caso ela tenha outro nome.
	Mescle as alterações do repositório original em seu fork usando o comando merge:
git merge upstream/main
	Novamente, substitua master pelo nome da sua branch principal, se necessário.
	Resolva quaisquer conflitos de merge que possam surgir. O Git tentará mesclar automaticamente as alterações, mas se houver conflitos, você precisará resolvê-los manualmente. Abra os arquivos afetados em um editor de código, localize as seções com conflitos e faça as alterações necessárias para corrigi-los.
	Após resolver todos os conflitos, adicione as alterações mescladas usando o comando git add:
git add .
	Isso adicionará todas as alterações ao stage para que elas sejam incluídas no próximo commit.
	Faça um commit das alterações mescladas usando o comando git commit:
git commit -m "Atualizar fork com as alterações mais recentes"
	Substitua a mensagem de commit pelo texto que descreve as alterações feitas.
	Por fim, envie as alterações para o seu fork no GitHub usando o comando git push:
git push origin main
#ATUALIZAR FORK COM MAIN

WARNING: ignoring metadata seqno 185 on /dev/sdb1 for seqno 186 on /dev/sda1 for VG vg.
WARNING: Inconsistent metadata found for VG vg.
See vgck --updatemetadata to correct inconsistency.
WARNING: outdated PV /dev/sdb1 seqno 185 has been removed in current VG vg seqno 186.
See vgck --updatemetadata to clear outdated metadata.
WARNING: wiping mda on outdated PV /dev/sdb1
WARNING: wiping header on outdated PV /dev/sdb1

┌──(🦾vcatafesta@chililinux)-/chili/lua]✔
└─$ sudo vgck --updatemetadata vg

codeberg

chili-bridge-normal() {
	ip link
	ip link set eth0 down
	ip link set eth1 down

	brctl addbr br0
	brctl addif br0 eth0
	brctl addif br0 eth1

	ip link set br0 up
	ip link set eth0 up
	ip link set eth1 up
}

chili-bridge-wlan-virtual() {
	ip link

	brctl addbr br0
	ip link set br0 up

	ip link add link wlan0 dev macvlan0 type macvlan mode bridge
	ip link set macvlan0 up

	brctl addif br0 macvlan0

	#remover wlan-virtual
	#sudo ip link set macvlan0 down
	#sudo ip link delete macvlan0
}

#ubnt
#/etc/sysinit
plugin_start() {
	brctl addbr "br0"
	brctl setfd "br0" 1
	brctl stp "br0" 1
	brctl setbridgeprio "br0" 65535
	brctl addif "br0" "eth0"
	brctl addif "br0" "ath0"

	echo 0 >/sys/class/net/br0/bridge/group_fwd_mask
	for f in /proc/sys/net/bridge/bridge-nf-*; do echo 0 >${f}; done
	true
}

plugin_stop() {
	ifconfig "br0" down
	brctl delbr br0
	true
}

chili-conf-tty8() {
	sudo usermod -aG tty $USER
	sudo chmod g+rw /dev/tty8
	groups
}

cpc() {
	origem=$(cut -d':' -f1 <<<"$1")
	destino=$(awk -F'/usr' '{print "/usr"$2}' <<<"$1" | cut -d':' -f1)
	sudo cp -v $origem $destino
}
export -f cpc

chili-qemu-img-resize-raw() {
	if test $# -ge 1; then
		qemu-img info $1
		echo '######################################'
		qemu-img resize -f raw $1 $2
		echo '######################################'
		qemu-img info $1
		echo "	Use 'cfdisk $1', para redimensionar o tamanho da partição"
		echo "	Após 'losetup -P -f $1', para disponibilizar o device"
		echo "	Após, execute 'e2fsck -f /dev/sdXn' primeiro."
		echo "	por fim use 'resize2fs /dev/sdXn' para ajustar tamanho."
	else
	cat <<EOF
usage:
	chili-qemu-img-resize-raw <file.img> <size>
	chili-qemu-img-resize-raw gnuzinho.img +5G
EOF
	fi
}
export -f chili-qemu-img-resize-raw

mkspkg() {
    prg="$1"
    if test $# -ge 1; then
        [[ -d "$prg" ]] && {
            log_err "${red}error: ${reset}Diretorio ${cyan}'$1'${reset} já existe. Abortando..."
            return
        }
        [[ -e "spkgbuild" ]] && {
            log_err "${red}error: ${reset}Arquivo ${cyan}'spkgbuild'${reset} já existe. Abortando..."
            return
        }
    fi
    pkg=$prg
    directory="${PWD##*/}"
    if ! [[ "$directory" = "$prg" ]]; then
        log_msg "Aguarde, criando diretorio ${cyan}'$prg'${reset} on $PWD"
        mkdir -p "$prg"
    else
        prg=$PWD
    fi
    log_msg "Aguarde, criando arquivo ${cyan}'spkgbuild'${reset} on $PWD"
    cat >"$prg/spkgbuild" <<-EOF
# description   : Text document format for short documents, articles, books and UNIX man pages
# depends       :

name=$pkg
version=1.0.0
release=1
source="https://github.com/asciidoc/\$name-py3/archive/\$version/\$name-py3-\$version.tar.gz"

build() {
    cd \$name-\$version
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc
    make
    make DESTDIR=\$PKG install
}
EOF
    log_msg "Feito! diretorio ${cyan}'$prg' ${reset}criado on $PWD"
    log_msg "Feito! arquivo ${cyan} '$prg/spkgbuild' ${reset}criado on $PWD"
}
