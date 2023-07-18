#!/usr/bin/env python3

modules = ['urllib','requests']

for module in modules:
    try:
        __import__(module)
    except Exception as e:
        print('Installing modules...')
        os.system('pip3 install ' + str(module))
#        os.system('clear')

import urllib

url=urllib.parse.urlparse('https://github.com/vcatafesta/')
print(url)
url=urllib.parse.urlparse('https://chilios.com.br/')
print(url)
