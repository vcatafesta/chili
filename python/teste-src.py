#!/usr/bin/python3
# -*- coding: utf-8 -*-

import subprocess
import sys

script_name = "bstrlib.sh"
function_name = "sh_pkg_pacman_build_date"
package_name = sys.argv[1]

command = f'source {script_name} && {function_name} "{package_name}"'
result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, text=True, cwd='/usr/share/bigbashview/bcc/shell/')
print( result)
pkg_build_date = result.stdout.strip()
print(pkg_build_date)

import subprocess

command = "ls -l"
result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, text=True, cwd="./")
print(result)
output = result.stdout.strip()
print(output)

