#!/usr/bin/env bash

#IFS=-._
IFS='(.+)-(([^-]+)-([0-9]+))-([^.]+)\.chi\.zst'
set -- python-zope-proxy-4.3.5-1-x86_64.chi.zst
echo $1
echo $2
