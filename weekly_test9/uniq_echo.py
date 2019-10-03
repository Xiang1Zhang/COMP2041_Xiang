#!/usr/bin/python3

import sys

lines = []
s = []

for arg in sys.argv[1:]:
        lines.append(arg)

for i in lines:
        if i not in s:
                s.append(i)

for j in s:
        print(j, end=' ')
print()
