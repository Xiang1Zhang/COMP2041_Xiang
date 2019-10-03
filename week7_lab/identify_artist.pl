#!/usr/bin/perl -w

use strict;

my %count;
my %words;

foreach my $file (glob "lyrics/*.txt") {
        my $artist = $1 if $file =~ /\/(.*)\.txt$/;
        $artist =~ s/_/ /g;
        open F, '<', $file or die "can't open $file";

        while (my $line = <F>){
#               chomp $line;
                $line = lc $line;
                my @word = split /[^a-z]+/, $line;
                foreach my $w (@word){
                        if ($w){
                                $count{$artist}{$w}++;
                                $words{$artist}++;
                        }
                }
        }
        close(F);
}

while(my $file = shift){
    my %log_sum;
    open F, '<', $file or die "can't open $file";
    while(my $row = <F>){
        $row = lc $row;
        my @rows = split /[^a-z]+/, $row;
        foreach my $r (@rows){
            if($r){
                foreach (keys %words){
                    my $num = $count{$_}{$r} // 0;
                    my $single = log (($num+1)/$words{$_});
                    $log_sum{$_} += $single;
                }
            }
        }
    }

    my @sorted = sort {$log_sum{$b} <=> $log_sum{$a}} keys %log_sum;
    my $artist = $sorted[0];
    printf "%s most resembles the work of %s (log-probability=%.1f)\n", $file, $artist, $log_sum{$artist};
    close(F);
