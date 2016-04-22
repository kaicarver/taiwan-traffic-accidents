# Interprets accident data from http://data.gov.tw/node/12197
# Prints the number of deaths in accidents involving a bicycle
# and counts the total number of each kind of vehicle
# Usage: cat *.csv | perl parse.pl
use v5.10;
use strict;
use warnings;

my $numdeaths = 0;
my %vehicles = ();

while (<>) {
    chomp;
    my @f = split /,/;
    if (/死亡([1-9][0-9]*).*自行車/) {
	$numdeaths += $1;
	my $v = $f[3];
	$v =~ s/\s//g; # remove CR/LF junk
	for (split(/;/,$v)) {
	    $vehicles{$_}++;
	}
    }
}

say "total deaths = $numdeaths\n";
say "$_ $vehicles{$_}" for (sort keys %vehicles);
