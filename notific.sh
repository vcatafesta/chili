#!/bin/bash

ERR(){ echo "ERROR: $1" 1>&2; }

declare -i DEPCOUNT=0
for DEP in /usr/bin/{xdotool,yad,xprop};do
    [ -x "$DEP" ] || {
        ERR "$LINENO Dependency '$DEP' not met."
        DEPCOUNT+=1
        }
done

[ $DEPCOUNT -eq 0 ] || exit 1

VERSION=`yad --version | awk '{ print $1 }'`
verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

if verlt $VERSION 0.38.2; then
   yad --text=" The version of yad installed is too old for to run this program, \n Please upgrade yad to a version higher than 0.38.2   " \
       --button="gtk-close"
   exit
fi

# window class for the list dialog
export CLASS="left_click_001"

# fifo
export YAD_NOTIF=$(mktemp -u --tmpdir YAD_NOTIF.XXXXXX)
mkfifo "$YAD_NOTIF"

# trap that removes fifo
trap "rm -f $YAD_NOTIF" EXIT

# function to launch first item
yikes_one(){
   yad --text "first item"
}
export -f yikes_one

# function to launch second item
yikes_second(){
   yad --text "second item" --scale
}
export -f yikes_second

# function to launch the list dialog
list_dialog() {
# Ensures only one instance of this window
# Also, if there is another yad window closes it
if [[ $(pgrep -c $(basename $0)) -ne 1 ]]; then
   pids="$(xdotool search --class "$CLASS")"
   wpid="$(xdotool getwindowfocus)"

   for pid in $pids; do
        # Compares window class pid with the pid of a window in focus
        if [[ "$pid" == "$wpid" ]]; then
           xdotool windowunmap $pid
           exit 1
        fi
   done
fi

yad --list \
    --class="$CLASS" \
    --column="":IMG \
    --column="" \
    --column="" \
    "gtk-ok" "yikes_one" "One" "gtk-no" "yikes_second" "two" \
    --no-headers --no-buttons \
    --undecorated \
    --close-on-unfocus \
    --on-top \
    --skip-taskbar \
    --mouse \
    --width=200 --height=300 \
    --hide-column="2" \
    --sticky \
    --select-action="sh -c \"echo %s | cut -d ' ' -f 2 2>&1 | xargs -I {} bash -c {} \""
}
export -f list_dialog

# fuction to set the notification icon
function set_notification_icon() {
  echo "icon:firefox" 
  echo "tooltip:Come on"
  echo "menu:About!bash -c 'yad --about'!gtk-about||Quit!quit!gtk-quit"
}

exec 3<> $YAD_NOTIF

yad --notification --command="bash -c 'list_dialog'" --listen <&3 & notifpid=$!

# waits until the notification icon is ready
until xdotool getwindowname $(xdotool search --pid "$notifpid" | tail -1) &>/dev/null; do
        # sleep until the window opens
        sleep 0.5       
done

set_notification_icon >&3

# Waits for notification to exit
wait $notifpid

exec 3>&-

exit 0
