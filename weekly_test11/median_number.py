#!/usr/bin/python3

import sys

list = sorted(sys.argv)

list[0] = 0

list.sort(key=int)

median = list[len(list)//2]

print(median)
