#!/usr/bin/bash

# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD, you have to install this
# separately; see below.
TEMP=`getopt -o vdm: --long verbose,debug,memory:,debugfile:,minheap:,maxheap: -n 'javawrap' -- "$@"`
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

VERBOSE=false
DEBUG=false
MEMORY=
DEBUGFILE=
JAVA_MISC_OPT=
while true; do
  case "$1" in
    -v | --verbose )	VERBOSE=true; shift ;;
    -d | --debug )	DEBUG=true; shift ;;
    -m | --memory )	MEMORY="$2"; shift 2 ;;
    --debugfile ) 	DEBUGFILE="$2"; shift 2 ;;
    --minheap )		JAVA_MISC_OPT="$JAVA_MISC_OPT -XX:MinHeapFreeRatio=$2"; shift 2 ;;
    --maxheap )		JAVA_MISC_OPT="$JAVA_MISC_OPT -XX:MaxHeapFreeRatio=$2"; shift 2 ;;
    -- ) 				shift; break ;;
    * ) 					break ;;
  esac
done
