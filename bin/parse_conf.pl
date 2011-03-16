#!/usr/bin/env perl

use strict;
use warnings;

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
	my $path = $host . "_" . $port . "/" . $rest;
#	print "proto=$proto, host=$host, port=$port, rest=$rest\n";
	print "$url $level $path\n";
}
