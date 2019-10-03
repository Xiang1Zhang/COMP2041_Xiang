#!/usr/bin/python3

import sys
import re

lines = []
s = []
num = int(sys.argv[1])
for line in sys.stdin:
        line = line.lower()
        line = re.sub(r"\s+", " ", line)
        line = re.sub(r"^\s+", "", line)
        lines.append(line)

line_num = 0
count = 0
for i in lines:
        line_num = line_num + 1
        if i not in s:
                s.append(i)
                count = count + 1
        if count == num:
                print(str(count) + " distinct lines seen after " + str(line_num) + " lines read.")
                break

if count < num:
        print("End of input reached after "+ str(line_num) + " lines read -  " + str(num) + " different lines not seen.")
