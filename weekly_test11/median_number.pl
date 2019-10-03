#!/usr/bin/perl -w

$num = 0;
@list = sort{$a <=> $b} @ARGV;
foreach $arg (@list){
	$num = $num + 1;
	if (2*$num - 1 == scalar @ARGV){
		print "$arg\n";
	}
		
}