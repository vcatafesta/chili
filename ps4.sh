#!/usr/bin/env bash
export PS4='$0[$LINENO] '
set -x
echo "PS4 debug script"
ls -l /etc/ | wc -l
du -sh ~
