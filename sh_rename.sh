#!/usr/bin/env bash

find . -name "*$1" -type f | while read; do
	filename=$(basename "${REPLY}")
	new_filename=${filename%%$1}$2
	mv "$REPLY" "$new_filename"
done;
