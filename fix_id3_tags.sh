#!/bin/sh
#IFS=$'.mp3'
for file in "$@"
do
#       IFS='"${file}"/*.mp3'
#       echo "${file}"/*.mp3
        for music in "${file}"/*.mp3
        do
        echo "${music}"
#       echo "$music"
        title="`id3 -l "${music}" | sed -e ':a;N;s/\n//;ta' | cut -f1 -d'.' | cut -f3 -d'/' | sed 's/[0-9] - //g' | cut -f1 -d'-'`"
        id3 -t "$title" "${music}"
        artist="`id3 -l "${music}" | sed -e ':a;N;s/\n//;ta' | cut -f3 -d'-' | cut -f1 -d'.' | sed 's/^ //g'`"
        id3 -a "$artist" "${music}"
        album="`id3 -l "${music}" | sed -e ':a;N;s/\n//;ta' | cut -f2 -d'/'`"
        id3 -A "$album" "${music}"
        year="`id3 -l "${music}" | sed -e ':a;N;s/\n//;ta' | cut -f2 -d'/' | cut -f2 -d',' | sed 's/^ //g'`"
        id3 -y "$year" "${music}"
        track="`id3 -l "${music}" | sed -e ':a;N;s/\n//;ta' | cut -f3 -d'/' | cut -f1 -d' '`"
        id3 -T "$track" "${music}"
        done
done