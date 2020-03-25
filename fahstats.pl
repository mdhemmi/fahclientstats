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
my $influxhost;
my $influxport;
my $influxdb;

my $configjson;
my $configfile = "$dirname/config.json";
if (-e $configfile) {
	{
  		local $/; #Enable 'slurp' mode
  		open my $fh, "<", $configfile;
  		$configjson = <$fh>;
  		close $fh;
	}
	$conf_ref_hash = decode_json($configjson);
} else {
	print "Please create config.json file as described in documentation.\n";
	exit 1;
}

my $pass = $conf_ref_hash->{'password'};

if (exists $conf_ref_hash->{'influxdb'})  { 
	$influxhost = $conf_ref_hash->{'influxdb'}{'ip'};	
	$influxport = $conf_ref_hash->{'influxdb'}{'port'};	
	$influxdb = $conf_ref_hash->{'influxdb'}{'db'};	

}

#nmap 192.168.0.0/24 -p36330 --open -oG - | awk '/36330\/open/{print $2}'

foreach $host( sort keys %{$conf_ref_hash->{'hosts'}}) {
	my $hostname =  $host;
	$host = $conf_ref_hash->{'hosts'}{$host};

	$json =  qx($dirname/fahquery.sh $host $pass);

	@multijson = split /\|/, $json;
	@multijson = grep /\S/, @multijson;

	foreach my $json (@multijson) {
		$ref_hash = decode_json($json);
		print "$hostname - State: $ref_hash->{'state'} Percent done: $ref_hash->{'percentdone'} PPD: $ref_hash->{'ppd'} TPF: $ref_hash->{'tpf'} ETA:  $ref_hash->{'eta'} SLOT: $ref_hash->{'slot'} Creditestimate: $ref_hash->{'creditestimate'}\n";
		chop($ref_hash->{'percentdone'});
		if (exists $conf_ref_hash->{'influxdb'})  {
			system "curl --output /dev/null --silent -i -XPOST 'http://$influxhost:$influxport/write?db=$influxdb' --data-binary 'percentdone,host=$hostname,slot=$ref_hash->{'slot'} value=$ref_hash->{'percentdone'}'";
			system "curl --output /dev/null --silent -i -XPOST 'http://$influxhost:$influxport/write?db=$influxdb' --data-binary 'ppd,host=$hostname,slot=$ref_hash->{'slot'} value=$ref_hash->{'ppd'}'";
			system "curl --output /dev/null --silent -i -XPOST 'http://$influxhost:$influxport/write?db=$influxdb' --data-binary 'creditestimate,host=$hostname,slot=$ref_hash->{'slot'} value=$ref_hash->{'creditestimate'}'";
		}
	}
}
