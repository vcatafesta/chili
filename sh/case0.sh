#!/bin/bash

echo -e -n "\aEnter the name of an animal: "
read ANIMAL
echo -n "The $ANIMAL has "
case $ANIMAL in
	horse | dog | cat) echo -n "four";;
	man | kangaroo ) echo -n "two";;
	*) echo -n "an unknown number of";;
esac
echo " legs."
