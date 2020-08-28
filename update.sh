apt update 2>&1 | tee -a ${logfile} |
  yad --width=400 --height=300 \
    --title="Updating debian package list ..." --progress \
    --pulsate --text="Updating debian package list ..." \
    --auto-kill --auto-close \
    --percentage=1
