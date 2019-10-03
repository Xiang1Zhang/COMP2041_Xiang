#!/usr/bin/python3

import sys

words = []
for line in sys.stdin:
        words = line.split()
        for i in sorted(words):
                print(i, end=' ')
        print()
