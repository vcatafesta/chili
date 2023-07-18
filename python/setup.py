#!/usr/bin/env python

from distutils.core import setup, Extension

module = Extension('fat', sources = ['PyFat.cpp'])
setup(name = 'Fatorial', 
      version = '1.0', 
      ext_modules = [module])