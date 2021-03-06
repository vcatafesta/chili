 #!/bin/bash
  
  ########
  #
  # This script is used to rename a set of photos with a given prefix
  # like birthday-001.jpg birthday-002.jpg and so on
  #
  # Created and mainteined by Fabiano Caixeta Duarte <fcd@superig.com.br>
  #
  ########
  THIS=$(basename $0)

  function usage() {
    echo -e "$THIS 0.1\t-\tAuthor: Fabiano Caixeta Duarte <fcd@superig.com.br>"
    echo "
    Usage:
    $THIS -i <image type> [-c <counter_starter>] -f <from_prefix> -t <to_prefix>
    $THIS -h (shows this help)
    "
    exit -1
  }

  while getopts "hi:c:f:t:" OPT; do
    case $OPT in
        "h") usage;;
        "i") IMGTYPE=$OPTARG;;
        "c") COUNTER=$OPTARG; [[ $COUNTER =~ ^[0-9]{1,3}$ ]] || usage;;
        "f") FROM=$OPTARG
            for F in ${FROM}*.${IMGTYPE}; do
                [ ! -f $F ] && echo "$THIS: $FROM*.$IMGTYPE not found" && exit -2
            done;;
      "t") TO=$OPTARG;;
      "?") exit -2;;
      esac
  done

  [ -z "$FROM" -o -z "$TO" -o -z "$IMGTYPE" ] && usage

  let ${COUNTER:=1}

  for FILE in ${FROM}*.${IMGTYPE}; do
      mv -v $FILE $(printf "%s%03d.%s" $TO $COUNTER $IMGTYPE)
      ((COUNTER++))
  done

  exit 0
