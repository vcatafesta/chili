#!/bin/bash

source search_appstreamcli.sh
PackageType= PkgName=. searchAppStream
echo ${AppStreamIndex[@]}
echo ${SearchAppStreamInfo[@]}
echo $$
unset -v SearchAppStreamInfo[@] AppStreamIndex[@]
sleep 60
