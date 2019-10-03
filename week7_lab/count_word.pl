#!/usr/bin/perl -w

use strict;
my $compare_word=$ARGV[0];
my $count=0;

while (my $line=<STDIN>){
#       chomp $line;
        $line = lc $line;
        my @words = split /[^a-z]+/, $line;
        foreach my $word (@words){
                if ($word eq $compare_word){
                        $count++;
                }
        }
}



print "$compare_word occurred $count times\n";
