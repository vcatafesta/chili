# /etc/bash.bashrc

append_path() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*)
		PATH="${PATH:+$PATH:}$1"
		;;
	esac
}

appendpath() {
	case ":$PATH:" in
	*:"$1":*) ;;
	*)
		PATH="${PATH:+$PATH:}$1"
		;;
	esac
}

pathremove() {
	local IFS=':'
	local NEWPATH
	local DIR
	local PATHVARIABLE=${2:-PATH}
	for DIR in ${!PATHVARIABLE}; do
		if [ "$DIR" != "$1" ]; then
			NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
		fi
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

# Set the initial path
export PATH=/usr/bin

# Attempt to provide backward compatibility with LFS earlier than 11
if [ ! -L /bin ]; then
	pathappend /bin
fi

if [ $EUID -eq 0 ]; then
	pathappend /usr/sbin
	if [ ! -L /sbin ]; then
		pathappend /sbin
	fi
	unset HISTFILE
fi

# Setup some environment variables.
export HISTSIZE=1000
export HISTIGNORE="&:[bf]g:exit"

# Set some defaults for graphical systems
export XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/share/}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:-/etc/xdg/}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/tmp/xdg-$USER}

# Setup a red prompt for root and a green one for users.
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [[ $EUID == 0 ]]; then
	PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
else
	PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
fi

for script in /etc/profile.d/*.sh; do
	if [ -r $script ]; then
		. $script
	fi
done

unset script RED GREEN NORMAL

# Set our umask
umask 022

# Append "$1" to $PATH when not already in.
# This function API is accessible to scripts in /etc/profile.d

# Append our default paths
append_path '/usr/local/sbin'
append_path '/usr/local/bin'
append_path '/usr/bin'

# Force PATH to be environment
export PATH

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

unset -f append_path	# Unload our profile API functions
unset TERMCAP			# Termcap is outdated, old, and crusty, kill it.
unset MANPATH			# Man is much better than us at figuring this out

# Cores ANSI - Substitua pelos códigos ANSI do seu terminal, se necessário
GREEN="\033[1;32m"   # Verde
RED="\033[1;31m"     # Vermelho
YELLOW="\033[1;33m"  # Amarelo
BLUE="\033[1;34m"    # Azul
MAGENTA="\033[1;35m" # Magenta
CYAN="\033[1;36m"    # Ciano
RESET="\033[0m"      # Resetar as cores

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

# Alias (atalhos para comandos)
alias ll='ls -l --color=auto'
alias dir='ls -la --color=auto'
alias grep='grep --color=auto'

path() { echo -e "${PATH//:/\\n}"; }
lsd()  { printf "${orange}\n"; ls -ld */; printf "${reset}"; }
lsa()  { echo -n ${orange}; ls -l | awk '/^-/ {print $9}'; }

# Função para obter o status do último comando
function get_exit_status() {
	local status="$?"
	if [ $status -eq 0 ]; then
		echo -e "${GREEN}✔"
	else
		echo -e "${RED}✘${MAGENTA}${status}"
	fi
}

# Prompt personalizado com informações do usuário, host e caminho
if ((EUID != 0)); then
	#  export PS1="$green\u$yellow@$cyan\h$red in $reset\w\n#"
	export PS1="${GREEN}\u${YELLOW}@${CYAN}\h${RED}:\w\$(get_exit_status) ${RESET}\$ "
else
	#  export PS1="$red\u$yellow@$cyan\h$red in $reset\w\n#"
	export PS1="${RED}\u${YELLOW}@${CYAN}\h${RED}:\w\$(get_exit_status) ${RESET}# "
fi

# Configurações de ambiente
#export LANG="en_US.UTF-8"
#export LC_ALL="en_US.UTF-8"

# Outras configurações e comandos personalizados podem ser adicionados
eval $(dircolors -b /etc/.dircolors)
