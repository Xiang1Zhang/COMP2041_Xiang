#!/usr/bin/python3

import sys;
import re;

for line in sys.stdin:
    print(re.sub("[6-9]", ">", re.sub("[0-4]", "<", line)), end = "")
