#!/usr/bin/python3
# -*- coding: utf-8 -*-

bold = ""
reset = "\033[0m"
black = "\033[1;30m"
blue = "\033[1;34m"
cyan = "\033[1;36m"
green = "\033[1;32m"
orange = "\033[1;33m"
purple = "\033[1;35m"
red = "\033[1;31m"
violet = "\033[1;35m"
white = "\033[1;37m"
yellow = "\e[1;33m"
pink = "\033[35;1m"


def main():
    print("{}Teste {}de {}cores".format(pink, blue, orange))
    print("{}Teste".format(blue))


if __name__ == '__main__':
    main()
