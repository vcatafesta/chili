#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os

var="""If
only"""
var
print(var)

lesson='disappointment'
print(lesson[0])
print(lesson[5:10])

x=10;
printer="Dell"
print("I just printed %s pages to the printer %s" % (x, printer))

print("I just printed {0} pages to the printer {1}".format(x, printer))
print("I just printed {x} pages to the printer {printer}".format(x=7, printer="Dell"))

print('homeowner'.find('meow'))

print("*".join(['red','green','blue']))


def sayhello(*names):
    for name in names:
        print(f"Hello, {name}")

sayhello('Ayushi','Leo','Megha')

print(os.getcwd())
print(os.getcwdb())


#for roots,dirs,files in os.walk('/root/src'):
#    print(roots,dirs,files)

def div(p,q):
    try:
        assert p == 2, "You cannot divide a number by zero\nPlease try again"
        assert q != 0, "You cannot divide a number by zero\nPlease try again"
        return p/q
    except:
        print("So you tried to dive by 0. Pleasy try again")

print(div(2,0))
