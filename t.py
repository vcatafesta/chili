#!/usr/bin/env python3

url = 'https://www.vivaolinux.com.br'
url = 'https://chililinux.com'

import requests
if ( response := requests.get(url)):
    print(response)
else:
    print(response)

#response = urlopen(url, timeout=10)
