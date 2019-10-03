#!/usr/bin/perl -w

use strict;
my $num = $ARGV[0];
my @input;
my %count;
my $count_num;
my $line_num;
while (my $line = <STDIN>){
        chomp $line;
        $line = lc $line;
        $line =~ s/\s+/ /g;
        $line =~ s/^\s+//g;
        if (!exists $count{$line}){
                $count{$line} = 1;
                $count_num++;
                if ($num == $count_num){
                        $line_num = $.;
                }
        }

}
#print "$count_num\n";
if ($num == $count_num){
        print "$num distinct lines seen after $line_num lines read.\n";
        }
elsif ($num < $count_num){
        print "$num distinct lines seen after $line_num lines read.\n";
}
else{
        print "End of input reached after $. lines read - $num different lines not seen.\n";
}
