#!/usr/bin/perl

use warnings;
use strict;

use Getopt::Long;
use IO::Uncompress::Gunzip qw(gunzip $GunzipError);
use Parse::AccessLogEntry;
use DateTime::Format::HTTP;
use Text::CSV_XS;

my $csv = Text::CSV_XS->new({binary => 1, always_quote => 1});
my $parser = Parse::AccessLogEntry->new;
my $filter_regexp = "^.*\$";
my $debug = 0;
my %hash;

sub open_log {
	my $path = shift;
	my $handle;
	if ($path =~ /\.gz/) {
		$handle = new IO::Uncompress::Gunzip $path or die "gunzip failed: $GunzipError\n";
	} else {
		open FILE, $path or die "open $path failed\n";
		$handle = *FILE;
	}
	return $handle;
}

sub parse_log {
	my $logpath = shift;
	my $handle = open_log($logpath);
	while (<$handle>) {
		my $ref = $parser->parse($_);
		my $datetime_str_apache = join " ", $ref->{date}, $ref->{time}, $ref->{diffgmt};
		my $dt = DateTime::Format::HTTP->parse_datetime($datetime_str_apache);
		my $datetime_str_GMT = join " ", $dt->ymd, $dt->hms;
		$dt->set_time_zone("Japan");
		my $datetime_str_JST = join " ", $dt->ymd, $dt->hms;

		my $path = $ref->{file};
		next unless ($path =~ /$filter_regexp/);
		$hash{$dt->ymd}->{$path}->{count} += 1;
		push @{$hash{$dt->ymd}->{$path}->{info}}, {host => $ref->{host}, dt_gmt => $datetime_str_GMT, dt_jst => $datetime_str_JST};
	}
}

GetOptions(
	"filter=s" => \$filter_regexp,
	"debug" => \$debug
);

my @logs = @ARGV;
for my $logfile (@ARGV) {
	print "processing $logfile ...\n";
	parse_log($logfile);
}

for my $date (sort keys %hash) {
	for my $path (sort keys %{$hash{$date}}) {
		if ($debug) {
			print "debug: $date\t$path\n";
			print "debug:   count: ", $hash{$date}->{$path}->{count}, "\n";
			my $array = $hash{$date}->{$path}->{info};
			my $i = 0;
			for my $info (@$array) {
				printf "debug:     (%04d)", $i;
				print "\t", $info->{dt_gmt}, "\t", $info->{dt_jst}, "\n";
				$i++;
			}
		}

		my @csvsrc = ($date, $path, $hash{$date}->{$path}->{count});
		$csv->combine(@csvsrc);
		print $csv->string, "\n";
	}
}
