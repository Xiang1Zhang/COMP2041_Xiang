#!/usr/bin/perl -w

if($#ARGV != 1){
        die "Usage: ./echon.pl <number of lines> <string>\n";


}

$num=$ARGV[0];
$string=$ARGV[1];
if($num =~ /^\d+$/){

if($num >= 0){
        for($i=0;$i<$num;$i++){
                print "$string\n";
        }
}
}
else{
        print "./echon.pl: argument 1 must be a non-negative integer\n";
}
