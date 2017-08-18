#!/bin/bash

for file in "$@"
do

        read -p "Address to e-mail this image to? " address
        if  test -n $address
        then
                read -p "Message to accompany image? " message
                echo "$message" | mutt -s 'image' -a "$file" -- "$address"
                echo "$file sent to $address"
        else
                echo "Please enter an e-mail adress!"
                exit 1
        fi


done
