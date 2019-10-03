#!/usr/bin/perl -w

while ($line = <STDIN>) {
	foreach $number (split /\s+/, $line) {
		if ($number) {
			push @numbers, $number;
		}
	}
}

foreach $number (@numbers) {
	my $n_factors = 0;
	for $possible_factors (@numbers) {
		if ($number %  $possible_factors == 0) {
			$n_factors++
		}
	}
	if ($n_factors == 1) {
		push @indivisible_numbers, $number;
	}
}
@sorted_indivisible_numbers = sort {$a <=> $b} @indivisible_numbers;

print "@sorted_indivisible_numbers\n";
