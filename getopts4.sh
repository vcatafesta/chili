if ( ! getopts "abc:deh" opt); then
    echo "Usage: `basename $0` options (-ab) (-c value) (-d) (-e) -h for help";
    exit $E_OPTERROR;
fi

while getopts "abc:deh" opt; do
     case $opt in
         a) something;;
         b) another;;
         c) var=$OPTARG;;
     esac
done
