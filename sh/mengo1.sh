#!/bin/bash
# Cria uma bandeira rubronegra na tela

trap "tput sgr0; tput cnorm; clear; exit" 0 2 3 15

clear
for ((i=0;i<$(tput lines);i++))
{
	tput cup $i 0
	tput setab $[i%2]
	sleep .1
	tput ed
}
for ((i=1;i<10;i++))
{
	tput flash
	sleep .5
}
Lin[0]="mmmm      mmmm  eeeeeee  nnnn   nnn     gggg        0000"
Lin[1]="mmmmm    mmmmm  eeeeeee  nnnnn  nnn   ggg  ggg    ooo  ooo"
Lin[2]="mmmmmm  mmmmmm  eee      nnnnnn nnn  ggg         ooo    ooo"
Lin[3]="mmm mmmmmm mmm  eeeee    nnn nnnnnn  ggg         ooo    ooo"
Lin[4]="mmm  mmm   mmm  eee      nnn  nnnnn  ggg  ggggg  ooo    ooo"
Lin[5]="mmm        mmm  eeeeeee  nnn   nnnn   ggg  ggg    ooo  ooo"
Lin[6]="mmm        mmm  eeeeeee  nnn    nnn     gggg        oooo"
let ColIni=($(tput cols) - ${#Lin[3]})/2
let LinIni=($(tput lines) - 7)/2
((ColIni < 0 || LinIni < 0)) && {
    zenity --error --text "Para curtir o resto da animação,\n<b><big>Aumente o tamanho da tela</big></b>"
    exit 1
    }
tput setab 1
tput setaf 0
tput civis
clear
for ((i=0; i<=6; i++))
{
    tput cup $((LinIni + i)) $ColIni
    echo "${Lin[i]}"
    sleep .3
}

for ((i=1;i<10;i++))
{
    tput flash
    sleep .5
}
sleep 3

