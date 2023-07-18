#!/bin/bash

if [ $# -lt 1 ]; then
   echo 'usage:'
   echo '   bsd.sh desc.mtree "*.zst.desc"'
   exit 1
fi
#LANG=C bsdtar -czf .MTREE --format=mtree --options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' "${comp_files[@]}" *
LANG=C bsdtar -c -z -f "$1" -v --format=mtree --options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' "${comp_files[@]}" $2
comp_files+=(".MTREE")
[ $? -eq 0 ] && gzip -cd $1 >file.txt
