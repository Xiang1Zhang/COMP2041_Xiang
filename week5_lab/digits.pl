#!/usr/bin/perl -w

while($input=<STDIN>){
        $input=~tr/[0-4]/</;
        $input=~tr/[6-9]/>/;
        print $input;
}
