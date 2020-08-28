#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

if __name__ == "__main__":
    # Initialize a names dictionary as empty to start with.
    # Each key in this dictionary will be a name and the value
    # will be the number of times that name appears.
    names = {}
    # sys.stdin is a file object. All the same functions that
    # can be applied to a file object can be applied to sys.stdin.
    for name in sys.stdin.readlines():
            # Each line will have a newline on the end
            # that should be removed.
            name = name.strip()
            if name in names:
                    names[name] += 1
            else:
                    names[name] = 1

    # Iterating over the dictionary,
    # print name followed by a space followed by the
    # number of times it appeared.
    for name, count in names.iteritems():
            sys.stdout.write("%d\t%s\n" % (count, name))