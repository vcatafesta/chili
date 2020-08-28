#!/usr/bin/python3

import click
import color


@click.command()
@click.argument('f', type=click.File('r'))
def printfile(f):
    print("{}".format(color.red))
    print(f.read())


if __name__ == '__main__':
    printfile()
