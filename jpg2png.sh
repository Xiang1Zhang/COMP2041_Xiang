#!/bin/sh

for file in *.jpg
do
        #sed 's/.jpg/.png/g'
        #convert "${file%.jpg}.jpg" "${file%.jpg}.png"
        #rm "${file%.jpg}.jpg"
        if test -e "${file%.jpg}.png"
        then
                echo "${file%.jpg}.png already exists"
                exit 1
        else
#               sed 's/.jpg/.png/g'
#               rm "${file%.jpg}.jpg"
                convert "${file%.jpg}.jpg" "${file%.jpg}.png"
                rm "${file%.jpg}.jpg"

        fi
done
