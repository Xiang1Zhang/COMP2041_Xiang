#!/usr/bin/python3
# put your demo script here
# This demo was taken from an example in subset4

import sys

lines = []
for line in sys.stdin:
    lines.append(line)
    
i = len(lines) - 1
while i >= 0:
    print(lines[i], end='')
    i = i - 1

