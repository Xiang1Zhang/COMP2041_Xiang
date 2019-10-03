#!/usr/bin/python3

import sys

if len(sys.argv) != 3:
        print("Usage: ./echon.py <number of lines> <string>")
elif (sys.argv[1]).isdigit() and int(sys.argv[1]) >= 0:
        print((sys.argv[2] + "\n") * int(sys.argv[1]), end = "")
else:
        print("./echon.py: argument 1 must be a non-negative integer")
