#!/usr/bin/perl -w

# Starting point for COMP[29]041 assignment 1
# http://www.cse.unsw.edu.au/~cs2041/assignments/pypl
# written by Xiang Zhang in September 2017
	

# iden is used to print out the right curly braces
$iden = 0;
$line_count = 0;
while ($line = <>) {
    if ($line =~ /^#!/ && $. == 1) {

        # translate #! line

        print "#!/usr/bin/perl -w\n";

    } elsif ($line =~ /^\s*(#|$)/) {

        # Blank & comment lines can be passed unchanged

        print $line;

    } elsif ($line =~ /^\s*print\("(.*)"\)$/) {
    } elsif ($line =~ /^print\("(.*)"\)$/) {

        # Python's print outputs a new-line character by default
        # so we need to add it explicitly to the Perl print statement

	if ($iden > 2){
                print "        }\n";
	}
	if ($iden > 1){
                print "    }\n";
	}
	if ($iden > 0){
                print "}\n";
        }

        print "print \"$1\\n\";\n";

    } elsif ($line =~ /^\s*print\((\w+)\)$/) {
	
	$iden = 0;

    } elsif ($line =~ /^print\((\w+)\)$/) {
	if ($iden > 2){
                print "        }\n";
        }
        if ($iden > 1){
                print "    }\n";   
        }
        if ($iden > 0){
                print "}\n";
        }


	print "print \"\$$1\\n\";\n";

    } elsif ($line =~ /^\s*print\(.*\)$/) {
        $iden = 0;

    } elsif ($line =~ /^print\(.*\)$/) {
	if ($iden > 2){
                print "        }\n";
        }
        if ($iden > 1){
                print "    }\n";   
        }
        if ($iden > 0){
                print "}\n";
        }


	$line =~ s/\(/ /;
	$line =~ s/\)/,/;
	$line =~ s/([a-z]+[0-9]*)/\$$1/ig;
	if ($line =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
        	$line =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
        }
	$line =~ s/\$print/print/;
	$line =~ s/(,)/$1 "\\n";/;
	if ($line =~ /%/){
		$line =~ s/"\%\$[a-z]+[0-9]* (\$[a-z]+[0-9]*)" \% (\$[a-z]+[0-9]*_?[a-z]+[0-9]*), "\\n"/"$2 $1\\n"/i;
	}
	print "$line\n";

	$iden = 0;
    } elsif ($line =~ /^print\(.*, end=\'\'\)/){
	if ($iden > 2){
                print "        }\n";
        }
        if ($iden > 1){
                print "    }\n";
        }
        if ($iden > 0){
                print "}\n";
        }

        $line =~ s/\(/ /;
        $line =~ s/, end=''\)/;/;
        $line =~ s/([a-z]+[0-9]*)\[([a-z]+[0-9]*)\]/\$$1\[\$$2\]/ig;
        print "$line";
	$iden = 0;

    } elsif ($line =~ /^\w+ = .*$/){
	if ($iden > 2){
                print "        }\n";
        }
        if ($iden > 1){
                print "    }\n";   
        }
        if ($iden > 0){
                print "}\n";
        }


        $iden = 0;

	chomp $line;
        # Assign $ to variables
	
	$line =~ s/\/\//\//;	
	$line =~ s/([a-z]+[0-9]*)/\$$1/ig;
        print "$line;\n";
	if ($line =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
		$line =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
	}
	if ($line =~ /\$sys\.\$stdin\.\$readline/){
		$line =~ s/\$int\(\$sys\.\$stdin\.\$readline\(\)\)/\<STDIN\>/;
	}
	if ($line =~ /\$len\(.*\)/){
		$line =~ s/\$len\(\$(.*)\)/\@$1/;
		if ($line_count == 1){
			$line =~ s/(\$[a-z]+[0-9]*_?[a-z]*[0-9]*) = \@$1/    $1\+\+/i;
		}
	}
	if ($line =~ /\$[a-z]+[0-9]* = \[\]/){
		#print "$1\n";
		$line =~ s/\$[a-z]+[0-9]*//ig;
		$line =~ s/ = \[\]//;
		print "$line";
	}
	elsif ($line =~ /\$readlines/){
                $line =~ s/\$[a-z]+[0-9]* = \$sys\.\$stdin\.\$readlines\(\)/while \(\<STDIN\>\) {/;
		$line_count = 1;
		print "$line\n";
        }

    } elsif ($line =~ /while/) {
	else {
        	print "$line;\n";
		if ($line_count == 1){
			print "}\n";
			$line_count = 0;
		}
	}

    } elsif ($line =~ /while.*: /) {

	#deal with the while loop
	#deal with the single-line while loop
	@while = split /(:|;)/, $line;
	foreach $l (@while){
		#print "$l\n";
		if ($l =~ /while/){
			$l =~ s/([a-z]+[0-9]*)/\$$1/ig;
			$l =~ s/\$while /while \(/;
			print "$l";
		}
		elsif ($l =~ /:/){
			$l =~ s/:/\) \{/;
			print "$l";
			print "\n";
		}
		elsif ($l =~ /^\s*print\((\w+)\)$/){

		        print "print \"\$$1\\n\";\n";
		        print "    print \"\$$1\\n\";\n";
		}
		elsif ($l =~ /^\s*\w+ = .*$/){
        		chomp $l;
        		# Assign $ to variables

			$l =~ s/\/\//\//;
        		$l =~ s/([a-z]+[0-9]*)/\$$1/ig;
        		print "$l;\n";
			if ($l =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
                		$l =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
        		}

        		print "    $l;\n";
		}
		elsif ($l =~ /;/){
			#print "";
		}
		else{
			print "$l;\n";
			print "    $l;\n";
		}
	}
	print "}\n";
     } elsif ($line =~ /while.*:$/) {

        #deal with the multi-lines while loop
        #foreach $l (@while){
                #print "$l\n";
                $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
                $line =~ s/\$while /while \(/;
                $line =~ s/:/\) \{/;
		print "$line";      
        #}
        #print "}\n";

    } elsif ($line =~ /if/) {

        #deal with the if statement
    } elsif ($line =~ /if.*: /) {

        #deal with the single-line if statement
        @if = split /(:|;)/, $line;
        foreach $l (@if){
                #print "$l\n";
                if ($l =~ /if/){
                        $l =~ s/([a-z]+[0-9]*)/\$$1/ig;
                        $l =~ s/\$if /if \(/;
                        print "$l";
                }
                elsif ($l =~ /:/){
                        $l =~ s/:/\) \{/;
                        print "$l";
                        print "\n";
                }
                elsif ($l =~ /^\s*print\((\w+)\)$/){

                        print "print \"\$$1\\n\";\n";
                        print "    print \"\$$1\\n\";\n";
                }
                elsif ($l =~ /^\s*\w+ = .*$/){
                        chomp $l;
                        # Assign $ to variables

			$l =~ s/\/\//\//;
                        $l =~ s/([a-z]+[0-9]*)/\$$1/ig;
                        print "$l;\n";
                        print "    $l;\n";
                }
		elsif ($l =~ /;/){
                        #print "";
                }
                else{
                        print "$l;\n";
                        print "    $l;\n";
                }
        }
        print "}\n";

    } elsif ($line =~ /^\s*if.*:$/) {

        #deal with the multi-lines if statement
                #print "$l\n";
                $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
                $line =~ s/\$if /if \(/;
                $line =~ s/:/\) \{/;
                print "$line";
        #print "}\n";
    } elsif ($line =~ /elif.*:$/) {

        #deal with the multi-lines elif statement
                #print "$l\n";
                $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
                $line =~ s/\$elif /\} elsif \(/;
                $line =~ s/:/\) \{/;
                print "$line";
        #print "}\n";

    } elsif ($line =~ /else.*:$/) {

        #deal with the multi-lines else statement
                #print "$l\n";
                #$line =~ s/([a-z]+[0-9]*)/\$$1/ig;
                $line =~ s/else/\} else /;
		$line =~ s/:/\{/;		
                print "$line";
        #print "}\n";


    } elsif ($line =~ /for/) {
	
	# deal with for loop
	$line =~ s/in range//;
	$line =~ s/([a-z]+[0-9]*)/\$$1/ig;
	$line =~ s/\$for/foreach/;
	if ($line =~ /, (\d+)/) {
		$num = $1 - 1;
		$line =~ s/\((\d+), (\d+)\):/\($1..$num\) {/;
	}
	elsif ($line =~ /, \$[a-z]+[0-9]* [+-] (\d+)/i){
                $num = $1 - 1;
		if ($num == 0){
			$line =~ s/\((\d+), (\$[a-z]+[0-9]*) [+-] (\d+)\):/\($1..$2\) {/;
		}
		else {
                	$line =~ s/\((\d+), (\$[a-z]+[0-9]* [+-]) (\d+)\):/\($1..$2 $num\) {/;
		}
	}
	if ($line =~ /\$in \$sys/){
		$line =~ s/\$in \$sys\.\$stdin:/\(\<STDIN\>\) {/;
	}
	print "$line";

    } elsif ($line =~ /^\s{4}[a-z]+/){

	#deal with the line starting with 4 spaces
	#push @lines, $line;
	#foreach $l (@lines) {
		if ($iden > 1){
			print "    }\n";
		}
		$iden = 1;
		if ($line =~ /^\s*print\((\w+)\)$/){
                       print "    print \"\$$1\\n\";\n";
		}
		elsif ($line =~ /^\s*print\("(.*)"\)$/) {
        	        print "    print \"$1\\n\";\n";
		}
		elsif ($line =~ /^\s*print\(\)$/) {
                        print "    print \"\\n\";\n";
                }
		elsif ($line =~ /^\s*print\(.*, end=\'\'\)/){
			$line =~ s/\(/ /;
			$line =~ s/, end=''\)/;/;
			$line =~ s/([a-z]+[0-9]*)\[([a-z]+[0-9]*)\]/\$$1\[\$$2\]/ig;
			print "$line";
		}

		elsif ($line =~ /^\s*\w+ = .*$/){
                        chomp $line;
                        # Assign $ to variables
                        $line =~ s/\/\//\//;
                        $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
			if ($line =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
		                $line =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
        		}

			if ($line =~ /\$sys\.\$stdin\.\$readline/){
                		$line =~ s/\$int\(\$sys\.\$stdin\.\$readline\(\)\)/\<STDIN\>/;
   			}
			if ($line =~ /\$len\(.*\)/){
                		$line =~ s/\$len\(\$(.*)\)/\@$1/;
        		}


                        print "$line;\n";
		}
		elsif ($line =~ /break/) {
			$l =~ s/break/last;/;
			print "$line"
		}
		elsif ($line =~ /sys\.stdout\.write/) {
                        $line =~ s/sys\.stdout\.write/print/;
                        $line =~ s/\(/ /;
                        $line =~ s/\)/;/;
                        print "$line";
                }
		elsif ($line =~ /\.append/) {
                        #deal with push variable into array
                        
                        $line =~ s/([a-z]+[0-9]*)\.append\(([a-z]+[0-9]*)\)/push \@$1, \$$2;/ig;
			print "$line";
                }

	

	#}
	
    } elsif ($line =~ /^\s{8}[a-z]+/){

        #deal with the line starting with 8 spaces
        #push @lines, $line;
        #foreach $l (@lines) {
		if ($iden > 2){
			print "        }\n";
		}
		$iden = 2;
                if ($line =~ /^\s*print\((\w+)\)$/){
                       print "        print \"\$$1\\n\";\n";
                }
                elsif ($line =~ /^\s*print\("(.*)"\)$/) {
                        print "        print \"$1\\n\";\n";
                }
		elsif ($line =~ /^\s*print\(\)$/) {
                        print "        print \"\\n\";\n";
                }
		elsif ($line =~ /^\s*print\(.*, end=\'\'\)/){
                        $line =~ s/\(/ /;
                        $line =~ s/, end=''\)/;/;
                        $line =~ s/([a-z]+[0-9]*)\[([a-z]+[0-9]*)\]/\$$1\[\$$2\]/ig;
                        print "$line";
		}

                elsif ($line =~ /^\s*\w+ = .*$/){
                       chomp $line;
                        # Assign $ to variables
                        $line =~ s/\/\//\//;
                        $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
			if ($line =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
                                $line =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
                        }

			if ($line =~ /\$sys\.\$stdin\.\$readline/){
                                $line =~ s/\$int\(\$sys\.\$stdin\.\$readline\(\)\)/\<STDIN\>/;
                        }
			if ($line =~ /\$len\(.*\)/){
		                $line =~ s/\$len\(\$(.*)\)/\@$1/;
        		}


                        print "$line;\n";
                }
		elsif ($line =~ /break/) {
                        $line =~ s/break/last;/;
                        print "$line"
                }
		elsif ($line =~ /sys\.stdout\.write/) {
                        $line =~ s/sys\.stdout\.write/print/;
                        $line =~ s/\(/ /;
                        $line =~ s/\)/;/;
                        print "$line";
                }
		elsif ($line =~ /\.append/) {
                        #deal with push variable into array
                        $line =~ s/([a-z]+[0-9]*)\.append\(([a-z]+[0-9]*)\)/push \@$1, \$$2;/ig;
			print "$line";
                }



        #}

    } elsif ($line =~ /^\s{12}[a-z]+/){

        #deal with the line starting with 12 spaces
        #push @lines, $line;
        #foreach $l (@lines) {
		if ($iden > 3){
                        print "            }\n";
                }
                $iden = 3;

                if ($line =~ /^\s*print\((\w+)\)$/){
                       print "            print \"\$$1\\n\";\n";
                }
                elsif ($line =~ /^\s*print\("(.*)"\)$/) {
                        print "            print \"$1\\n\";\n";
                }
		elsif ($line =~ /^\s*print\(\)$/) {
			print "            print \"\\n\";\n";
		}
		elsif ($line =~ /^\s*print\(.*, end=\'\'\)/){
                        $line =~ s/\(/ /;
                        $line =~ s/, end=''\)/;/;
                        $line =~ s/([a-z]+[0-9]*)\[([a-z]+[0-9]*)\]/\$$1\[\$$2\]/ig;
                        print "$line";
                }

                elsif ($line =~ /^\s*\w+ = .*$/){
                       chomp $line;
                        # Assign $ to variables
                        $line =~ s/\/\//\//;
                        $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
			if ($line =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
                                $line =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
                        }

			if ($line =~ /\$sys\.\$stdin\.\$readline/){
                                $line =~ s/\$int\(\$sys\.\$stdin\.\$readline\(\)\)/\<STDIN\>/;
                        }
			if ($line =~ /\$len\(.*\)/){
                		$line =~ s/\$len\(\$(.*)\)/\@$1/;
		        }

                        print "$line;\n";
                }
		elsif ($line =~ /break/) {
                        $line =~ s/break/last;/;
                        print "$line"
                }

		elsif ($line =~ /sys\.stdout\.write/) {
        		$line =~ s/sys\.stdout\.write/print/;
        		$line =~ s/\(/ /;
        		$line =~ s/\)/;/;
        		print "$line";
		}
		elsif ($line =~ /\.append/) {
        		#deal with push variable into array
        		$line =~ s/([a-z]+[0-9]*)\.append\(([a-z]+[0-9]*)\)/push \@$1, \$$2;/ig;
			print "$line";
		}

        #}

    } elsif ($line =~ /^\s{16}[a-z]+/){

        #deal with the line starting with 16 spaces
        #push @lines, $line;
        #foreach $l (@lines) {
                if ($iden > 3){
                        print "            }\n";
                }
                $iden = 3;

                if ($line =~ /^\s*print\((\w+)\)$/){
                       print "            print \"\$$1\\n\";\n";
                }
                elsif ($line =~ /^\s*print\("(.*)"\)$/) {
                        print "            print \"$1\\n\";\n";
                }
                elsif ($line =~ /^\s*print\(\)$/) {
                        print "            print \"\\n\";\n";
                }
                elsif ($line =~ /^\s*print\(.*, end=\'\'\)/){
                        $line =~ s/\(/ /;
                        $line =~ s/, end=''\)/;/;
                        $line =~ s/([a-z]+[0-9]*)\[([a-z]+[0-9]*)\]/\$$1\[\$$2\]/ig;
                        print "$line";
                }
		elsif ($line =~ /^\s*\w+ = .*$/){
                       chomp $line;
                        # Assign $ to variables
                        $line =~ s/\/\//\//;
                        $line =~ s/([a-z]+[0-9]*)/\$$1/ig;
			if ($line =~ /\$[a-z]+[0-9]*\_\$[a-z]+[0-9]*/i){
                                $line =~ s/(\$[a-z]+[0-9]*)\_\$([a-z]+[0-9]*)/$1\_$2/ig;
                        }

                        if ($line =~ /\$sys\.\$stdin\.\$readline/){
                                $line =~ s/\$int\(\$sys\.\$stdin\.\$readline\(\)\)/\<STDIN\>/;
                        }
                        if ($line =~ /\$len\(.*\)/){
                                $line =~ s/\$len\(\$(.*)\)/\@$1/;
                        }

                        print "$line;\n";
                }
                elsif ($line =~ /break/) {
                        $line =~ s/break/last;/;
                        print "$line"
                }

                elsif ($line =~ /sys\.stdout\.write/) {
                        $line =~ s/sys\.stdout\.write/print/;
                        $line =~ s/\(/ /;
                        $line =~ s/\)/;/;
                        print "$line";
                }
                elsif ($line =~ /\.append/) {
			#deal with push variable into array
                        $line =~ s/([a-z]+[0-9]*)\.append\(([a-z]+[0-9]*)\)/push \@$1, \$$2;/ig;
                        print "$line";
                }

        #}

	

    } elsif ($line =~ /import sys/) {
	print "";
	
    } elsif ($line =~ /sys\.stdout\.write/) {
        $line =~ s/sys\.stdout\.write/print/;
	$line =~ s/\(/ /;
	$line =~ s/\)/;/;
	print "$line";

    } elsif ($line =~ /\.append/) {
	#deal with push variable into array
	$line =~ s/([a-z]+[0-9]*)\.append\(([a-z]+[0-9]*)\)/push \@$1, \$$2;/ig;
	print "$line";

    } else {
    
        # Lines we can't translate are turned into comments

        print "#$line\n";
        print "#$line";
    }

}

#print out the right curly braces for the end of the scripts
if ($iden > 2){
	print "        }\n";
}
if ($iden > 1){
	print "    }\n";
}
if ($iden > 0){
	print "}\n";
}