#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use URI;

my $fetcher = "wget";
my $result = GetOptions("fetcher=s" => \$fetcher);

open FILE, $ARGV[0] or die "can't open conf file: $ARGV[0]";
while (<FILE>) {
	chomp;
	next if (/^#/);
	my ($url, $level) = split;
	my $uri = URI->new($url);
	my ($proto, $host, $port, $rest) = ($uri->scheme, $uri->host, $uri->port, $uri->path);
	$rest =~ s|^/||;
	my $path;
	if ($fetcher eq "pavuk") {
		# for pavuk
		$path = $host . "_" . $port . "/" . $rest;
	} else {
		# for wget
		$path = $host . "/" . $rest;
	}

#{	print "proto=$proto, host=$host, port=$port, rest=$rest, path=$path\n";
	print "$url $level $path\n";
}
