function info()
{
    yad		--form					\
            --center				\
            --width=400      	\
            --height=200    	\
            --title		"$2"		\
            --text    	"$*"
}

	devices=($(fdisk -l | egrep -o '/dev/sd[a-z]'|uniq))
    size=($(fdisk -l|sed -n '/sd[a-z]:/p'|awk '{print $3$4}'|sed 's/://p'|sed 's/[,\t]*$//'|awk '{printf "%10s\n", $1}'))
    modelo=($(fdisk -l | grep -E "(Modelo|Model)"|sed 's/^[:\t]*//'|cut -d':' -f2 | sed 's/^[ \t]*//;s/[ \t]*$//'|sed 's/ /_/'))

    n=0
    i=0
    sd=()
    array=()
    for i in ${devices[@]}
    do
        #array[((n++))]=$i
        #array[((n++))]="$i [${size[((x++))]}]  ${modelo[((y++))]}#"
        array+=("$i [${size[$n]}] ${modelo[$n]}#")
        sd+=("$i" "${size[$n]}" "${modelo[$n]}")
        ((n++))
    done
    export sd
    export SD=("${array[*]}")
    export HDS=("${devices[*]}")

	form_disk=$(yad					\
			--list              	\
	        --center            	\
	        --item-separator="#" 	\
    	    --title="$title"    	\
	        --width=400	 	     	\
	        --height=200	    	\
	        --image="hd.png"    	\
	        --text="\n<b>Particionar discos</b>\n\nNote que serão apagados todos os dados no disco que escolher, mas não antes de você confirmar que quer realmente fazer as alterações" \
	        --button=$btnCancel 	\
	        --button=$btnPrevious	\
	        --button=$btnNext   	\
	        --column="device" 		\
	        --column="size"    	 	\
	        --column="model"   	 	\
    	    "${sd[@]}")

IFS=\| read dev size model <<< "$form_disk"
info $dev $size $model $?
