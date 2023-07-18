#!/bin/bash

date | grep Wed | wc -l
echo ${PIPESTATUS[*]}

date | grep Wed | wc -l
echo "${PIPESTATUS[0]} ${PIPESTATUS[1]} ${PIPESTATUS[2]}"

