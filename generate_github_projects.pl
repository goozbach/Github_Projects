#!/usr/bin/perl

use strict;
use warnings;

use Config::Tiny;
use Data::Dumper;
use LWP;

# debug flag
my $debug = 1;
# Create a config
my $Config = Config::Tiny->new();

# Open the config
$Config = Config::Tiny->read( 'mainconfig.ini' );

# Reading properties
## debug
my $root_config = $Config->{_};
my $github_config = $Config->{github};
## for reals
my $github_api_url = $Config->{'github'}->{'api_url'};

my $ua = LWP::UserAgent->new();
#$ua->credentials($out_uri->host() . ":" . $out_uri->port(), 'CORAID Control Node', $user, $pass);

# debug and main loop
print Dumper $root_config if $debug;
print Dumper $github_api_url if $debug;
