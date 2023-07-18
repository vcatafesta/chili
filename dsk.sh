#!/usr/bin/env bash

source /usr/share/fetch/core.sh


# choosedisk
: ${ARRAY_PART_DEVICES=()}
: ${ARRAY_PART_DISKS=()}
: ${ARRAY_PART_SIZE=()}
: ${ARRAY_PART_LABEL=()}
: ${ARRAY_PART_PARTTYPENAME=()}
: ${ARRAY_PART_PTTYPE=()}
: ${ARRAY_PART_START=()}

function sh_part_info()
{
        ARRAY_PART_DISKS=()
      ARRAY_PART_DEVICES=()
         ARRAY_PART_SIZE=()
         ARRAY_PART_LABEL=()
        ARRAY_PART_FSTYPE=()
  ARRAY_PART_PARTTYPENAME=()
        ARRAY_PART_PTTYPE=()
         ARRAY_PART_START=()
   while IFS='\ ' read -r part_type part_name part_path part_size part_label part_pttype part_start part_ptn1 part_ptn2 part_ptn3
   do
      [[ -z $part_size   ]] && part_size="0B"
      [[ -z $part_start  ]] && part_start="0"
      [[ -z $part_label  ]] && part_label="unknow"

		printf "%-6s|%6s|%-10s|%-10s|%s|%s|%s %s %s\n" "$part_type" 	\
																	"$part_name" 	\
																	"$part_path" 	\
																	"$part_size" 	\
																	"$part_label" 	\
																	"$part_pttype" \
																	"$part_ptn1" 	\
																	"$part_ptn2"	\
																	"$part_ptn3"


        ARRAY_PART_DISKS+=("${part_name}")
      ARRAY_PART_DEVICES+=("${part_path}")
         ARRAY_PART_SIZE+=("${part_size}")
         ARRAY_PART_LABEL+=("${part_label}")
  ARRAY_PART_PARTTYPENAME+=("${part_ptn1} ${part_ptn2} ${part_ptn3}")
        ARRAY_PART_PTTYPE+=("${part_pttype}")
         ARRAY_PART_START+=("${part_start}")
   done < <(lsblk $sd -a -o TYPE,KNAME,PATH,SIZE,PARTLABEL,PTTYPE,START,PARTTYPENAME |grep part)
}


choosepart()
{
   while true
   do
      sh_part_info
      local array=()
      local i
      local n=0
      local nc=0

      for i in "${ARRAY_PART_DEVICES[@]}"
      do
         array[((n++))]="$i"
         array[((n++))]=$(printf "%-6s|%6s|%-10s|%-10s|%s" 				\
         								"${ARRAY_PART_PTTYPE[$nc]}"			\
         								"${ARRAY_PART_SIZE[$nc]}" 				\
         								"${ARRAY_PART_LABEL[$nc]}" 			\
         								"${ARRAY_PART_START[$nc]}"				\
         								"${ARRAY_PART_PARTTYPENAME[$nc]}"	)
         ((nc++))
      done

      part=$(dialog                                                              \
               --title        "${cmsg_disco_origem[$LC_DEFAULT]}"                \
               --backtitle    "${ccabec}"                                        \
               --ok-label     "${cmsg_Select[$LC_DEFAULT]}"                      \
               --cancel-label "${cmsg_button_voltar[$LC_DEFAULT]}"               \
               --colors                                                          \
               --extra-button                                                    \
               --extra-label  "${cmsg_info_disco[$LC_DEFAULT]}"                  \
               --menu         "\n${cmsg_choose_disk[$LC_DEFAULT]}"               \
               0 0 0 "${array[@]}" 2>&1 >/dev/tty  )
     exit 0
	done
}

choosedisk()
{
   while true
   do
      sh_disk_info
      local array=()
      local i
      local n=0
      local nc=0

      for i in "${ARRAY_DSK_DEVICES[@]}"
      do
         array[((n++))]="$i"
         array[((n++))]=$(printf "%-6s|%6s|%-30s" "${ARRAY_DSK_TRAN[$nc]}" "${ARRAY_DSK_SIZE[$nc]}" "${ARRAY_DSK_MODEL[$nc]}")
         ((nc++))
      done

      sd=$(dialog		                                                            \
               --title        "${cmsg_disco_origem[$LC_DEFAULT]}"                \
               --backtitle    "${ccabec}"                                        \
               --ok-label     "${cmsg_Select[$LC_DEFAULT]}"                      \
               --cancel-label "${cmsg_button_voltar[$LC_DEFAULT]}"               \
               --colors                                                          \
               --extra-button                                                    \
               --extra-label  "${cmsg_info_disco[$LC_DEFAULT]}"                  \
               --menu         "\n${cmsg_choose_disk[$LC_DEFAULT]}"               \
               0 0 0 "${array[@]}" 2>&1 >/dev/tty  )

      exit_status=$?
      case $exit_status in
         $D_ESC|$D_CANCEL)
            init
            ;;
         3)
            local result=$( fdisk -l $sd );
            display_result "$result" "${csmg_particionamento_automatico[$LC_DEFAULT]}" "${cmsg_part_disk[$LC_DEFAULT]}"
            continue
            ;;
      esac

      if [ $sd != "" ]; then
         {  local item
            index=0
            for item in ${ARRAY_DSK_DEVICES[*]}
            do
               [ $item = $sd ] && { break; }
               ((index++))
            done
         }
         DEVICE_ORIGEM="${ARRAY_DSK_DISKS[index]}"
         MODEL_ORIGEM="$sd [${ARRAY_DSK_SIZE[index]}] [${ARRAY_DSK_MODEL[index]}]"
         TRAN_ORIGEM="${ARRAY_DSK_TRAN[index]}"
         sh_backup_partitions "${sd}" "${DEVICE_ORIGEM}"
         choosepart
      fi
      break
    done
}

choosedisk


