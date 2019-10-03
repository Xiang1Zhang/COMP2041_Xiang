#!/usr/bin/perl -w


$course_code = $ARGV[0];

@url = ("http://www.handbook.unsw.edu.au/undergraduate/courses/current/$course_code.html","http://www.handbook.unsw.edu.au/postgraduate/courses/current/$course_code.html");

for $read_url (@url){
        $url = $read_url;
        open F, "wget -q -O- $url|" or die;
        while ($line = <F>) {
                if ($line =~ /.*Prerequisite.*/) {
                        $line =~ s/<\/p><p><strong>Excluded:.*//;
                        @prereq = $line =~ /[A-Z]{4}[0-9]{4}/g;
                        for $prereq (@prereq) {
                                print "$prereq\n";
                        }
                }
        }
}
