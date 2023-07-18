#!/usr/bin/env bash

ini=1
fim=3
eval \>arq{1..3}\;
eval eval "\>arq{$ini..$fim}"
eval eval \\\>arq\{$ini..$fim\}
