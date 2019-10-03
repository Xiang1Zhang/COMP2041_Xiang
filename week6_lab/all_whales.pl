#!/usr/bin/perl -w

use strict;

my %pods;
my %units;

foreach (my @input = <STDIN>) {
        chomp $_;
        my ($num, $name) = split / /, $_, 2;
        $name = lc $name;
        $name =~ s/  / /g;
        $name =~ s/ $//g;
        $name =~ s/^ *//g;
        $name =~ s/s$//g;

        if (exists $pods{$name}){
                $pods{$name}++;
                $units{$name} += $num;
        } else {
                $pods{$name} = 1;
                $units{$name} = $num;
        }
}


foreach (sort keys %pods){
        print "$_ observations: $pods{$_} pods, $units{$_} individuals\n";
}
