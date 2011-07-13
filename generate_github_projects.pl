#!/usr/bin/perl

use strict;
use warnings;

use Config::Tiny;
use Data::Dumper;
use LWP;
use Carp;
use JSON::Any;

# debug flag
my $debug = 0;
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
    carp "success!\n" if $debug;
    return $response->content();
  } else {
    carp "failed so hard!\n" if $debug;
    return undef;
  }
}

my $content = make_request('users/goozbach/repos');

my $repos = JSON::Any->decode($content);

my @clean_repos;

foreach my $repo_hash ( @$repos ) {
  if ( $$repo_hash{'fork'} ) {
    print "$$repo_hash{'name'} is a fork\n" if $debug;
  } else {
    push @clean_repos, $repo_hash;
  }
}

my @sorted_repos = sort { $b->{'pushed_at'} cmp $a->{'pushed_at'} } @clean_repos; 

# second loop
foreach my $repo_hash ( @sorted_repos ) {
  print "$$repo_hash{'name'} pushed at \t\t$$repo_hash{'pushed_at'}\n";
}
