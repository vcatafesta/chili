#!/usr/bin/python

import sys

if sys.version_info < (3, 0):
    print("Ops, you should be running Python 3")
    sys.exit(1)

print(sys.version_info)
