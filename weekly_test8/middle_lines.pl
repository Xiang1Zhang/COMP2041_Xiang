#!/usr/bin/perl -w

$file = $ARGV[0];

open F, '<', $file or die "/bin/sh: ./middle_lines.pl: No such file or directory";
while ($line = <F>){
        push @lines, $line;

}


if (scalar @lines % 2 == 0){
        $num = scalar @lines;
        #print "$num\n";
        foreach $l (@lines){
                $count++;
                if ($num / 2 == $count){
                        print "$l";
                }
                if ($num / 2 == $count-1){
                        print "$l";
                }
        }
}

if (scalar @lines % 2 == 1){
        $num = scalar @lines;
        $num = $num + 1;
        foreach $l (@lines){
                $count++;
                if ($num / 2 == $count){
                        print "$l";
                }
        }
}
