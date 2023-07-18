#!/bin/bash
# This is get-tester-address.sh
#
# First, we test whether bash supports arrays.
# (Support for arrays was only added recently.)
#
whotest[0]='test' || (echo 'Failure: arrays not supported in this version of
bash.' && exit 2)

#
# Our list of candidates. (Feel free to add or
# remove candidates.)
#
wholist=(
     'Bob Smith <bob@example.com>'
     'Jane L. Williams <jane@example.com>'
     'Eric S. Raymond <esr@example.com>'
     'Larry Wall <wall@example.com>'
     'Linus Torvalds <linus@example.com>'
   )
#
# Count the number of possible testers.
# (Loop until we find an empty string.)
#
count=0
while [ "x${wholist[count]}" != "x" ]
do
   count=$(( $count + 1 ))
done

#
# Now we calculate whose turn it is.
#
week=`date '+%W'`    	# The week of the year (0..53).
week=${week#0}       	# Remove possible leading zero.

let "index = $week % $count"   # week modulo count = the lucky person

email=${wholist[index]}     # Get the lucky person's e-mail address.

echo $email     	# Output the person's e-mail address.
