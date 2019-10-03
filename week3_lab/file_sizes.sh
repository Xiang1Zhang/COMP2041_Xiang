#!/bin/sh

small="Small files: "
medium="Medium-sized files: "
large="Large files: "

for n in *
do
        lines=$(wc -l <"$n")
        if test $lines -lt 10
        then
           small="$small $n"
        elif test $lines -lt 100
        then
           medium="$medium $n"
        else
           large="$large $n"
        fi

done

echo $small
echo $medium
echo $large
