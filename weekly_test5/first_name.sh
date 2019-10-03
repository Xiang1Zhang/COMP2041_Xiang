#!/bin/sh

for file in $@
do
        cat $file | egrep "COMP[29]041" | cut -f2 -d',' | cut -f1 -d'|' | cut -f2 -d' ' | sort | uniq -c | sort -n | tail -1 | cut -c 9-
done
