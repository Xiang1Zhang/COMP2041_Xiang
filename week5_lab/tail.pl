#!/usr/bin/perl -w
$N = 10;
foreach $arg (@ARGV) {
        if ($arg eq "--version") {
                print "$0: version 0.1\n";
                exit 0;
        }
        elsif ($arg =~ /-[0-9]+/){
                $arg =~ s/-//g;
                $N =  $arg;
        }
        else{
                push @files, $arg;
        }
}

if (@files){
        foreach $f (@files) {
                open F, '<', $f or die "$0: Can't open $f: $!\n";
                if (scalar @files > 1) {
                        print "==> $f <==\n";
                }
                $numLines=`wc -l $f`;
                chomp $numLines;
                $numLines =~ s/ .*//g;
                $frontLines =  $numLines - $N;
                $current_line = 0;
                while($line = <F>){
                         $current_line++;
                        if ($current_line > $frontLines){
                                print $line;
                        }
                }
                close(F);
        }

}
else{
        $current_line = 0;
        while ($line = <STDIN>){
        push @lines, $line;
        $current_line++;
        if ($current_line > $N){
                last;
        }

        }
        $frontlines = $current_line - $N;
        $i = 0;
        foreach $l (@lines){
                $i++;
                if ($i > $frontlines){
                print $l;
                }
        }
}
