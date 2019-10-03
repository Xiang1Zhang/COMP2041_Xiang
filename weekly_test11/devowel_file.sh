#!/bin/sh

<$1 sed 's/[aeiou]//ig' > temp.txt
<temp.txt sed 's/[aeiou]//ig' > $1