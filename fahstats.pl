#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;
use JSON qw( decode_json );     # From CPAN
use Data::Dumper;               # Perl core module
use JSON::Parse 'parse_json';
use Time::HiRes qw(gettimeofday);
use File::Basename;

my $dirname = dirname(__FILE__);
my $utime =  gettimeofday;
my $host;
my $json;
my $ref_hash;
my $conf_ref_hash;
my @multijson;

my $configjson;
{
  local $/; #Enable 'slurp' mode
  open my $fh, "<", "$dirname/config.json";
  $configjson = <$fh>;
  close $fh;
}
$conf_ref_hash = decode_json($configjson);

my $pass = $conf_ref_hash->{'password'};

foreach $host( sort keys %{$conf_ref_hash->{'hosts'}}) {
	my $hostname =  $host;
	$host = $conf_ref_hash->{'hosts'}{$host};

	$json =  qx($dirname/fahquery.sh $host $pass);

	@multijson = split /\|/, $json;
	@multijson = grep /\S/, @multijson;

	foreach my $json (@multijson) {
		$ref_hash = decode_json($json);
		print "$hostname - State: $ref_hash->{'state'} Percent done: $ref_hash->{'percentdone'} PPD: $ref_hash->{'ppd'} TPF: $ref_hash->{'tpf'} ETA:  $ref_hash->{'eta'} SLOT: $ref_hash->{'slot'} Creditestimate: $ref_hash->{'creditestimate'}\n";

	}
}
