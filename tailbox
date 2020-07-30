#!/bin/bash
tarxz="tar -Jxvf"


function sh_tailboxbg(){
{
    for i in 1 2; do 
        printf '%d\n' "$i"
        sleep 1
    done

    printf 'Done\n'
} > dialog-tail.log &

dialog --title "TAIL BOXES" \
       --begin 10 10 --tailboxbg dialog-tail.log 8 58 \
       --and-widget \
       --begin 3 10 --msgbox "Press OK " 5 30
}

function sh_tailbox(){
    {
        tar -Jxvf vilmar.x -C /mnt
    } > out &

    dialog --title "**TAR**"                    \
           --begin 10 10 --tailboxbg out 25 120 \
           --and-widget                         \
           --begin 3 10 --msgbox "Exit" 5 30
}
clear
sh_tailbox
