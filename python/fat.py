#!/usr/bin/env python

import sys
import time


def fat(number):
    if (number == 1):
        return number

    return number * fat(number - 1)


def main():
    # Pega o tempo inicial
    t1 = time.time()

    # executa o fatorial
    fat(9999)

    # pega o tempo final
    t2 = time.time()

    # exibe o tempo de execucao
    print "tempo de execucao para calcular o " \
          "fatorial, foi de: ", (t2 - t1)


if __name__ == '__main__':
    sys.setrecursionlimit(999999)
    main()
