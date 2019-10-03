#!/usr/bin/python3
# put your test script here

import sys

number = 0
while number >= 0:
    sys.stdout.write("> ")
    number = int(sys.stdin.readline())
    if number >= 0:
        if number % 5 == 0:
            print("This number can be divided by 5")
        elif number % 2 == 0:
            print("This number can be divided by 2")
        else:
            print("This number can't be divided by 2 or 5")
print("Bye")