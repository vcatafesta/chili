#!/usr/bin/env python3

def aliquotas(valor):
    ir = valor * 0.16
    iss = valor * 0.03
    inss = valor * 0.70
    return( ir, iss, inss)


def geo():
    return 22.345, 46.767


def soma(a, b, c):
    return a + b + c


imposto1, imposto2, imposto3 = aliquotas(10000)
print(aliquotas(10000))
print(imposto1)
print(imposto2)
print(imposto3)

print(geo())
print(soma(imposto1, imposto2, imposto3))
