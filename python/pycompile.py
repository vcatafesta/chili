"""
PyCompiler: compile python files to bytecode.
Author: Gustavo Sverzut Barbieri <barbieri@gmail.com>
License: GPL
"""

# python -OO -c "import py_compile; py_compile.main()" sci.py funcoes.py

import sys
import os
import getopt
import py_compile
import compileall


def usage():
    print >> sys.stderr, """\
Usage:

        %s [options] <file1> ... <fileN>

where options are:
   -h, --help        This message.
   -r, --recursive   Enter directories recursively.
   -d, --maxdepth=N  Maximum depth in recursion.
   -f, --force       Force recompiling already compiled files.
   -q, --quiet       Be quiet.

""" % sys.argv[0]


def compile_file(filename, force = False, quiet = False):
    if not quiet:
        print "Compiling %s ..." % filename
    py_compile.compile(filename)


def compile_dir(dirname, depth = 1, force = False, quiet = False):
    compileall.compile_dir(dirname, depth, force = force, quiet = quiet)


def compile(name, depth = 1, force = False, quiet = False):
    if os.path.isdir(name):
        compile_dir(name, depth, force, quiet)
    elif os.path.exists(name):
        compile_file(name, force, quiet)
    else:
        if not quiet:
            print >> sys.stderr, "File '%s' doesn't exists!" % name


if __name__ == "__main__":
    try:
        opts, args = getopt.getopt(sys.argv[1:],
                                   "hrd:qf",
                                   ["help",
                                    "recursive",
                                    "maxdepth=",
                                    "quiet",
                                    "force"])
    except getopt.GetoptError:
        usage()
        sys.exit(2)

    depth = 0
    quiet = False
    force = True

    for o, a in opts:
        if o in ("-h", "--help"):
            usage()
            sys.exit(0)
        elif o in ("-r", "--recursive"):
            if not depth:
                depth = 20
        elif o in ("-d", "--maxdepth"):
            depth = int(a)
        elif o in ("-q", "--quiet"):
            quiet = True
        elif o in ("-f", "--force"):
            force = True

    for name in args:
        compile(name, depth, force, quiet)
