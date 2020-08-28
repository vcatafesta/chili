yad --list \
    --radiolist \
    --center \
    --column Marque \
    --column Usuario $(cut -f1 -d: /etc/passwd | sort | xargs -n1 echo FALSE) \
    --height 500
