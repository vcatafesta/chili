#!/usr/bin/env python3
# -*- coding: utf-8 -*-

modules = ['urllib','requests','random']

for module in modules:
    try:
        __import__(module)
    except Exception as e:
        print('Installing modules...')
        os.system('pip3 install ' + str(module))
#        os.system('clear')

from random import randint
print(randint(0, 127))
