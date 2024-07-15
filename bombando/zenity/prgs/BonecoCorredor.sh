#!/bin/bash

# Boneco corredor para a area de notificacao
# Copyright 2007 Aurelio A. Heckert <aurium#gmail-com>
#
# This is a Free Software relized under the terms of
# the GNU-GPL: http://www.gnu.org/licenses/gpl-3.0.html

# create a temp dir:
dir=$(mktemp -d)
svg=$dir/icon.svg
style="style='fill:none; stroke:#000; stroke-width:18px; stroke-linecap:round; stroke-linejoin:round'"

while sleep 0.1; do
	frame=$(($(date +%S%N | sed 's/^\(...\).*$/\1/' | sed 's/^00\?//') % 10))
	wave=$frame
	[ $wave -gt 5 ] && wave=$((10 - frame))
	echo "<svg width='200' height='200'>
  <path d='M 100,30 L 100,120' $style />
  <!-- Bracos -->
  <path d='M 100,65
           L $((115 - (frame * 5))),$((100 - (frame * 1) + (wave * 3)))
           L $((150 - (frame * 9))),$((90 + (frame * 3) + (wave * 6)))' $style />
  <path d='M 100,65
           L $((65 + (frame * 5))),$((90 + (frame * 1) + (wave * 3)))
           L $((60 + (frame * 9))),$((120 - (frame * 3) + (wave * 6)))' $style />
  <!-- Pernas -->
  <path d='M 100,120
           L $((125 - (frame * 4) - (wave * 1))),157.5
           L $((150 - (frame * 9) - (wave * 2))),195' $style />
  <path d='M 100,120
           L $((85 + (frame * 4) + (wave * 3))),$((157 - (wave * 4))).5
           L $((60 + (frame * 9) - (wave * 4))),$((195 - (wave * 8)))' $style />
  <circle cx='100' cy='30' r='30' style='fill:#000; stroke:none;' />
  <circle cx='100' cy='30' r='18' style='fill:#F80; stroke:none;' />
</svg>" >$svg
	# Write color debug on STDERROR:
	[ "$1" != "no-debug" ] && echo " $frame - $wave" 1>&2
	# Send a icon update command to the zenity notification:
	echo icon:$svg
done | zenity --notification --text="Icon Animation Test" --listen

rm -rf $dir
