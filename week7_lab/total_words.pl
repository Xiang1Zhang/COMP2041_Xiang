#!/usr/bin/perl -w

use strict;

my $count = 0;
foreach (<STDIN>){
    foreach (split(/[^A-Za-z]+/)){
        if(/[A-Za-z]+/){
        $count++;
        }
    }
}

print("$count words\n");
