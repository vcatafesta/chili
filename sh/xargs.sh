#!/bin/bash

yad --list \
    --radiolist \
    --center \
    --column Marque \
    --column Usuario $(cut -f1 -d: /etc/passwd | sort | xargs -n1 echo FALSE) \
    --height 500 \
    --image gtk-ok \
    --image-on-top

IFS=\| read lx user <<< "$(yad --list \
    --radiolist \
    --center \
    --column Marque \
    --column Usuario $(cut -f1 -d: /etc/passwd | sort | xargs -n1 echo FALSE) \
    --height 500)"
echo $lx
echo $user

time seq 1000 | xargs
time find /chili -type f | wc -l
time find /chili -type f -exec grep date {} \; | wc -l
time find /chili -type f | xargs grep -l date | wc -l
seq 10 | xargs -n1 echo linha
seq 10 | xargs -L3
touch arq{1..5}.{ok,err}
ls arq*.ok | xargs -i bash -c "mv {} dir; echo movi {}"
touch arq{1..5}.{ok,err}
ls arq*.ok | xargs -ti bash -c "mv {} dir; echo movi {}"
touch arq{1..5}.{ok,err}
#ls arq*.ok | xargs -pI{} bash -c "mv {} dir; echo movi {}"
