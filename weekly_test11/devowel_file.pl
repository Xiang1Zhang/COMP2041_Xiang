#!/usr/bin/perl -w

$file = $ARGV[0];

open F, '<', $file or die "can't open file";
@oldfile = <F>;
close(F);

foreach (@oldfile){
	s/[aeiou]//ig;
}

open FILE, ">", $file or die "$!";
print FILE @oldfile;
close(FILE);