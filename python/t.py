#!/usr/bin/python

# -*- coding: utf-8 -*-
import re
import sys

from pip import __main__

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
    sys.exit(__main__._main())