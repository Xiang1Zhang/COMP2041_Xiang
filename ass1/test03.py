#!/usr/bin/python3
# put your test script here

for i in range(0, 5):
    if i == 2:
        print(i)
i = 5
count = 0
while i < 50:
    k = i//2
    j = 2
    while j <= k:
        k = i % j
        if k == 0:
            count = count - 1
            break
        k = i/2
        j = j + 1
    count = count + 1
    i = i + 1
print(count)