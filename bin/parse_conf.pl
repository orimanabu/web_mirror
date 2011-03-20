#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

my $fetcher = "wget";
my $result = GetOptions("fetcher=s" => \$fetcher);

open FILE, $ARGV[0] or die "can't open conf file: $ARGV[0]";
while (<FILE>) {
	chomp;
	next if (/^#/);
	my ($url, $level) = split;
	$url =~ m|^([^:]+)://([^/]+)/(.*)|;
	my ($proto, $_host, $rest) = ($1, $2, $3);
	$_host =~ m|^([^:]+)(:(\d+))?|;
	my ($host, $port) = ($1, $3);
	$port = 80 unless $port;

	my $path;
	if ($fetcher eq "pavuk") {
		# for pavuk
		$path = $host . "_" . $port . "/" . $rest;
	} else {
		# for wget
		$path = $host . "/" . $rest;
	}

#	print "proto=$proto, host=$host, port=$port, rest=$rest\n";
	print "$url $level $path\n";
}
