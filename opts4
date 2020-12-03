#!/usr/bin/bash

aflag=no
bflag=no
cargument=none

# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -o abc: -l along,blong,clong: -- "$@")
then
    # something went wrong, getopt will put out an error message for us
    exit 1
fi

set -- $options

while [ $# -gt 0 ]
do
    case $1 in
    -a|--along) aflag="yes" ;;
    -b|--blong) bflag="yes" ;;
    # for options with required arguments, an additional shift is required
    -c|--clong) cargument="$2" ; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done

