#!/usr/bin/bash

awk 'BEGIN {
    if (ARGC != 3)
       print "Forneca 2 numeros\n"
    else
       {
          soma=ARGV[1]+ARGV[2]
          print "Soma = " soma
       }
}'
