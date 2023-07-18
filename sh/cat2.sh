
exec 3<> $1
while read line <&3
do {
  echo "$line"
  (( Lines++ ));                   #  Incremented values of this variable
                                   #+ accessible outside loop.
                                   #  No subshell, no problem.
}
done
exec 3>&-

echo "Number of lines read = $Lines"     # 8

echo

exit 0