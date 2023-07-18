#!/usr/bin/env bash

sh_getEfi() {
   if [ -e /sys/firmware/efi/systab ]; then
      TARGET_EFI=x86_64-efi
      [[ "$(< /sys/firmware/efi/fw_platform_size)" -eq 32 ]] && TARGET_EFI=i386-efi
      echo 0; return 0
   fi
   echo 1; return 1
}

sh_ternario() {
   local retval="$1"
#	[[ "$retval" -eq 0 ]] && { echo 1; return 1; } || { echo 0; return 0; }
	echo   $(( "$retval" ? 0 : 1 ))
	return $(( "$retval" ? 0 : 1 ))
}

LEFI=$(sh_ternario $(sh_getEfi))
echo $LEFI
