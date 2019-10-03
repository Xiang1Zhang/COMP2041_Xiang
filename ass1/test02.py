#!/usr/bin/python3
# put your test script here

import sys
sys.stdout.write("Input a number: ")
num = int(sys.stdin.readline())

while num < 10:
    y = 1
    while y <= num:
        sys.stdout.write("#")
        y = y + 1
    print()
    num = num + 1
    if num == 10:
        print("The end")