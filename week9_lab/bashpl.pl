#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Cwd;

my $file = $ARGV[0];

open F, '<', $file or die "can't open $file";
while (my $line = <F>){
	chomp $line;
	if ($line =~ /#!/){
		$line =~ s/bin\/bash/usr\/bin\/perl -w/;
		print "$line\n";
	}
	elsif ($line =~ /^\s*#[^!].*/){
		print "$line\n";
	}
	elsif ($line =~ /^(\w+)\s*=\s*(.*)$/){
		print "\$";
		print "$line;\n";
	}
	elsif ($line =~ /^\s*$/){
		print "$line\n";
	}
	elsif ($line =~ /while/){
		$line =~ s/\(//;
		$line =~ s/\)//;
		#$line =~ s/([a-zA-Z]+)( [<=>]+ )([a-zA-Z]+)/\$$1$2\$$3/g;
		#$line =~ s/([a-zA-Z]+)( [!<=>]+ )([0-9]+)/\$$1$2$3/g;
		$line =~ s/([a-z]+)/\$$1/ig;
		$line =~ s/\$while/while/;
		print "$line {\n";
	}
	elsif ($line =~ /[a-zA-Z]+=\$/){
		#$line =~ s/([a-zA-Z]+)(=)(\$[a-zA-Z]+)/\$$1 $2 $3/g;
		#$line =~ s/([a-z]+)=\$\(\(([a-z]+) ([+-]) ([a-z]+)\)\)/\$$1 = \$$2 $3 \$$4/ig;
		#$line =~ s/([a-z]+)=\$\(\(([a-z]+) ([+-\/]) ([0-9]+)\)\)/\$$1 = \$$2 $3 $4/ig;
		#$line =~ s/([a-z]+)=\$\(\(([0-9]+ [*]) ([a-z]+) ([+-\/]) ([0-9]+)\)\)/\$$1 = $2 \$$3 $4 $5/ig;
		$line =~ s/([a-z]+)=\$\(\((.*)\)\)/$1 = $2/ig;
		$line =~ s/([a-z]+)=\$([a-z]+)/$1 = $2/ig;
		$line =~ s/([a-z]+)/\$$1/ig;
		
		print "$line;\n";
	}
	elsif ($line =~ /done/){
		$line =~ s/done/}/;
		print "$line\n";
	}
	elsif ($line =~ /echo/){
		$line =~ s/echo /print "/;
		print "$line\\n\";\n";
	}
	elsif ($line =~ /if/){
		$line =~ s/\(//;
                $line =~ s/\)//;
		#$line =~ s/([a-z]+) ([%]) ([0-9]+) (==) ([0-9]+)/\$$1 $2 $3 $4 $5/ig;
		#$line =~ s/([a-z]+) ([*]) ([a-z]+) ([+-]) ([a-z]+) ([*]) ([a-z]+) (==) ([a-z]+) ([*]) ([a-z]+)/\$$1 $2 \$$3 $4 \$$5 $6 \$$7 $8 \$$9 $10 \$$11/ig;
		$line =~ s/([a-z]+)/\$$1/ig;
		$line =~ s/\$if/if/;
		print "$line {\n";
	}
	elsif ($line =~ /fi/){
                $line =~ s/fi/}/;
                print "$line\n";
        }
	elsif ($line =~ /else/){
		print "} ";
		print "$line {\n";
	}

}
close(F);
