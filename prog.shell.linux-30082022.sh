#!/usr/bin/env bash
#Programação Shell Linux: find e xargs casaram e foram felizes para sempre PARTE 1
#https://www.youtube.com/watch?v=RdXVEB35B8I

#find . -type f -size +1M -atime +180 -exec ls {} \;
#ind . -type f -size +1M -atime +180 -exec ls {} +;
#ind . -type b,c,d,l,p,f,s -size +1M -exec ls -1 {} +;
#find . -type b,c,d,l,p,f,s -exec file '{}' +;
#find . -type b,c,d,l,p,f,s -print0
#find . -type b,c,d,l,p,f,s -printf '%n %p %P %s %t \n'
find . -type b,c,d,l,p,f,s -printf '%n %p %P %s %t \n' -fprint ARQ

eval \>arq{a..d}\;
#find . -size 0 -exec bash -c 'rm {}; echo removi >> arq.log' \;
find . -size 0 -exec bash -c 'rm {}; echo removi >> arq.log' +;
