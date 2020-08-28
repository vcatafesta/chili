while getopts "hf:t:" OPT; do
  case "$OPT" in
  "h") usage;; # exibir ajuda
  "f") FROM=$OPTARG;;
  "t") TO=$OPTARG;;
  "?") exit -1;;
  esac
  done
