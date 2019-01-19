#!/usr/bin/perl

use strict;
use warnings;

use File::Find::Rule;

my @html_files = File::Find::Rule->file()->name('*.html')->in('deploy');

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

sub header_info
{
  my $stream = $_[0];
  my %to_return;
  while (<$stream>)
  {
    last if ($_ =~ /\<\!DOCTYPE html\>/);
    my ($key, $value) = $_ =~ /(\S+)\s*(.*)/;
    $to_return{$key} = $value;
  }

  return \%to_return;
}

foreach (@html_files) {
  my $fn = $_;
  my $bk = $fn . ".bak";
  rename $fn, $bk;
  open my $in, '<', $bk or die "Couldn't open '$bk'.\n";
  open my $out, '>>', $fn or die "Couldn't open '$fn'.\n";

  my $cur_head = $head;
  my $cur_site_header = $site_header;

  my $hinfo = header_info $in;
  my $page_title_placeholder = '<!-- <h1>__PAGE_TITLE__</h1> -->';
  if (exists $hinfo->{PAGE_TITLE}) {
    $cur_site_header =~ s/$page_title_placeholder/<h1>$hinfo->{PAGE_TITLE}<\/h1>/;
  } else {
    $cur_site_header =~ s/$page_title_placeholder/<h1>Homepage of Tung Anh Vu<\/h1>/;
  }
  
  while (<$in>) {
    $_ =~ s/<!-- __HEAD__ -->/$cur_head/;
    $_ =~ s/<!-- __SITE_HEADER__ -->/$cur_site_header/;
    $_ =~ s/<!-- .*? -->//g;
    print $out $_;
  }
}

