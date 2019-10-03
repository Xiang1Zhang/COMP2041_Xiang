#!/usr/bin/perl -w

%seen = ();
$url = "http://www.timetable.unsw.edu.au/current/${ARGV[0]}KENS.html";

open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
        push(@lines, $line =~ /[A-Z]{4}[0-9]{4}/g);
}
close (F);

foreach $line (@lines) {
        $seen{$line}++;
}
@courses = keys %seen;

foreach $course (sort @courses) {
        print "$course\n";
}
