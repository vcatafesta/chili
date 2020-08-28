#!/bin/bash -eu
# yad - yet another dialog (http://code.google.com/p/yad/):
#   do not use empty fields - see --field=...
#   labels create empty values - see IFS='|' read ...
# script:
#   1. create defaults: ### start-configuration-part ###
#   2. configure yad start (title/parameters): # yad-start
#   3. adjust read: # read variables from yad
#   4. configure progress bar: # progress-bar
#   5. configure start of your job: # start of your job
#   6. configure combos: # adjust combos that the selected value is on top

### start-configuration-part ###__goto__

# /etc/hosts only: comboserver=`awk '/^[^#]/ {printf $2"!"}' /etc/hosts|sort`
#comboserver=`grep -hve ^# -e ^"[0-9]" /etc/ssh/ssh_known_hosts* | cut -f1 -d" " | tr ',' '\012'| grep -v ^"[0-9]" | cut -f1 -d'.'| sort -u | grep -v ^$ | tr '\012' '!'`
comboserver=`awk '/^[^#]/ {printf $1"!"}' /etc/hostname|sort`
# all: user=`getent passwd|cut -f1 -d:|sort|tr '\012' '!'`
combouser=`getent passwd|cut -f1,3 -d:|grep '[0-9][0-9][0-9][0-9]$'|cut -f1 -d:|sort|tr '\012' '!'`
# all: group=`getent group|cut -f1 -d:|sort|tr '\012' '!'`
combogroup=`getent group|grep '[0-9][0-9][0-9][0-9]:$'|cut -f1 -d:|sort|tr '\012' '!'`
combolocale=`locale -a|sort|tr '\012' '!'`
combounit='K!M!G!T'

string=default
integer=10
boolean=true
file=
dir=
date=

job_progress_known=true # can you calculate the progress (1-100%)?
job_log=false # do you want to show log information in yad during progress?
yad_mode='--title="Closing does not abort the process" --width=640 ' # progress window during job

### end-configuration-part ###

author="$USER"
version='0.01'

# yad-start; icons: /usr/share/notify-osd/icons /usr/share/icons/...
while vars=`yad --center  --width=400 --borders=5 \
  --title="Window title v$version ($author)" --form \
  --field="<b>Combo examples</b>":LBL '' \
  --field="Server":CBE "$comboserver" \
  --field="User":CBE "$combouser" \
  --field="Group":CBE "$combogroup" \
  --field="Locale":CB "$combolocale" \
  --field="Unit":CB "$combounit" \
  --field="":LBL '' \
  --field="<b>Input examples</b>":LBL '' \
  --field="String":TEXT "$string" \
  --field="Integer":NUM "$integer!0..100!1" \
  --field="Boolean":CHK "$boolean" \
  --field="":LBL '' \
  --field="<b>Other examples</b>":LBL '' \
  --field="File":FL "$file" \
  --field="Dir":DIR "$dir" \
  --field="Date":DT "$date" \
  --button="gtk-ok":0 \
  --button="gtk-close":1`
do

  # read variables from yad
  IFS='|' read label server user group locale unit label label string integer boolean label label file dir date ignore <<_EOF
$vars
_EOF

  integer=${integer%,*}
  echo server:$server
  echo user:$user
  echo group:$group
  echo locale:$locale
  echo unit:$unit
  echo string:$string
  echo integer:$integer
  echo boolean:$boolean
  echo file:$file
  echo dir:$dir
  echo date:$date

  yad_mode+=' --progress'
  $job_log && yad_mode+=' --enable-log --log-expanded --height=400' || yad_mode+=' --auto-close'
  $job_progress_known || yad_mode+='--pulsate --progress-text running'

  # progress bar
  declare -i progress=0 max=100
  while sleep 1; do
    progress+=1
    $job_progress_known && echo $[$progress*100/max] || echo
    if $job_log; then
      (date; echo hello from job) | sed s/^/#/
    elif ! $job_progress_known; then
      echo '#state'
    fi
  done | yad $yad_mode &
  progresspid=$!

  # start of your job
  if output=`sleep 10; replacesleepandthiscommandwithyourjob 2>&1`; then
    disown $progresspid
    kill $progresspid &>/dev/null
    yad --image=dialog-ok --button=gtk-yes:0 --text="Successful\n$output"
    break
  else
    disown $progresspid
    kill $progresspid &>/dev/null
    yad --image=dialog-error --button=gtk-yes:0 --text="Error:\n$output"
    # adjust combos that the selected value is on top during next start of yad
    echo "$comboserver" | grep -q ^"$server!" || comboserver="$server!$comboserver"
    echo "$combouser"   | grep -q ^"$user!"   || combouser="$user!$combouser"
    echo "$combogroup"  | grep -q ^"$group!"  || combogroup="$group!$combogroup"
    echo "$combolocale" | grep -q ^"$locale!" || combolocale="$locale!$combolocale"
    echo "$combounit"   | grep -q ^"$unit!"   || combounit="$unit!$combounit"
  fi
done
