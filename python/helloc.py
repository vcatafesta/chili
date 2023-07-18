# coding: utf-8
import pyfat as P

c = P.strtoint('2100000')
print(c)
print(type(c))
print(dir(P))
print(P.maxcol())
c = P.replicate(chr(176), 10)
print(c, len(c))
#print(P.now())
#print(P.strtime())
print(P.padc("VILMAR", P.maxcol(), chr(32)))
tam = P.strlenx()
print(tam, type(tam))