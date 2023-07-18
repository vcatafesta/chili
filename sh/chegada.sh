#!/bin/bash

until who | grep vcatafesta
do
    sleep 30
done
echo $(date "+ Em %d/%m às %H:%Mh") >> relapso.log
