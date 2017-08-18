#!/bin/bash

for file in $@
do
        month="`ls -l $file | cut -f6 -d' '`"
        day="`ls -l $file | cut -f7 -d' '`"
        time="`ls -l $file | cut -f8 -d' '`"
        modify="$month $day $time"
        echo $modify
        convert -gravity south -pointsize 36 -draw "text 0,10 '$modify'" $file output.jpg
        rm "$file"
        convert "output.jpg" "$file"

done
