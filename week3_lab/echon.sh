#!/bin/sh

if test $# -eq 2
then
        if `test $1 -ge 0 2>/dev/null`
        then
                for n in $(seq 1 $1)
                do
                        echo "$2"
                done
                exit 0
                #echo "$0: argument 1 must be a non-negative integer"
                #exit 2

        else
                #for n in $(seq 1 $1)   
                #do 
                        #echo "$2"
                #done
                #exit 0 
                        echo "$0: argument 1 must be a non-negative integer"
                        exit 2
        fi
