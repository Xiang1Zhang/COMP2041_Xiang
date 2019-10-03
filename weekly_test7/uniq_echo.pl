#!/usr/bin/perl -w

my @uniq;
my %seen;

foreach my $word (@ARGV) {
  if (! $seen{$word}++ ) {
    push @uniq, $word;
  }
}

foreach $word (@uniq){
        print "$word";
        print " ";
}
print "\n";
