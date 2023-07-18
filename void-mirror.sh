#!/usr/bin/env bash

trap "ctrlc" INT TERM QUIT SIGHUP

# disable printk
if [ -w /proc/sys/kernel/printk ]; then
   echo 0 >/proc/sys/kernel/printk
fi

sh_diahora() {
	DIAHORA=$(date +"%d%m%Y-%T" | sed 's/://g')
	printf "%s\n" "$DIAHORA"
}

sh_lastcol() {
	local COLUMNS=$(stty size)
	local lastcol=${COLUMNS##* }
	echo $lastcol
}

config() {
	#system
	readonly APP="${0##*/}"
	readonly _VERSION_='0.84.699-20230309'
	readonly DIALOG='dialog'

	quiet=0
	grafico=0
	reset=$(tput sgr0);
	green=$(tput setaf 2);
	red=$(tput setaf 124);
	pink=$(tput setaf 129);
	cyan=$(tput setaf 6)
	white=$(tput setaf 7)
	orange=$(tput setaf 3)

 	#Enable job control
 	set -m

	#debug
	export PS4=$'${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} '
	#set -x

	#http_user='nginx'
	http_user='http'

	#Lockfile path
	lock="/var/lock/voidrepo.lck"

	#source_url="rsync://repo-fi.voidlinux.org/voidlinux"
	#source_url="rsync://repo-de.voidlinux.org/voidlinux"
	source_url="rsync://mirrors.servercentral.com/voidlinux"
	#source_url="rsync://100.97.0.13/voidlinux"

	# Directory where the repo is stored locally. Example: /srv/repo
	target="/vg/mirror-data/voidlinux"

	# If you want to limit the bandwidth used by rsync set this.
	# Use 0 to disable the limit.
	# The default unit is KiB (see man rsync /--bwlimit for more)
	bwlimit=0

	# An HTTP(S) URL pointing to the 'lastupdate' file on your chosen mirror.
	# If you are a tier 1 mirror use: https://rsync.archlinux.org/lastupdate
	# Otherwise use the HTTP(S) URL from your chosen mirror.
	lastupdate_url=''

	#### END CONFIG
}

rsync_cmd() {
	local -a cmd=(rsync
		--chown=root:"$http_user"
#		--checksum 								#skip based on checksum, not mod-time & size
		--archive 								#archive mode is -rlptgoD (no -A,-X,-U,-N,-H)
	  	--delay-updates  						#put all updated files into place at end
		--delete-delay          			#find deletions during, delete after
#		--delete-during          			#receiver deletes during the transfer
#		--delete-before          			#receiver deletes before xfer, not during
#		--delete-excluded       			#also delete excluded files from dest dirs
		--recursive 							#recurse into directories
		--links 									#copy symlinks as symlinks
		--perms 									#preserve permissions
		--times									#preserve modification times
		--compress								#compress file data during the transfer
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
	elif (( quiet )); then
		cmd+=(--human-readable --verbose --progress)
	elif (( quiet == 0 )); then
		cmd+=(--quiet)
	fi

	if (( dryrun )); then
		cmd+=(--dry-run)
	fi

	if ((bwlimit>0)); then
		cmd+=(--bwlimit="$bwlimit")
	fi

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

main_partial() {
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
			$source_url/"$i"		\
			$target
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

rsync_extras() {
	source_url='/vg/mirror-data/extras/'
	local -a aTarget=('/vg/mirror-data/voidlinux/extras/' '/vg/mirror-data/voidlinux/current/extras/')

	for target in "${aTarget[@]}"; do
		echo
		prepare
		rsync_cmd				\
			--exclude 'debug'	\
			$source_url			\
			$target
	done
	unset source_url
	unset target
}

rsync_rootfs() {
	source_url='/vg/mirror-data/rootfs/'
	target='/vg/mirror-data/voidlinux/live/current/'

	echo
	prepare
	rsync_cmd				\
		--exclude 'debug'	\
		$source_url			\
		$target

	pushd $target >/dev/null 2>&-
	ln -sf   void-x86_64-base-minimal-20230327.tar.xz   void-x86_64-base-minimal-current.tar.xz
	ln -sf    void-x86_64-base-system-20230327.tar.xz    void-x86_64-base-system-current.tar.xz
	ln -sf void-x86_64-base-voidstrap-20230327.tar.xz void-x86_64-base-voidstrap-current.tar.xz
	popd >/dev/null 2>&-
	unset source_url
	unset target
}

prepare() {
	printf "%s\n" "${reset}Creating target dir : ${pink}$target${reset}"
	[[ ! -d "${target}" ]] && mkdir -p "${target}"

#	printf "%s\n" "${reset}locking             : ${pink}${lock}${reset}"
#	exec 9>"${lock}"
#	flock -n 9 || { printf "%s\n" "${red}error locking${reset}"; exit 1; }

	printf "%s\n" "${reset}Cleaning            : ${pink}Cleanup any temporary files from old run that might remain.${reset}"
   find "${target}" -name '.~tmp~' -exec rm -r {} +

	printf "%s\n" "${reset}Syncing from server : ${pink}$source_url${reset}"
	printf "%s\n" "${reset}Destdir             : ${pink}$target${reset}"
}

rsync_main() {
	# if we are called without a tty (cronjob) only run when there are changes
	if ! tty -s && [[ -f "$target/lastupdate" ]] && diff -b <(curl -Ls "$lastupdate_url") "$target/lastupdate" >/dev/null; then
		# keep lastsync file in sync for statistics generated
		rsync_cmd "$source_url/lastsync" "$target/lastsync"
		exit 0
	fi

	rsync_cmd 						\
		--exclude 'debug' 		\
		$source_url					\
		$target

#	fg 1 >/dev/null 2>&-
#	RSYNCPID=$!
#	sh_monitor $RSYNCPID
	[ -e ${target}/lastsync ] && echo "Last sync was " "$(date -d @"$(cat ${target}/lastsync)")"
}
#		--delete               	\
#		--exclude '*armv7l*' 	\
#		--exclude '*armv6l*' 	\
#		--exclude '*i686*' 		\
#		--exclude '*noarch*' 	\
#		--exclude '*musl*' 		\
#		--exclude 'aarch64' 		\

sh_monitor() {
	if (( grafico == 0 )); then
		while kill -0 $RSYNCPID >/dev/null 2>&-; do
			printf "%s\r" "Monitor rsync (PID) : ${pink}$RSYNCPID${reset}"
			if (( quiet )); then
				tail --pid=$RSYNCPID -f $log
			fi
		done
		echo
	else
		local -i lastcol=$(sh_lastcol)
		(( lastcol -= 20 ))
		${DIALOG}	--backtitle "${APP} running - $source_url => $target"	\
						--title "**RSYNC** $source_url => $target"				\
		        		--begin 10 10 --tailboxbg $log 24 $lastcol				\
		        		--and-widget                           					\
		        		--begin 3 10 --msgbox "Aguarde.. Sincronizando." 5 30
		#rm -f $log > /dev/null 2>&1
	fi
}

ctrlc() {
	while kill -0 $RSYNCPID >/dev/null 2>&-; do
		printf "$red%s\r" "^C Interrupt signal received - killing PID $RSYNCPID..."
		kill -9 $RSYNCPID >/dev/null 2>&-
 	done
   # reenable printk
   if [ -w /proc/sys/kernel/printk ]; then
      echo 4 >/proc/sys/kernel/printk
   fi
   exit 1
}

sh_usage() {
   cat <<EOF
${white}${APP} v$_VERSION_${reset}
${orange}usage: ${APP} ${reset}[<options>]

[<options>] ${reset}
   ${red}-d  --dryrun${cyan}
   ${red}-q  --quiet${cyan}
   ${red}-g  --grafico${cyan}
   ${red}-v  --verbose${cyan}
   ${red}-V  --version${cyan}
   ${red}-n  --nocolor${cyan}
   ${red}-h  --help${cyan}
EOF
}

parseparam() {
   while test $# -gt 0; do
      case $1 in
         -h | -H | --help)
            sh_usage
            exit $(($# ? 0 : 1))
            ;;
         -V | --version)
            sh_usage
            exit $(($# ? 0 : 1))
            ;;
         -n | --nocolor)
            sh_unsetvarcolors
            ;;
         -v | --verbose)
            quiet=1
            ;;
         -d | --dryrun)
            dryrun=1
            ;;
         -q | --quiet)
            quiet=0
            ;;
         -g | --grafico)
            grafico=1
            quiet=1
            ;;
         *) die "operação não suportada: $1 (use -h for help)" ;;
      esac
      shift
   done
}

config "$@"
parseparam "$@"
prepare "$@"
#main_partial "$@"
rsync_main "$@"
rsync_extras "$@"
rsync_rootfs "$@"

# vim:set ts=3 sw=3 et:
