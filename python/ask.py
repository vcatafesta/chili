#!/usr/bin/python3
# -*- coding: utf-8 -*-

import click


@click.command()
@click.option('--name', prompt=True, help="Your name:")
@click.option('--passwd', prompt='Your password', hide_input=True, confirmation_prompt=True, help='Password')
def ask(name, passwd):
    print('Hi, %s' % name)
    if passwd:
        print('Password: %s' % passwd)


if __name__ == '__main__':
    ask()
