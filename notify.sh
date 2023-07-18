#!/usr/bin/env bash
# Reference: https://stackoverflow.com/a/29269811/2571881

# DEPENDENCIES: dunst
#
# NOTE: Some notification systems conflict with dunst, such as
#       xfce4 notification system
#
#       you can just use "echo if you want occupy a terminal for the timer"
#       or even use another "UI" package to manage your notifications

SECONDS=$((${1:-1} * 60))

for i in $(seq $SECONDS -1 1); do
    dunstify -r "98435" "Timer:" "$(date -d"@$i" -u +%H:%M:%S)"
    sleep 1
done
