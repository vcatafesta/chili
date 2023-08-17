#!/usr/bin/python3
# -*- coding: utf-8 -*-

import subprocess
subprocess.run(["ls"])

import subprocess
subprocess.run(["ls", "-la"])

import subprocess
result = subprocess.run(["cat", "sample.txt"], stderr=subprocess.PIPE, text=True)
print(result.stderr)

import subprocess
result = subprocess.run(["echo", "Hello, World!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
print(result.stdout)

import subprocess
subprocess.run(["python3", "add.py"], text=True, input="2 3")

import subprocess
process = subprocess.Popen(["ls", "-la"])
print("Completed!")

import subprocess
process = subprocess.Popen(["ls", "-la"])
process.wait()

print("Completed!")

