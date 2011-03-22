#!/usr/bin/perl

use warnings;
use strict;

use Parse::AccessLogEntry;
use DateTime::Format::HTTP;
use Text::CSV_XS;

my $csv = Text::CSV_XS->new;
my $parser = Parse::AccessLogEntry->new;
my %hash;

while (<>) {
	my $ref = $parser->parse($_);
	my $datetime_str_apache = join " ", $ref->{date}, $ref->{time}, $ref->{diffgmt};
	my $dt = DateTime::Format::HTTP->parse_datetime($datetime_str_apache);
	my $datetime_str_GMT = join " ", $dt->ymd, $dt->hms;
	$dt->set_time_zone("Japan");
	my $datetime_str_JST = join " ", $dt->ymd, $dt->hms;

	my $path = $ref->{file};
	$hash{$dt->ymd}->{$path}->{count} += 1;
	push @{$hash{$dt->ymd}->{$path}->{info}}, {host => $ref->{host}, dt_gmt => $datetime_str_GMT, dt_jst => $datetime_str_JST};
}

for my $date (sort keys %hash) {
	for my $path (sort keys %{$hash{$date}}) {
#		print "$date\t$path\n";
#		print "  count: ", $hash{$date}->{$path}->{count}, "\n";
#		my $array = $hash{$date}->{$path}->{info};
#		my $i = 0;
#		for my $info (@$array) {
#			printf "    (%04d)", $i;
#			print "\t", $info->{dt_gmt}, "\t", $info->{dt_jst}, "\n";
#			$i++;
#		}

		my @csvsrc = ($date, $path, $hash{$date}->{$path}->{count});
		$csv->combine(@csvsrc);
		print $csv->string, "\n";
	}
}
