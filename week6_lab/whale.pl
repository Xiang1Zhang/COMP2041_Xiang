#!/usr/bin/perl -w

$name = "@ARGV";
$num_pod = 0;
$num_total = 0;

while($line = <STDIN>){
        chomp $line;

        if($line =~ /[0-9]* $name/g){
                $line =~ /([0-9]+)/;
                $num_total = $num_total + $1;
                $num_pod++;
                }

}

print "$name observations: $num_pod pods, $num_total individuals\n";

