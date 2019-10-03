#!/usr/bin/perl -w

use strict;

my $compare_word=$ARGV[0];
my $count=0;
my $total_words=0;

foreach my $file (glob "lyrics/*.txt") {
        open F, '<', $file or die "can't open $file";
        $count = 0;
        $total_words = 0;
        while (my $line = <F>){
#               chomp $line;
                $line = lc $line;
                my @words = split /[^a-z]+/, $line;
                foreach my $word (@words){
                        #print "WORD: |$word|\n" if ! $word;
                        $total_words++ if $word;
                        if ($word eq $compare_word){
                                $count++;
                        }
                }
        }
        $file =~ s/.txt//;
        $file =~ s/lyrics\///;    # "lyrics/"
        $file =~ s/_+/ /g;
	my $division = $count / $total_words;

        printf "%4d/%6d = %.9f %s\n", $count, $total_words, $division, $file;
}
