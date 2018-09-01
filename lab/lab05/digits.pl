#!/usr/bin/perl -w
while (<>) {
  tr/0-9/<<<<<5>>>>/;
  print;
}
