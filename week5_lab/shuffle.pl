#!/usr/bin/perl -w

$count = 0;
while ($line = <STDIN>) {
        chomp($line);
        push @lines, $line;
        $count++;
}

$i = 0;

while ($i < $count) {
        $r = rand($count);
        if (($r =~ /[0-9]+/) && ($lines[$r] !~ 'noword')) {
                print "$lines[$r]\n";
                $lines[$r] = 'noword';
                $i++;
        }
}

