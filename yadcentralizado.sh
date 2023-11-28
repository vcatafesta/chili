#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

mensagem="<b>Erro</b>\n\nDispositivo não Localizado"
largura_terminal=$(tput cols)
altura_terminal=$(tput lines)
largura=$(( $largura_terminal - 0 ))
altura=30
x=$(( ($largura_terminal - $largura) / 2 ))
y=$(( ($altura_terminal - $altura) / 2 ))

yad --text "$mensagem" \
    --button=OK \
    --buttons-layout=center \
    --width="$largura" \
    --height="$altura" \
    --undecorated \
    --center \
    --on-top \
    --no-escape \
    --skip-taskbar \
    --posx=$x \
    --posy=$y \
    --image="emblem-important"

