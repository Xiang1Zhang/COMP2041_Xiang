#!/bin/sh

num1=$1
num2=$2
file=$3

i=$num1
while((i<=$num2))
do
        echo $i
        i=$((i+1))
done >$file
