#!/usr/bin/perl

use strict;
use warnings;

use Config::Tiny;
use Data::Dumper;

# Create a config
my $Config = Config::Tiny->new();

# Open the config
$Config = Config::Tiny->read( 'mainconfig.ini' );

# Reading properties
my $root_config = $Config->{_};
my $github_config = $Config->{github};

print Dumper $root_config;
print Dumper $github_config;
