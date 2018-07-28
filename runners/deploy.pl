#!/usr/bin/perl

use strict;
use warnings;

opendir my $dh, ".";
my @dir_content = readdir $dh;
closedir $dh;

my @files = ();

foreach (@dir_content) {
  push @files, $_ if /.html$/;
}

