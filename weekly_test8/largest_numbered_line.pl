#!/usr/bin/perl -w

while ($line = <STDIN>){
        chomp $line;
        push @lines, $line;
        $line =~ s/\$//g;
        @input = split /(-?[0-9]*\.?[0-9]*)/, $line;
        foreach $l (@input){
                #print "$l";
                if ($l =~ /-?[0-9]+\.?[0-9]*/){
                        push @num, $l;
                }
        }
}

if (@num){
        $max = $num[0];
        foreach $n (@num){
                #print "$n\n";
                if ($n > $max){
                        $max = $n;
                }
        }
#       print "$max\n";

        foreach $input_line (@lines){
                #print "$input_line\n";
                if ($input_line =~ /\Q$max\E/){
                        print "$input_line\n";
                }
        }
}
