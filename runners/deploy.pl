#!/usr/bin/perl

use strict;
use warnings;

opendir my $dh, "deploy";
my @dir_content = readdir $dh;
closedir $dh;

my @html_files = ();

foreach (@dir_content) {
  push @html_files, "deploy/" . $_ if /.html$/;
}

my $head = undef;
{
  local $/;
  open my $fh, '<', "include/head.html" or die 1;
  $head = <$fh>;
}

my $site_header = undef;
{
  local $/;
  open my $fh, '<', "include/header.html" or die 1;
  $site_header = <$fh>
}

foreach (@html_files) {
  my $fn = $_;
  my $bk = $fn . ".bak";
  rename $fn, $bk;
  open my $in, '<', $bk or die "Couldn't open '$bk'.\n";
  open my $out, '>>', $fn or die "Couldn't open '$fn'.\n";
  while (<$in>) {
    $_ =~ s/<!-- __HEAD__ -->/$head/;
    $_ =~ s/<!-- __SITE_HEADER__ -->/$site_header/;
    $_ =~ s/<!-- .*? -->//g;
    print $out $_;
    # print STDERR $_;
  }
}

