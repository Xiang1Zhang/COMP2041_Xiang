#!/usr/bin/python3
import re, sys

def is_palindrome(s):
	s = s.lower()
	s = re.sub(r'[^a-z]', '', s)
	for i in range(len(s)//2):
		if s[i] != s[-(i+1)]:
			return False
	return True

print(is_palindrome(sys.argv[1]))