#!/bin/sh

for file in *.htm
do
        if test -e "${file%.htm}.html"
        then
                echo "${file%.htm}.html exists"
                exit 1
        else
                mv "$file" "${file%.htm}.html"

        fi
done
