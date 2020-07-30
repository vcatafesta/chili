#comboserver=`grep -hve ^# -e ^"[0-9]" /etc/ssh/ssh_known_hosts* | cut -f1 -d" " | tr ',' '\012'| grep -v ^"[0-9]" | cut -f1 -d'.'| sort -u | grep -v ^$ | tr '\012' '!'`
comboserver=`awk '/^[^#]/ {printf $2"!"}' /etc/hosts|sort`
combouser=`getent passwd|cut -f1,3 -d:|grep '[0-9][0-9][0-9][0-9]$'|cut -f1 -d:|sort|tr '\012' '!'`
combogroup=`getent group|grep '[0-9][0-9][0-9][0-9]:$'|cut -f1 -d:|sort|tr '\012' '!'`
combolocale=`locale -a|sort|tr '\012' '!'`
combounit='K!M!G!T'

