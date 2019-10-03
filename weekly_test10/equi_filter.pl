#!/usr/bin/perl -w

while ($line = <STDIN>) {
	@words = split /\s+/, $line;
	foreach $word (@words){
		@letters = split //, lc $word;
		%letter_count = ();
		foreach $letter (@letters){
			$letter_count{$letter}++;
		}
		$value1 = 0;
                $equi = 0;
		
		foreach $value (values %letter_count) {
			if ($value1 == 0){
				$value1 = $value;
			}
			if ($value1 == $value){
				$equi = 1;
			}
			else{
				$equi = 0;
				last;
			}
		}
		if ($equi == 1){
			print "$word ";
		}
	}
	print "\n";
}

