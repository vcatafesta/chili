#!/bin/bash
while getopts "abc:d:" flag
do
  case $flag in
    a) echo "[getopts:$OPTIND]==> -$flag";;
    b) echo "[getopts:$OPTIND]==> -$flag";;
    c) echo "[getopts:$OPTIND]==> -$flag $OPTARG";;
    d) echo "[getopts:$OPTIND]==> -$flag $OPTARG";;
  esac
done

shift $((OPTIND-1))
echo "[otheropts]==> $@"

exit
