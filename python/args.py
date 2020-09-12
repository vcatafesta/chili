#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" Compreendendo o uso de argumentos - passo 2.
"""

import sys
import argparse


def main():
    parser = argparse.ArgumentParser(description='ChiliOS fetch')  # (1)
    parser.add_argument('-Sy', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.add_argument('-Su', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.add_argument('-f', dest='force', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.add_argument('-y', dest='auto', nargs='*', type=str, default='', required=False, help='Sync')  #(2)
    parser.print_help()
    args = parser.parse_args() #(3)
    print("Sy={}".format(args.Sy)) # (4)
    print("Su={}".format(args.Su)) # (4)
    print(" f={}".format(args.force)) # (4)
    print(" y={}".format(args.auto)) # (4)
    return 0

if __name__ == '__main__':
    sys.exit(main())
