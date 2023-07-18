#!/usr/bin/env bash
tput sgr0 # reset colors
bold=$(tput bold)
reset=$(tput sgr0)
black=$(tput bold)$(tput setaf 0);
red=$(tput bold)$(tput setaf 196)
green=$(tput setaf 2)
yellow=$(tput bold)$(tput setaf 3)
blue=$(tput setaf 4)
pink=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput bold)$(tput setaf 7)
orange=$(tput setaf 3)
purple=$(tput setaf 125);
violet=$(tput setaf 61);
DOTPREFIX="  ${red}::${reset} "

sh_checkroot() {
   if [[ "$(id -u)" != "0" ]]; then
      log_msg "$redYou should run this script as root!"
      exit 1
   fi
}

log_msg () {
	printf "%-100s\r" "${DOTPREFIX}${@}";
	return 0
}

sh_checkroot
for i in {1..10}; do
	log_msg "Pass $i: Desmontando /run/liveiso/bootmnt"
	umount -rl /mnt/chili-install >/dev/null 2>&-
	log_msg "Pass $i: Desmontando /run/liveiso/bootmnt"
	umount -rl /run/liveiso/bootmnt >/dev/null 2>&-
	log_msg "Pass $i: Desmontando /run/liveiso/airootfs"
	umount -rl /run/liveiso/airootfs >/dev/null 2>&-
	log_msg "Pass $i: Desmontando /dev/loop{13..60}"
	losetup -d /dev/loop{13..60} >/dev/null 2>&-
done
