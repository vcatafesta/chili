#!/usr/bin/bash

aflag=no
bflag=no
flist=""
set -- $(getopt abf: "$@")
while [ $# -gt 0 ]
do
    case "$1" in
    -a) aflag=yes;;
    -b) bflag=yes;;
    -f) flist="$flist $2"; shift;;
    --) shift; break;;
    -*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    *)  break;;
    esac
    shift
done

