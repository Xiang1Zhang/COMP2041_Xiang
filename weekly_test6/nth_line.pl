#!/usr/bin/perl -w
use warnings;

$num=$ARGV[0];
$f=$ARGV[1];
$current_line=0;

open F, '<', $f;
$num_lines=`wc -l $f | cut -f1 -d' '`;
if($num > $num_lines){
        print "";
}
else{
        while($line = <F>){
                #       push @lines, $line;
                        $current_line++;
                        if($current_line == $num){
                                print "$line";
                        }

        }
        close(F);
}
