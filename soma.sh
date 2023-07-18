#!/usr/bin/env bash

echo "
time for ((i=i; i<2000; i++))
{
	expr 2 + 2 > /dev/null
}
"

time for ((i=i; i<2000; i++))
{
	expr 2 + 2 > /dev/null
}

echo "
time for ((i=i; i<2000; i++))
{
	((2+2)) > /dev/null
}
"

time for ((i=i; i<2000; i++))
{
	((2+2)) > /dev/null
}



