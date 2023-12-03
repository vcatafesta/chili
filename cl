#!/bin/bash

file="$1"
if cobc -q -x -j -frelax-syntax -O $file; then
#if cobc -w -q -x -j -frelax-syntax -O $file; then
#if cobc -w -q -x -j -free -O $file; then
	file_name_without_extension="${file%%.*}"
#	./$file_name_without_extension
fi


