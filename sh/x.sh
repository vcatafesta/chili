#!/bin/bash
#         | sed 's/      //g' 			\

cat releases                		\
         | grep tar              \
         | sed 's/<a href=\"//g'	\
			| cut -d'"' -f2 			\
         | sed 's/<\/a>//g'		\
         | sed 's/>//g'
