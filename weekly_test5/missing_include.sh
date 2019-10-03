#!/bin/sh

for f in $@
do
        while read line
        do
                if [[ $line =~ '"' ]]
                then
                        file=$(echo $line | cut -f2 -d'"')
                        if test ! -e $file
                        then
                                echo "$file included into $f does not exist"
                        fi
                fi
        done<$f
done
