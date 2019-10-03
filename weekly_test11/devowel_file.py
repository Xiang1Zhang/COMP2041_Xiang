#!/usr/bin/python3

import sys
import re

with open(sys.argv[1], "r+") as file:

	line = file.read()

line = re.sub("[AaEeIiOoUu]", "", line)

file.close()
with open(sys.argv[1], "w") as file:
	file.write(line)
