#!/usr/bin/python3
# put your demo script here

import sys
x = 1
while x < 10:
    y = 1
    while y <= x:
        sys.stdout.write("#")
        y = y * 2
    print()
    x = x + 1
    if x == 10:
        print("The end")