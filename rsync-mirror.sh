#!/usr/bin/env bash
#shellcheck disable=SC2034,SC2154,SC2155
#
#  rsync-mirror.sh
#
#  Created: 2022/11/25
#  Altered: 2023/06/06
#
#  Copyright (c) 2022-2023, Vilmar Catafesta <vcatafesta@gmail.com>
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

#debug
export PS4=$'${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} ' #  aparência do prompt de depuração (xtrace) do Bash.
#set -x						# 	habilitar o modo "verbose" (debug)
#set -e						#	habilitar o modo "exit immediately" caso algum comando falhe
shopt -s extglob       	#	habilitar a extensão de padrões de correspondência (extended pattern matching)
set -m						#	ativar o modo Job Control, permite vários processos sejam executados em (background) e gerenciados de forma interativa

#system
readonly APP="${0##*/}"
readonly _VERSION_='1.0.3-20230606'
readonly DIALOG='dialog'
readonly DEPENDENCIES=(dialog cat rsync)
declare -gA Alock
declare -gA Asource_url
declare -gA Atarget
declare -i quiet=0
declare -i grafico=0
declare -i force=0
declare mirror='void'

trap "ctrlc" INT TERM QUIT SIGHUP

# disable printk
if [ -w /proc/sys/kernel/printk ]; then
	echo 0 >/proc/sys/kernel/printk
fi

function debug() {
	whiptail                   \
		--fb                    \
      --clear                 \
      --backtitle "[debug]$0" \
      --title     "[debug]$0" \
      --yesno     "${*}\n" \
   0 40
   result=$?
   if (( $result )); then
      exit
   fi
   return $result
}

function die() {
	local msg=$1; shift
	printf "  %b %s\\n" "${CROSS}" "${bold}${red}${msg}"
	exit 1
}

function sh_checkroot() {
	local str="root user check"
	if [[ "$(id -u)" != "0" ]]; then
		die "${red} error: you cannot perform this operation unless you are root."
	fi
	printf "  %b %s\\n" "${TICK}" "${str}"
	return 0
}

function sh_diahora() {
	DIAHORA=$(date +"%d%m%Y-%T" | sed 's/://g')
	printf "%s\n" "$DIAHORA"
}

function sh_lastcol() {
	local COLUMNS=$(stty size)
	local lastcol="${COLUMNS##* }"
	echo "$lastcol"
}

function sh_setvarcolors() {
	#system colors
	tput sgr0 # reset colors
	bold=$(tput bold)
	red=$(tput bold)$(tput setaf 196)
	green=$(tput setaf 2)
	pink=$(tput setaf 5)
	reset=$(tput sgr0)
	white="${bold}$(tput setaf 7)"
	black="${bold}$(tput setaf 0)"
	yellow=$(tput bold)$(tput setaf 3)
	blue=$(tput setaf 4)
	cyan=$(tput setaf 6)
	orange=$(tput setaf 3)
	purple=$(tput setaf 125);
	violet=$(tput setaf 61);

   COL_NC='\e[0m' # No Color
   COL_LIGHT_GREEN='\e[1;32m'
   COL_LIGHT_RED='\e[1;31m'
   TICK="${white}[${COL_LIGHT_GREEN}✓${COL_NC}${white}]"
   CROSS="${white}[${COL_LIGHT_RED}✗${COL_NC}${white}]"
   INFO="[i]"
   # shellcheck disable=SC2034
   DONE="${COL_LIGHT_GREEN} done!${COL_NC}"
   OVER="\\r\\033[K"
   DOTPREFIX="  ${black}::${reset} "
}

function sh_unsetvarcolors() {
	log_msg "Disabling color mode"
	unset bold reset cyan red blue white black
	unset green yellow orange pink cyan purple violet
}

function sh_setconfig() {
	readonly BOOTLOG="/tmp/$APP-$(sh_diahora).log"
	#http_user='nginx'
	http_user='http'

	Alock[void]="/var/lock/voidrepo.lck"
	Alock[arco]="/var/lock/arcorepo.lck"
	Alock[arch]="/var/lock/archrepo.lck"
#	Alock[slack]="/var/lock/slackrepo.lck"

	Asource_url[void]='rsync://mirrors.servercentral.com/voidlinux'
	Asource_url[arco]='rsync://ftp.belnet.be/arcolinux/'
	Asource_url[arch]='rsync://archlinux.c3sl.ufpr.br/archlinux/'
#	Asource_url[slack]='rsync://mirror.slackbuilds.org/slackware/'

	Atarget[void]='/vg/void-mirror/voidlinux'
	Atarget[arco]='/vg/arco-mirror/archlinux'
	Atarget[arch]='/vg/arch-mirror/archlinux'
#	Atarget[slack]='/vg/slack-mirror/slackware'

	bwlimit=0
	lastupdate_url=''
}

function log_msg() {
	local retval="${PIPESTATUS[0]}"
	[[ $retval -eq 0 ]] && printf "  %b %s\\n" "${TICK}" "${*}" || printf "  %b %s\\n" "${CROSS}" "${*}"
}

function sh_setUrl() {
	source_url="${Asource_url["$mirror"]}"
	target="${Atarget["$mirror"]}"
	lock="${Alock["$mirror"]}"
}

function sh_prepare() {
	echo
	[[ ! -d "$target" ]] && mkdir -p "$target" || :
	log_msg "${reset}Creating target dir : ${red}$target${reset}"

	#exec 9>"${lock}"
	#flock -n 9 || exit

#	printf "%s\n" "${reset}Cleaning            : ${pink}Cleanup any temporary files from old run that might remain.${reset}"
#  find "${target}" -name '.~tmp~' -exec rm -r {} +

	log_msg "${reset}Syncing from server : ${red}$source_url${reset}"
	log_msg "${reset}Destdir             : ${red}$target${reset}"
}

function rsync_partial() {
	local i
	local -a adir=(
			currrent
			distfiles
			docs
			live
			logos
			man
			static
			void-updates
			xlocate
		)

	for i in "${adir[@]}"
	do
		printf "%s\n" "Syncing from server : $source_url/$i"
		rsync							\
			--archive				\
			--partial				\
			--hard-links			\
			--exclude 'debug'		\
		  	--compress				\
			--info=progress2 		\
			"$source_url/$i"		\
			"$target"
	done
}
#			--exclude 'aarch64'	\
#			--exclude '*armv7l*'	\
#			--exclude '*armv6l*'	\
#			--progress				\
#			--verbose				\
#			--human-readable		\
#	  		--delete-delay			\
#			--checksum 				\

function rsync_extras() {
	source_url='/vg/void-mirror/extras/'
	local -a aTarget=('/vg/void-mirror/voidlinux/extras/' '/vg/void-mirror/voidlinux/current/extras/')

	rm "$source_url"/README >/dev/null 2>&-
	rm "$source_url"/*.pem  >/dev/null 2>&-
	for target in "${aTarget[@]}"; do
		sh_prepare
		rsync_cmd				\
			--exclude 'debug'	\
			"$source_url"		\
			"$target"
	done
	unset source_url
	unset target
}

function rsync_rootfs() {
	source_url='/vg/void-mirror/rootfs/'
	target='/vg/void-mirror/voidlinux/live/current/'

	sh_prepare
	rsync_cmd				\
		--exclude 'debug'	\
		$source_url			\
		$target

	pushd $target >/dev/null 2>&- || return 1
#	ln -sf   void-x86_64-base-minimal-20230327.tar.xz   void-x86_64-base-minimal-current.tar.xz
#	ln -sf    void-x86_64-base-system-20230327.tar.xz    void-x86_64-base-system-current.tar.xz
#	ln -sf void-x86_64-base-voidstrap-20230327.tar.xz void-x86_64-base-voidstrap-current.tar.xz
	popd >/dev/null 2>&- || return 1
	unset source_url
	unset target
}

function sh_usage() {
	cat <<EOF
${white}${APP} v$_VERSION_${reset}
${orange}usage: ${APP} ${reset}[<options>]

[<options>] ${reset}
   ${red}-m  --mirror ${green}<@(void|arco|arch|slack)>
   ${red}-d  --dryrun${cyan}
   ${red}-q  --quiet${cyan}
   ${red}-g  --grafico${cyan}
   ${red}-v  --verbose${cyan}
   ${red}-V  --version${cyan}
   ${red}-n  --nocolor${cyan}
   ${red}-h  --help${cyan}
EOF
	exit $(($# ? 0 : 1))
}

function sh_monitor() {
	if (( grafico == 0 )); then
		while kill -0 "$RSYNCPID" >/dev/null 2>&-; do
#			printf "%s\r" "Monitor rsync (PID) : ${pink}$RSYNCPID${reset}"
			printf "  %b %s\r" "${TICK}" "Monitor rsync (PID) : ${red}$RSYNCPID${reset}"
			if (( quiet )); then
				tail --pid="$RSYNCPID" -f "$log"
			fi
		done
		echo
	else
		local -i lastcol=$(sh_lastcol)
		(( lastcol -= 20 ))
		$DIALOG	   --backtitle "${APP} running - $source_url => $target" \
						--title "**RSYNC** $source_url => $target"            \
						--begin 10 10 --tailboxbg "$log" 24 "$lastcol"        \
						--and-widget                                          \
						--begin 3 10 --msgbox "Aguarde.. Sincronizando." 5 30
		#rm -f $log > /dev/null 2>&1
	fi
}

function ctrlc() {
	while kill -0 "$RSYNCPID" >/dev/null 2>&-; do
		printf "  %b %s\r" "${CROSS}" "^C killing PID      : ${red}$RSYNCPID${reset}"
		kill -9 "$RSYNCPID" >/dev/null 2>&-
	done
	# reenable printk
	if [ -w /proc/sys/kernel/printk ]; then
		echo 4 >/proc/sys/kernel/printk
	fi
	exit 1
}

function sh_checkDependencies() {
	local errorFound=0
   local cmd

   for cmd in "${DEPENDENCIES[@]}"; do
      log_msg "Checking dependencie : $cmd"
      if ! which "$cmd" &> /dev/null; then
         log_msg "ERROR: I didn't find the command '$cmd'"
         errorFound=1
      fi
   done
   if [[ "$errorFound" != "0" ]]; then
      echo "${yellow}---IMPOSSIBLE TO CONTINUE---"
      echo "${black}This script needs the commands listed above"
      echo "${black}Install them and/or make sure they are in your \$PATH"
      die "Aborted..."
   fi
}

function sh_parseparam() {
   while test $# -gt 0; do
      case $1 in
         -m|--mirror) 	mirror=$2; shift;;
         -d|--dryrun) 	dryrun=1;;
         -g|--grafico)	grafico=1; quiet=1;;
         -h|--help)		sh_usage "$@";;
         -n|--nocolor)	sh_unsetvarcolors;;
         -q|--quiet)		quiet=0;;
         -v|--verbose)	quiet=1;;
         -V|--version)	sh_usage "$@";;
         *) 				die "operação não suportada: $1 (use -h for help)" ;;
      esac
      shift
   done
}

function rsync_cmd() {
	local -a cmd=( rsync
      --chown=root:"$http_user"
      --archive
#	  	--delay-updates  						#put all updated files into place at end
#		--delete-delay          			#find deletions during, delete after
#		--delete-during          			#receiver deletes during the transfer
		--delete-before          			#receiver deletes before xfer, not during
		--delete-excluded       			#also delete excluded files from dest dirs
#		--checksum 								#skip based on checksum, not mod-time & size
		--recursive 							#recurse into directories
		--links 									#copy symlinks as symlinks
		--perms 									#preserve permissions
		--times									#preserve modification times
		--partial 								#keep partially transferred files
		--hard-links							#preserve hard links
	  	--no-motd 								#suppress daemon-mode MOTD
 		--safe-links 							#ignore symlinks that point outside the tree
		--timeout=60		        			#set I/O timeout in seconds
#		--contimeout=60		     			#set daemon connection timeout in seconds
		--mkpath                         #create destination's missing path components
	)

	if ! stty &>/dev/null; then
      cmd+=(--quiet)
   fi
   (( quiet )) 		&& cmd+=(--human-readable --verbose --progress)
	! (( quiet ))		&& cmd+=(--quiet)
   ((dryrun )) 		&& cmd+=(--dry-run)
   ((bwlimit>0))		&& cmd+=(--bwlimit="$bwlimit")

	log="/tmp/${APP}-$(sh_diahora).log"
	[ -e "$log" ] && rm -f "$log"

#   {
#		"${cmd[@]}" "$@"
#		echo
#		echo
#		echo "COPIA EFETUADA COM SUCESSO. TECLE ALGO"
#	} > "$log" &

	"${cmd[@]}" "$@" 1>&2>"$log" &
	export RSYNCPID=$!
	sh_monitor
}

function main() {
	local amirror=()

	pushd "/" >/dev/null 2>&- || return 1
	if [[ "$mirror" = "all" ]]; then
		amirror+=(void)
		amirror+=(arco)
		amirror+=(arch)
#		amirror+=(slack)
	else
		amirror+=($mirror)
	fi

	for i in "${amirror[@]}"; do
		mirror="$i"
		sh_setUrl
		sh_prepare

		# if we are called without a tty (cronjob) only run when there are changes
		if ! tty -s && [[ -f "$target/lastupdate" ]] && diff -b <(curl -Ls "$lastupdate_url") "$target/lastupdate" >/dev/null; then
			# keep lastsync file in sync for statistics generated by the Arch Linux website
			rsync_cmd "$source_url/lastsync" "$target/lastsync"
#			exit 0
			continue
		fi

		log_msg "${reset}Syncing mirror      : ${red}$i"
		case "$i" in
		void)
			rsync_cmd							\
				--compress						\
				--exclude 'debug' 			\
				--exclude '*armv7l*' 		\
				--exclude '*armv6l*' 		\
				--exclude '*i686*' 			\
				--exclude '*noarch*' 		\
				--exclude 'aarch64' 			\
				"$source_url"					\
				"$target"
#				--delete          	     	\
#				--exclude '*musl*' 			\

			rsync_extras "$@"
			rsync_rootfs "$@"
			;;
		arco)
			rsync_cmd 								\
				--compress							\
				--exclude '*.links.tar.gz*'	\
				--exclude '*.tar.gz.old'		\
				--exclude '/other'				\
				"$source_url"						\
				"$target"
				#	--exclude '/sources'				\
				#	--exclude 'iso' 					\
				#	--exclude 'images' 				\
				#	--exclude 'multilib*' 			\
				#	--exclude 'testing*' 			\
				#	--exclude 'staging*' 			\
				#	--exclude 'community*' 			\
				#	--exclude 'gnome*' 				\
				#	--exclude 'kde*' 					\
				#	--exclude 'extra*' 				\
			;;
		arch)
			rsync_cmd 								\
				--exclude '/other'				\
			   --exclude="/*debug*"          \
	      	--exclude="/*staging*"        \
	      	--exclude="/*unstable*"       \
	      	--exclude '*.links.tar.gz*'   \
	      	--exclude '*.tar.gz.old'      \
	      	--exclude '/other'            \
	      	--exclude '/sources'          \
	      	--exclude '/pool/*debug*'     \
				"$source_url"						\
				"$target"
			;;
		slack)
			rsync_cmd 								\
	     		--exclude 'slackware-2.*'     \
	      	--exclude 'slackware-3.*'     \
	      	--exclude 'slackware-4.*'     \
		      --exclude 'slackware-7.*'     \
		      --exclude 'slackware-8.*'     \
		      --exclude 'slackware-9.*'     \
		      --exclude 'slackware-10.*'    \
		      --exclude 'slackware-11.*'    \
		      --exclude 'slackware-12.*'    \
		      --exclude 'slackware-13.*'    \
		      --exclude 'slackware-14.*'    \
		      --exclude 'slackware64-13.*'  \
		      --exclude 'slackware64-14.*'  \
		      "$source_url"						\
		      "$target"
				#  --exclude="/*testing*"        \
			   #  --exclude '/sources'				\
			   #  --exclude 'iso'					\
			   #  --exclude 'images'				\
			   #  --exclude 'multilib*'			\
			   #  --exclude 'testing*'				\
			   #  --exclude 'staging*'				\
			   #  --exclude 'community*'			\
			   #  --exclude 'gnome*'				\
			   #  --exclude 'kde*'					\
			   #  --exclude 'extra*'				\
			;;
		esac
	done
	popd  >/dev/null 2>&- || return 1

#	fg 1 >/dev/null 2>&-
#	RSYNCPID=$!
#	sh_monitor $RSYNCPID
	[ -e "$target"/lastsync ] && echo "Last sync was " "$(date -d @"$(cat "$target"/lastsync)")"
}

function sh_version() {
	echo ${white}${APP} v$_VERSION_${reset}
	exit 0
}

sh_setvarcolors
sh_setconfig
#sh_parseparam "$@"

OPTIONS=m:dghnqvV
LONGOPTIONS=mirror:,dryrun,grafico,help,nocolor,quiet,verbose,version
opts=$(getopt --options=$OPTIONS --longoptions=$LONGOPTIONS --name "$0" -- "$@")
if [ $? -ne 0 ]; then
   sh_usage
fi
eval set -- "$opts"

while true; do
   case "$1" in
		-m|--mirror) 	mirror=$2; shift;;
		-n|--nocolor)	sh_unsetvarcolors;;
		-d|--dryrun) 	dryrun=1;log_msg "Enabling dryrun mode";;
		-g|--grafico)	grafico=1; quiet=1;log_msg "Enabling graphic mode";;
		-h|--help)		sh_usage "$@";;
		-q|--quiet)		quiet=0;log_msg "Enabling mode quiet";;
		-v|--verbose)	quiet=1;log_msg "Enabling verbose mode";;
		-V|--version)	sh_version "$@";;
	   --)            shift;break;;
#		*) 				sh_usage;;
#		*) 				die "operação não suportada: $1 (use -h for help)" ;;
   esac
   shift
done

if [[ -z "$mirror" || "$mirror" !=  @(void|arco|arch|slack|all) ]]; then
   sh_usage
fi
sh_checkroot
sh_checkDependencies "${DEPENDENCIES[*]}"
main "$@"
#rsync_cmd "$@"

# vim:set ts=3 sw=3 et:
