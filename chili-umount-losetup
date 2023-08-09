#!/bin/bash

LOOP_DEVICES=$(losetup -j /vg/iso/chili.img | awk -F: '{print $1}')
if [ -n "$LOOP_DEVICES" ]; then
	for loopdev in $LOOP_DEVICES; do
		losetup -d "$loopdev"
	done
fi
