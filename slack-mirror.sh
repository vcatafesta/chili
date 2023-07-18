#!/bin/bash

config()
{
	reset=$(tput sgr0);
	green=$(tput setaf 2);
	red=$(tput setaf 124);
	pink=$(tput setaf 129);

	#debug
	export PS4=$'${red}${0##*/}${green}[$FUNCNAME]${pink}[$LINENO]${reset} '
	#set -x

	# Lockfile path
	lock="/var/lock/slackrepo.lck"

	# If you want to limit the bandwidth used by rsync set this.
	# Use 0 to disable the limit.
	# The default unit is KiB (see man rsync /--bwlimit for more)
	bwlimit=0
#	source_url='rsync://mirrors.kernel.org/slackware/'
#	source_url='rsync://slackware.cs.utah.edu/slackware/'
#	source_url='rsync://rsync.lug.udel.edu/slackware/'
#	source_url='rsync://linorg.usp.br/slackware/'
	source_url='rsync://mirror.slackbuilds.org/slackware/'

	# Directory where the repo is stored locally. Example: /srv/repo
	target="/vg/mirror-slack/slackware"

	# An HTTP(S) URL pointing to the 'lastupdate' file on your chosen mirror.
	# If you are a tier 1 mirror use: https://rsync.archlinux.org/lastupdate
	# Otherwise use the HTTP(S) URL from your chosen mirror.
	lastupdate_url=''

	#### END CONFIG
}

prepare()
{
   printf "%s\n" "${reset}Creating target dir : ${pink}$target${reset}"
   [[ ! -d "${target}" ]] && mkdir -p "${target}"

   #exec 9>"${lock}"
   #flock -n 9 || exit

   # Cleanup any temporary files from old run that might remain.
	# find "${target}" -name '.~tmp~' -exec rm -r {} +

   printf "%s\n" "${reset}Syncing from server : ${pink}$source_url${reset}"
   printf "%s\n" "${reset}Destdir             : ${pink}$target${reset}"
}

rsync_cmd()
{
	local -a cmd=( rsync
					   --archive
                 	--chown=root:http
                  --recursive
                  --links
                  --perms
                  --times
                  --hard-links
                  --safe-links
                  --delete
                  --delete-delay
                  --delay-updates
                  "--timeout=600"
                  "--contimeout=60"
                  --no-motd
                  --partial
                  --compress
	)

	if stty &>/dev/null; then
		cmd+=(--human-readable --verbose --progress)
	else
		cmd+=(--quiet)
	fi

	if ((bwlimit>0)); then
		cmd+=("--bwlimit=$bwlimit")
	fi

	"${cmd[@]}" "$@"
}

main()
{
	# if we are called without a tty (cronjob) only run when there are changes
	if ! tty -s && [[ -f "$target/lastupdate" ]] && diff -b <(curl -Ls "$lastupdate_url") "$target/lastupdate" >/dev/null; then
		# keep lastsync file in sync for statistics generated website
		rsync_cmd "$source_url/lastsync" "$target/lastsync"
		exit 0
	fi

	rsync_cmd 								\
		--exclude 'slackware-1.*'		\
		--exclude 'slackware-2.*'		\
		--exclude 'slackware-3.*'		\
		--exclude 'slackware-4.*'		\
		--exclude 'slackware-7.*'		\
		--exclude 'slackware-8.*'		\
		--exclude 'slackware-9.*'		\
		--exclude 'slackware-10.*'		\
		--exclude 'slackware-11.*'		\
		--exclude 'slackware-12.*'		\
		--exclude 'slackware-13.*'		\
		--exclude 'slackware-14.*'		\
		--exclude 'slackware64-13.*'	\
		--exclude 'slackware64-14.*'	\
		"$@" 									\
		"${source_url}"					\
		"${target}"

	#	--exclude '/sources'				\
	#	--exclude 'iso' \
	#	--exclude 'images' \
	#	--exclude 'multilib*' \
	#	--exclude 'testing*' \
	#	--exclude 'staging*' \
	#	--exclude 'community*' \
	#	--exclude 'gnome*' \
	#	--exclude 'kde*' \
	#	--exclude 'extra*' \

	#echo "Last sync was $(date -d @$(cat ${target}/lastsync))"
}

config
prepare
main "$@"
