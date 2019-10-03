#!/usr/bin/perl -w

use strict;
my $num=$ARGV[0];

my @input = <STDIN>;
chomp @input;

foreach my $name (@input) {
    my $count;

    foreach my $compare_name (@input) {
        if ($name eq $compare_name) {
            $count += 1;
        }
    }
        if ($count==$num){
                print "Snap: $name\n";
                exit;
        }


}
