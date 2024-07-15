while IFS='\ ' read -r dsk_type dsk_name dsk_path dsk_size dsk_tran dsk_model dsk_model1 dsk_model2; do
	echo "${dsk_model} ${dsk_model1} ${dsk_model2}"
	printf "NAME:$dsk_name\nPATH:$dsk_path\nSIZE:$dsk_size\nTRAN:$dsk_tran\nMODEL:$dsk_model $dsk_model1 $dsk_model2\n\n"
	ARRAY_DSK_DISKS+=("${dsk_name}")
	ARRAY_DSK_DEVICES+=("${dsk_path}")
	ARRAY_DSK_SIZE+=("${dsk_size}")
	ARRAY_DSK_TRAN+=("${dsk_tran}")
	ARRAY_DSK_MODEL+=("${dsk_model} ${dsk_model1} ${dsk_model2}")
	#ARRAY_DSK_LABEL+=("${dsk_label}")
	#done < <(lsblk -a -P -o TYPE,NAME,PATH,SIZE,TRAN,MODEL,LABEL | grep disk)
done < <(lsblk -A -a -o TYPE,NAME,PATH,SIZE,TRAN,MODEL | grep disk)
