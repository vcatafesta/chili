#!/usr/bin/env bash
#regexsed='^.*>\\K(.+)-(([^-]+)-([0-9]+))-([^.]+)(\.chi\.zst)(<\/a>.*)(\\d{4}-\\d{2}-\\d{2}|\\d{2}-\w{3}-\\d{4})\s(\\d{2}:\\d{2})(.*\s)(\\d+[[:alpha:]]?)'
#   regex='^.*>\K(.+)-(([^-]+)-([0-9]+))-([^.]+)(\.chi\.zst)(<\/a>.*)(\d{4}-\d{2}-\d{2}|\d{2}-\w{3}-\d{4})\s(\d{2}:\d{2})(.*\s)(\d+[[:alpha:]]?)'
#regex='^.*>\K(.+)-(([^-]+)-([0-9]+))-([^.]+)(\.chi\.zst)(?=<\/a>.*(\d{4}-\d{2}-\d{2}|\d{2}-\w{3}-\d{4})\s(\d{2}:\d{2})(?:.*\s)(\d+[[:alpha:]]?))'
#regex='(?:^.*>)(.+)-(([^-]+)-([0-9]+))-([^.]+)(\.chi\.zst)(?:<\/a>.*(\d{4}-\d{2}-\d{2}|\d{2}-\w{3}-\d{4})\s(\d{2}:\d{2})(?:.*\s)(\d+[[:alpha:]]?))'
regex='^.*>(.+)-(([^-]+)-([0-9]+))-([^.]+)(.chi.zst)<.a>.*([0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}-[A-z]{3}-[0-9]{4})[ ]([0-9]{2}:[0-9]{2}).*[ ]([0-9]+k?)(.*)'
#curl --compressed --insecure --silent --url "https://chilios.com.br/packages/a/" | awk 'match($0, "$regex", ar) { print ar[0]}'
#wget "https://chilios.com.br/packages/a/" -qO - | awk 'match($0, "(?:^.*>)(.+)-(([^-]+)-([0-9]+))-([^.]+)(.chi.zst)(?:<.a>.*([0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}-.{3}-[0-9]{4})[ ]([0-9]{2}:[0-9]{2})(?:.*[ ])([0-9]+[[:alpha:]]?))", ar) {print ar[1]}'
#wget "https://chilios.com.br/packages/a/" -qO - | grep -Po "(?:^.*>)(.+)-(([^-]+)-([0-9]+))-([^.]+)(.chi.zst)(?:<.a>.*([0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}-.{3}-[0-9]{4})[ ]([0-9]{2}:[0-9]{2})(?:.*[ ])([0-9]+[[:alpha:]]?))"

#time curl --compressed --insecure --silent --url "https://chilios.com.br/packages/a/" | sed -nE "s;$regex;\1-\2-\5\6 \9;p"
#time wget https://chilios.com.br/packages/a/ -qO - | sed -nE "s;$regex;\1-\2-\5\6 \9;p"

#time curl --compressed --insecure --silent --url "http://localhost/packages/a/" | sed -nE "s;$regex;\1-\2-\5\6 \9;p"
#wget       http://localhost/packages/a/ -qO - | sed -nE "s;$regex;\1-\2-\5\6 \9;p"


#grep -Po "$regex" # | \
#awk 'match($0,/"$regex"/,a) {print $0, a[3]}'
#awk '{print gensub(/"$regex"/,"\\2",1)}'
#awk '{match($0,/"$regex"/);print substr($0,RSTART+2,RLENGTH-2);}'
#awk '{print substr($1,9,8)}'
#awk -F "$regex" 'vec[$1]++'
#grep -P "$regex" | \
#sed -nE "s/$regex/\1/p"
#awk -F "$regex" '++lista[$2]'


#time curl --compressed --insecure --silent --url "https://chilios.com.br/packages/a/" | sed -nE "s;$regex;\1-\2-\5\6 \9;p"
#time curl --compressed --insecure --silent --url "https://chilios.com.br/packages/a/" | sed -nE "s;$regex;\9;p"

str='b'
i=$((${#str}-1))
echo ${str:$i:1}
