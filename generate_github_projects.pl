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
## for reals
my $github_api_url = $Config->{'github'}->{'api_url'};
my $github_username = $Config->{'github'}->{'username'};
my $github_password = $Config->{'github'}->{'password'};

# setup user agent
my $ua = LWP::UserAgent->new();
$ua->credentials($github_api_url, $github_username, $github_password);

sub make_request($) {
  my $part = shift;
  my $url = $github_api_url . $part;
  my $response = $ua->get($url);
  print Dumper $response if $debug;
  if ( $response->is_success() ) {
    print "success!\n";
  } else {
    print "failed so hard!\n";
  }
}

make_request('');
make_request('foob');

